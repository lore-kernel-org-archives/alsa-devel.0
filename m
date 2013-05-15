From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: PulseAudio and softvol
Date: Wed, 15 May 2013 14:47:15 +0200
Message-ID: <519383D3.3000303@canonical.com>
References: <1368611744.6590.8.camel@localhost> <519362EB.7050603@perex.cz>
 <s5hd2ssmsd2.wl%tiwai@suse.de> <5193692A.4060007@perex.cz>
 <51936B74.6080105@canonical.com> <51936FDB.2050407@perex.cz>
 <s5h1u98mn2y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC972615AE
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 14:46:55 +0200 (CEST)
In-Reply-To: <s5h1u98mn2y.wl%tiwai@suse.de>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>, pulseaudio-discuss@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/15/2013 02:42 PM, Takashi Iwai wrote:
> At Wed, 15 May 2013 13:22:03 +0200,
> Jaroslav Kysela wrote:
>>
>> Date 15.5.2013 13:03, David Henningsson wrote:
>>> On 05/15/2013 12:53 PM, Jaroslav Kysela wrote:
>>>> Date 15.5.2013 12:48, Takashi Iwai wrote:
>>>>> At Wed, 15 May 2013 12:26:51 +0200,
>>>>> Jaroslav Kysela wrote:
>>>>>>
>>>>>> Date 15.5.2013 11:55, Arun Raghavan wrote:
>>>>>>> Hello,
>>>>>>> A number of users have intermittently(?) been hitting a crash in
>>>>>>> alsa-lib 1.0.27 [1, 2] related to the softvol plugin. I'm not able to
>>>>>>> reproduce this reliably, so can't find an easy way to debug/fix.
>>>>>>
>>>>>> The problem is that the offsets are not in sync in this case [1]:
>>>>>>
>>>>>> src_offset = 38560
>>>>>> dst_offset = 38568
>>>>>> frames = 16374
>>>>>>
>>>>>> Could you reproduce this bug in any way? At least snd_pcm_dump() before
>>>>>> the failing snd_pcm_mmap_commit() call might help to determine what was
>>>>>> the status before the assert() was entered.
>>>>>
>>>>> Yep.  And this path is actually with volume 0dB, that is, a simply
>>>>> passthrough in softvol.  Thus the bug may hit essentially any
>>>>> plugins, not specifically softvol.
>>>>>
>>>>>
>>>>>>> However, this raises a tangential question - why do we need softvol to
>>>>>>> be plugged for 'front' at all? David explained to me that this is to
>>>>>>> guarantee the existence of a PCM control. Perhaps I don't fully
>>>>>>> understand this, because I'm unconvinced by the reason. Could someone
>>>>>>> explain/refute?
>>>>>>>
>>>>>>> This is especially bad for us, from PulseAudio's perspective, because we
>>>>>>> aren't getting a zero-copy path.
>>>>>>
>>>>>> If the softvol is set to 0dB (no attenuation or gain), then the ring
>>>>>> buffer pointers are moved without any sample processing, so the
>>>>>> zero-copy functionality is kept.
>>>>>
>>>>> Yeah, a sort of.  The mmap is cleared in the slave PCM, so actually
>>>>> there will be copy operations in underlying layers even though softvol
>>>>> itself does zero copy.
>>>>>
>>>>> Actually it makes no sense to keep softvol for PA, but the problem is
>>>>> always the regression.  There are certainly users without PA, which
>>>>> might still rely on the softvol for such hardware without the amp
>>>>> control.
>>>>>
>>>>> Maybe We can add some flag to indicate whether to handle softvol or
>>>>> not, e.g. defaults.pcm.skip_softvol, and let PA set this in its config
>>>>> space.  Setting a config item itself would break anything, so it'll
>>>>> still work with old alsa-lib (but with softvol).
>>>>
>>>> We have already SND_PCM_NO_SOFTVOL open mode for this purpose, so I
>>>> wonder, why PA does not use it..
>>>
>>> The problem is knowing whether PCM is a softvol or not. In some cases,
>>> we need to set PCM to control hardware volume.
>>>
>>> Maybe, if we could figure this out somehow, we could ignore the PCM
>>> mixer control (or possibly set it to zero) in case PCM is a softvol,
>>> and actually use it if PCM is not a softvol.
>>>
>>> It does not look like this is currently possible from the simple mixer
>>> interface, but I might be missing something?
>>
>> It is not possible. Perhaps, we may create a new dummy mixer control (in
>> an inactive state) which will identify the presence of the softvol
>> plugin, like:
>>
>> "Softvol PCM Playback Volume" - full name for the raw control API
>> "Softvol PCM" - simple mixer name
>
> Well, if changing in such a way, I'd rather drop softvol from
> HDA-Intel.conf.
>
> If we could give some flag in mixer API, we could add a code to filter
> out the user controls from the mixer's hctl.  But snd_mixer_attach()
> takes only the string, and the string modifier may lead to the
> incompatibility when used with an older version.  Hmm.

That seems solvable to me, something like this:

diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 56e023d..4afa979 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -65,13 +65,14 @@ static int snd_mixer_compare_default(const 
snd_mixer_elem_t *c1,
   * \param mode Open mode
   * \return 0 on success otherwise a negative error code
   */
-int snd_mixer_open(snd_mixer_t **mixerp, int mode ATTRIBUTE_UNUSED)
+int snd_mixer_open(snd_mixer_t **mixerp, int mode)
  {
         snd_mixer_t *mixer;
         assert(mixerp);
         mixer = calloc(1, sizeof(*mixer));
         if (mixer == NULL)
                 return -ENOMEM;
+       mixer->attach_mode = mode;
         INIT_LIST_HEAD(&mixer->slaves);
         INIT_LIST_HEAD(&mixer->classes);
         INIT_LIST_HEAD(&mixer->elems);
@@ -200,7 +201,7 @@ int snd_mixer_attach(snd_mixer_t *mixer, const char 
*name)
         snd_hctl_t *hctl;
         int err;

-       err = snd_hctl_open(&hctl, name, 0);
+       err = snd_hctl_open(&hctl, name, mixer->attach_mode);
         if (err < 0)
                 return err;
         err = snd_mixer_attach_hctl(mixer, hctl);
diff --git a/src/mixer/mixer_local.h b/src/mixer/mixer_local.h
index 27b4a3b..2d1866e 100644
--- a/src/mixer/mixer_local.h
+++ b/src/mixer/mixer_local.h
@@ -71,6 +71,7 @@ struct _snd_mixer {
         unsigned int count;
         unsigned int alloc;
         unsigned int events;
+       int attach_mode;
         snd_mixer_callback_t callback;
         void *callback_private;
         snd_mixer_compare_t compare;


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
