From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: snd-usb-line6 depends on CONFIG_SND_HWDEP
Date: Wed, 21 Sep 2016 22:25:43 +0900
Message-ID: <b9ed1809-b48a-5e72-b815-f5ad073520d1@sakamocchi.jp>
References: <86590.1474409693@turing-police.cc.vt.edu>
 <046fe4be-f3e8-0088-8b1d-ed94bb9ef914@sakamocchi.jp>
 <s5hk2e5l97y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk2e5l97y.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sep 21 2016 21:37, Takashi Iwai wrote:
> On Wed, 21 Sep 2016 03:56:05 +0200,
> Takashi Sakamoto wrote:
>>
>> On Sep 21 2016 07:14, Valdis Kletnieks wrote:
>>> ALSA - snd-usb-line6 depends on CONFIG_SND_HWDEP
>>>
>>> ERROR: "snd_hwdep_new" [sound/usb/line6/snd-usb-line6.ko] undefined!
>>> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>>> make[1]: *** [__modpost] Error 1
>>>
>>> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>>
>> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>
>> As a nitpicking, I think it better to change the subject line with a
>> prefix of 'ALSA: line6:' or 'ALSA: usb-line6:', following to our
>> fashion.
> 
> Yes, I modified the subject line and added fixes tag.

Thanks.

As another issue, I can see sparse (v0.5.0) errors:

sound/usb/line6/driver.c:274:43: error: cannot size expression
sound/usb/line6/driver.c:275:16: error: cannot size expression
sound/usb/line6/driver.c:276:16: error: cannot size expression
sound/usb/line6/driver.c:277:16: error: cannot size expression

And this fix can suppresses them:

$ git diff sound/usb/line6
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index f9224ec..ad7efc0 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -30,7 +30,7 @@
 /*
        This is Line 6's MIDI manufacturer ID.
 */
-const unsigned char line6_midi_id[] = {
+const unsigned char line6_midi_id[3] = {
        0x00, 0x01, 0x0c
 };
 EXPORT_SYMBOL_GPL(line6_midi_id);

Besides, there's a difference of the declaration between header and code:
$ cat sound/usb/line6/driver.h
...
extern const unsigned char line6_midi_id[3];

This is quite minor. So I can't judge to fix it or not... What do you
think about it?

>>> diff --git a/sound/usb/line6/Kconfig b/sound/usb/line6/Kconfig
>>> index 8ffcf48097d9..39b400392d71 100644
>>> --- a/sound/usb/line6/Kconfig
>>> +++ b/sound/usb/line6/Kconfig
>>> @@ -2,6 +2,7 @@ config SND_USB_LINE6
>>>  	tristate
>>>  	select SND_RAWMIDI
>>>  	select SND_PCM
>>> +	select SND_HWDEP
>>>
>>>  config SND_USB_POD
>>>  	tristate "Line 6 POD USB support"

Regards

Takashi Sakamoto
