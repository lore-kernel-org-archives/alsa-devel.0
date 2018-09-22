From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [RFC] ALSA: usb-audio: Add custom mixer status
 quirks for RME CC devices
Date: Sat, 22 Sep 2018 11:31:48 +0300
Message-ID: <bcdb6861-173f-3a81-527f-bcf0a3b0a87e@sonarnerd.net>
References: <1537481240-4999-1-git-send-email-jussi@sonarnerd.net>
 <s5h7ejfuyex.wl-tiwai@suse.de>
 <76bd64a6-6d83-912d-e2e3-ec2c4c191dd2@sonarnerd.net>
 <s5h36u344wd.wl-tiwai@suse.de>
 <991e0673-32b7-c9e4-ae3d-1dc15601f3f1@sonarnerd.net>
 <s5h5zyz2e58.wl-tiwai@suse.de>
 <02061084-ce07-2681-ddbf-f15d93b24ee4@sonarnerd.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7A72996EE30B819C7DB7D9E9"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 51DF8267892
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2018 10:31:51 +0200 (CEST)
In-Reply-To: <02061084-ce07-2681-ddbf-f15d93b24ee4@sonarnerd.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------7A72996EE30B819C7DB7D9E9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.09.2018 16:26, Jussi Laako wrote:
> On 21.09.2018 16:06, Takashi Iwai wrote:
>> On Fri, 21 Sep 2018 14:53:20 +0200,
>> Jussi Laako wrote:
>>>
>>> On 21.09.2018 11:43, Takashi Iwai wrote:
>>>> On Fri, 21 Sep 2018 10:35:49 +0200,
>>>> Jussi Laako wrote:
>>>>>
>>>>>> The caching is currently enabled for all elements, but changing it
>>>>>> should be trivial.  The patch below adds is_volatile flag to the
>>>>>> element, and you can set it to true in the quirk somehow for uncached
>>>>>> controls.
>>>>>
>>>>> This patch looks good and what I need! When trying to figure out where
>>>>> it is safe to set the volatile flag I thought that I could set it
>>>>> transparently in add_single_ctl_with_resume() in mixer_quirks.c based
>>>>> on the SNDRV_CTL_ELEM_ACCESS_VOLATILE flag in provided
>>>>> snd_kcontrol_new access-member. However, add_single_ctl_with_resume()
>>>>> is allocating just size of usb_mixer_elem_list unlike
>>>>> snd_create_std_mono_ctl_offset() which in turn is allocating full
>>>>> usb_mixer_elem_info size. However, the mixer code seems to be assuming
>>>>> that the item is always usb_mixer_elem_info instead of just list
>>>>> header item. Is this allocation behavior correct and is the item
>>>>> turned into usb_mixer_elem_info somewhere, or is this some kind of
>>>>> bug? So can I safely turn the allocation in
>>>>> add_single_ctl_with_resume() into zero initialized usb_mixer_elem_info
>>>>> instead and set the flag there while keeping correct behavior, or am I
>>>>> missing something?
>>>>
>>>> We can check SNDRV_CTL_ELEM_ACCESS_VOLATILE instead of introducing a
>>>> new flag like my patch, yes.  It's just a matter of easiness.
>>>> Since there is no link from usb_mixer_elem_info to the assigned
>>>> snd_kcontorl, we'd need to add an extra argument in the call path to
>>>> inform about the volatileness, and it may become messy.  We'll find
>>>> the simplest way.
>>>>
>>>> And, IMO, it'd be better to check the cache behavior at setting, since
>>>> the cache may be accessed via multiple paths (at reading each element
>>>> and at resuming the whole system).  But it's no requirement, either.
>>>
>>> I have tried with attached patch, on top of your patch, but I'm still
>>> getting cached values from libasound2. It didn't break anything
>>> either... However, I don't see a link between this cache behavior and
>>> specific user space mixer descriptor. Because polling the mixer
>>> element with snd_mixer_selem_get_capture_volume() keeps always
>>> returning the same value. While in parallel checking the value by
>>> running "amixer" from command line gives updated correct value... So
>>> is there a second layer of cache somewhere in libasound2 to explain
>>> this discrepancy? Because one process sees updated value while other
>>> one doesn't. Difference being that the ALSA descriptors are closed and
>>> reopened every time "amixer" is run...
>>
>> Erm, I should have looked your *actual* patch before replying.
>> Basically all your newly created elements are independent from the
>> other USB standard things, and they are all read-only.  That is, you
>> don't need to use add_single_ctl_with_resume(), but just create each
>> element via snd_ctl_new1() and add it via snd_ctl_add().
>> (Also you can pass the mixer object directly in private_value.)
>>
>> If it still doesn't work as expected, it's rather something wrong in
>> the alsa-lib side, or ACCESS_VOLATILE flag isn't passed / set
>> properly.
> 
> By the way is the add_single_ctl_with_resume() correct in allocating 
> just snd_mixer_elem_list instead of snd_mixer_elem_info? I got 
> suspicious about this when reading the sources. Because the code is 
> similar to snd_create_std_mono_ctl_offset() but they allocate different 
> size which they go on to pass to the same functions. And in quite many 
> places functions cast the snd_mixer_elem_list pointer to 
> snd_mixer_elem_info pointer to access the entire structure which would 
> of course be wrong if it's just snd_mixer_elem_list size item. The patch 
> I posted in my previous mail that changes add_single_ctl_with_resume() 
> to allocate snd_mixer_elem_info instead at least didn't seem to break 
> things...
> 
> OK, I already started going through the alsa-lib code, I suspect 
> something is going wrong there because different processes give 
> different values depending on process lifetime and at the driver level 
> there's no process descriptor context yet...

