From: Daniel Mack <zonque@gmail.com>
Subject: Re: Regression in sound/usb/
Date: Tue, 10 Jul 2012 23:14:55 +0200
Message-ID: <4FFC9B4F.6060600@gmail.com>
References: <CADYPuQ75GAxGyZgiUwygvnQMmDcL9+NMHNo432kg1RYC7vbfQA@mail.gmail.com>
	<4FF18FCF.6020306@gmail.com>
	<CADYPuQ5RFJAaFDpT+4XM-JDWzDO5czVAU3A++_HVHjhN=VBhvQ@mail.gmail.com>
	<s5hvci55l68.wl%tiwai@suse.de>
	<CADYPuQ4Uj8pq9nZOJemY9kZtSrG-WfG4s90b+a00_KteJXU_Sg@mail.gmail.com>
	<s5hr4st5jx1.wl%tiwai@suse.de>
	<CADYPuQ6DT4=NW2tzCLrKYnUHQ6p5qONZjY8PeKq-Z4HAk68tpw@mail.gmail.com>
	<s5hk3yl5ibt.wl%tiwai@suse.de> <s5hhatmjmna.wl%tiwai@suse.de>
	<CADYPuQ7yWpnPSvoVQDV+EyJfC39MDxhP9r5Jiqk_Jh8g65Xd4g@mail.gmail.com>
	<s5h8vey43ve.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080102090909090401070304"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id C991024179
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 23:14:59 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so392172bkc.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2012 14:14:59 -0700 (PDT)
In-Reply-To: <s5h8vey43ve.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Philipp Dreimann <philipp@dreimann.net>, Joseph Salisbury <joseph.salisbury@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080102090909090401070304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 05.07.2012 17:36, Takashi Iwai wrote:
> At Thu, 5 Jul 2012 17:32:30 +0200,
> Philipp Dreimann wrote:
>>
>> On 5 July 2012 16:41, Takashi Iwai <tiwai@suse.de> wrote:
>>>> Try the patch below.  If it still doesn't work, give the kernel
>>>> message again and lsusb -v output, too.
>>>
>>> Did it make any difference?
>>
>> No, it unfortunately did not.
>>
>> lsusb is attached and the parts of the kernel log are in the mail:
>>
>> [   41.243211] usb 2-1.2: new high-speed USB device number 3 using ehci_hcd
>> [   41.605666] uvcvideo: Found UVC 1.00 device <unnamed> (046d:0821)
>> [   42.002275] input: UVC Camera (046d:0821) as
>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.2/input/input12
>> [   42.085880] usbcore: registered new interface driver snd-usb-audio
>>
>> [   52.790139] uvcvideo: Failed to query (GET_DEF) UVC control 2 on
>> unit 2: -71 (exp. 2).
>> [   52.794363] uvcvideo: Failed to query (GET_DEF) UVC control 2 on
>> unit 2: -71 (exp. 2).
>> [   52.798375] uvcvideo: Failed to query (GET_DEF) UVC control 3 on
>> unit 2: -71 (exp. 2).
>> [   52.802499] uvcvideo: Failed to query (GET_DEF) UVC control 7 on
>> unit 2: -71 (exp. 2).
>> [   52.806617] uvcvideo: Failed to query (GET_DEF) UVC control 11 on
>> unit 2: -71 (exp. 1).
>> [   52.810734] uvcvideo: Failed to query (GET_DEF) UVC control 4 on
>> unit 2: -71 (exp. 2).
>> [   52.814855] uvcvideo: Failed to query (GET_DEF) UVC control 5 on
>> unit 2: -71 (exp. 1).
>> [   52.818976] uvcvideo: Failed to query (GET_CUR) UVC control 11 on
>> unit 2: -71 (exp. 1).
>> [   52.823096] uvcvideo: Failed to query (GET_DEF) UVC control 8 on
>> unit 2: -71 (exp. 2).
>> [   52.827215] uvcvideo: Failed to query (GET_DEF) UVC control 1 on
>> unit 2: -71 (exp. 2).
>> [   52.831331] uvcvideo: Failed to set UVC probe control : -71 (exp. 26).
>> [   52.835459] uvcvideo: Failed to set UVC probe control : -71 (exp. 26).
>> The last line repeats a few times, then the Failed to query block
>> repeats again, and so on. But only if I try to use the webcam.
>>
>> [   82.363599] 3:1:3: cannot set freq 32000 to ep 0x86
>> Is showing up without using the webcam.
> 
> Hm, it looks better than before (it was '3:-1:3' or such), but there
> is still something strange there.