OK, problem solved! My original patch for the RME mixer quirks is good, 
no changes needed to that one.

Problematic caching happens inside alsa-lib in simple mixer interface, 
where snd_mixer_selem_get_capture_volume() always returns cached value 
for mixer value read and doesn't trigger update from kernel. This is now 
fixed in my user space by using snd_hctl_elem_read() instead which 
triggers update from kernel, and as a side effect also seems to trigger 
update to the cached value so that later call to 
snd_mixer_selem_get_capture_volume() returns updated value too. I'm not 
sure if something should be done about 
snd_mixer_selem_get_capture_volume() behavior or not, but now at least I 
know how to work around this by using different API layer.

In addition, I've applied attached patch on top of your volatile patch, 
but I think that part is not strictly necessary but maybe good thing to 
do. This attached patch fixes (?) the allocation behavior of 
add_single_ctl_with_resume() I was talking about and adds volatile check 
on snd_usb_get_cur_mix_value() entry which should be superfluous to your 
change later in the function.


Thanks gain!

	- Jussi

--------------7A72996EE30B819C7DB7D9E9
Content-Type: text/x-patch;
 name="volatile-fix-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="volatile-fix-2.patch"

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6d360fa..21c053e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -438,7 +438,7 @@ int snd_usb_get_cur_mix_value(struct usb_mixer_elem_info *cval,
 {
 	int err;
 
-	if (cval->cached & (1 << channel)) {
+	if ((cval->cached & (1 << channel)) && !cval->is_volatile) {
 		*value = cval->cache_val[index];
 		return 0;
 	}
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 762c190..cff31ce 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -152,20 +152,24 @@ static int add_single_ctl_with_resume(struct usb_mixer_interface *mixer,
 				      const struct snd_kcontrol_new *knew,
 				      struct usb_mixer_elem_list **listp)
 {
+	struct usb_mixer_elem_info *cval;
 	struct usb_mixer_elem_list *list;
 	struct snd_kcontrol *kctl;
 
-	list = kzalloc(sizeof(*list), GFP_KERNEL);
-	if (!list)
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
 		return -ENOMEM;
+	list = &cval->head;
 	if (listp)
 		*listp = list;
+	if (knew->access & SNDRV_CTL_ELEM_ACCESS_VOLATILE)
+		cval->is_volatile = 1;
 	list->mixer = mixer;
 	list->id = id;
 	list->resume = resume;
-	kctl = snd_ctl_new1(knew, list);
+	kctl = snd_ctl_new1(knew, cval);
 	if (!kctl) {
-		kfree(list);
+		kfree(cval);
 		return -ENOMEM;
 	}
 	kctl->private_free = snd_usb_mixer_elem_free;

--------------7A72996EE30B819C7DB7D9E9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------7A72996EE30B819C7DB7D9E9--