Sorry for the long delay on this. I finally found some time to look into
this and it seems that I got the calls to usb_set_interface wrong.
Attached is a patch to fix this - could everybody who is affect please
give that a quick try? More explanation is in the commit log.


Thanks,
Daniel



--------------080102090909090401070304
Content-Type: text/x-patch;
 name="0001-ALSA-snd-usb-fix-calls-to-usb_set_interface.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-snd-usb-fix-calls-to-usb_set_interface.patch"

>From 1b8ebc9974c16b8587bdce3ca9a4435c8ef8141e Mon Sep 17 00:00:00 2001
From: Daniel Mack <zonque@gmail.com>
Date: Tue, 10 Jul 2012 22:52:56 +0200
Subject: [PATCH] ALSA: snd-usb: fix calls to usb_set_interface

Don't call usb_set_interface() on snd_usb_endpoint creation and also
drop it from snd_usb_endpoint_deactivate(). Rather unselect the the
active interface before choosing a new alt setting upon the next stream
start.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/endpoint.c |   45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e690690..2226769 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -414,7 +414,7 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 {
 	struct list_head *p;
 	struct snd_usb_endpoint *ep;
-	int ret, is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
+	int is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
 
 	mutex_lock(&chip->mutex);
 
@@ -434,16 +434,6 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 		    type == SND_USB_ENDPOINT_TYPE_DATA ? "data" : "sync",
 		    ep_num);
 
-	/* select the alt setting once so the endpoints become valid */
-	ret = usb_set_interface(chip->dev, alts->desc.bInterfaceNumber,
-				alts->desc.bAlternateSetting);
-	if (ret < 0) {
-		snd_printk(KERN_ERR "%s(): usb_set_interface() failed, ret = %d\n",
-					__func__, ret);
-		ep = NULL;
-		goto __exit_unlock;
-	}
-
 	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
 	if (!ep)
 		goto __exit_unlock;
@@ -936,8 +926,8 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
  *
  * In case of any active users, this functions does nothing.
  *
- * Returns an error if usb_set_interface() failed, 0 in all other
- * cases.
+ * Returns an error if any of the usb_set_interface() calls failed, 0 in
+ * all other cases.
  */
 int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
 {
@@ -948,6 +938,14 @@ int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
 	    !test_and_set_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
 		int ret;
 
+		ret = usb_set_interface(ep->chip->dev, ep->iface, 0);
+		if (ret < 0) {
+			snd_printk(KERN_ERR "%s() usb_set_interface() failed, ret = %d\n",
+						__func__, ret);
+			clear_bit(EP_FLAG_ACTIVATED, &ep->flags);
+			return ret;
+		}
+
 		ret = usb_set_interface(ep->chip->dev, ep->iface, ep->alt_idx);
 		if (ret < 0) {
 			snd_printk(KERN_ERR "%s() usb_set_interface() failed, ret = %d\n",
@@ -967,13 +965,8 @@ int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
  *
  * @ep: the endpoint to deactivate
  *
- * If the endpoint is not currently in use, this functions will select the
- * alternate interface setting 0 for the interface of this endpoint.
- *
- * In case of any active users, this functions does nothing.
- *
- * Returns an error if usb_set_interface() failed, 0 in all other
- * cases.
+ * Returns 0 on success, -EINVAL if ep was NULL and -EBUSY if the endpoint
+ * is still in use.
  */
 int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 {
@@ -984,18 +977,8 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 		return 0;
 
 	if (!ep->chip->shutdown &&
-	    test_and_clear_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
-		int ret;
-
-		ret = usb_set_interface(ep->chip->dev, ep->iface, 0);
-		if (ret < 0) {
-			snd_printk(KERN_ERR "%s(): usb_set_interface() failed, ret = %d\n",
-						__func__, ret);
-			return ret;
-		}
-
+	    test_and_clear_bit(EP_FLAG_ACTIVATED, &ep->flags))
 		return 0;
-	}
 
 	return -EBUSY;
 }
-- 
1.7.10.4


--------------080102090909090401070304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080102090909090401070304--
