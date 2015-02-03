From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Mon, 2 Feb 2015 23:14:56 -0800
Message-ID: <54D07570.8040703@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
 <531DDD04.5050902@ladisch.de>
 <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
 <531EC9CC.4060203@ladisch.de>
 <88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
 <545895AD.7020004@ladisch.de> <545A697C.5070800@bobobeach.com>
 <545A93E3.7020906@ladisch.de> <545B0B54.5080609@bobobeach.com>
 <54674E72.4070607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aspen.bobobeach.com (unknown [208.79.93.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 515592607E9
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 08:15:13 +0100 (CET)
in-reply-to: <54674E72.4070607@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org




On 11/15/2014 05:00 AM, Clemens Ladisch wrote:
> (Sorry for the delay.) Cyrus Harmon wrote:
>> [ 2.978159] snd-usb-audio 3-3.2:1.1: probe step 2 [ 2.978334] 
>> snd-usb-audio 3-3.2:1.1: probe failed
> Still mysterious. Please try with this patch instead.

(Sorry for yet another delay)

I'm not sure the debugging patch here was properly applied/installed, 
but I think so. In any event, perhaps with this patch, and definitely 
for your previous 2 patches, updated for the 3.19-rc7 sources, I get the 
following errors when I try to load snd-usb-aduio:

[  294.270316] snd-usb-audio 1-3.2:1.0: checking PCM interface
[  294.270319] snd-usb-audio 1-3.2:1.0: quirk return code: -19
[  294.270321] snd-usb-audio 1-3.2:1.0: probe failed
[  294.270773] snd-usb-audio 1-3.2:1.1: checking PCM interface
[  294.270775] snd-usb-audio 1-3.2:1.1: altsets found
[  294.270776] snd-usb-audio 1-3.2:1.1: endpoint found
[  294.270778] snd-usb-audio 1-3.2:1.1: iso found
[  294.270779] snd-usb-audio 1-3.2:1.1: descriptors found
[  294.272941] snd-usb-audio 1-3.2:1.1: first interface successful
[  294.272943] usb 1-3.2:1.0: checking PCM interface
[  294.272945] usb 1-3.2:1.2: checking PCM interface
[  294.272946] usb 1-3.2:1.2: altsets found
[  294.272947] usb 1-3.2:1.2: endpoint found
[  294.272948] usb 1-3.2:1.2: iso found
[  294.272949] usb 1-3.2:1.2: descriptors found
[  294.275044] snd-usb-audio 1-3.2:1.2: interface 2 successful
[  294.275047] usb 1-3.2:1.3: checking PCM interface
[  294.275056] snd-usb-audio 1-3.2:1.3: interface 3 successful
[  294.275057] usb 1-3.2:1.4: checking PCM interface
[  294.275065] snd-usb-audio 1-3.2:1.4: interface 4 successful
[  294.275066] snd-usb-audio 1-3.2:1.4: create_autodetect_quirks successful
[  294.275067] snd-usb-audio 1-3.2:1.1: quirk return code: 0
[  294.275068] snd-usb-audio 1-3.2:1.1: probe step 2
[  294.275297] snd-usb-audio 1-3.2:1.1: probe failed
[  294.275465] snd-usb-audio: probe of 1-3.2:1.1 failed with error -16
[  294.275490] usbcore: registered new interface driver snd-usb-audio
[  294.276043] systemd-udevd[4350]: Failed to apply ACL on 
/dev/snd/pcmC3D0p: No such file or directory
[  294.276047] systemd-udevd[4350]: Failed to apply ACL on 
/dev/snd/pcmC3D0p: No such file or directory
[  294.276164] systemd-udevd[4348]: Failed to apply ACL on 
/dev/snd/controlC3: No such file or directory
[  294.276169] systemd-udevd[4348]: Failed to apply ACL on 
/dev/snd/controlC3: No such file or directory
[  294.276219] systemd-udevd[4353]: Failed to apply ACL on 
/dev/snd/pcmC3D0c: No such file or directory
[  294.276223] systemd-udevd[4353]: Failed to apply ACL on 
/dev/snd/pcmC3D0c: No such file or directory
[  294.276802] systemd-udevd[4354]: Failed to apply ACL on 
/dev/snd/midiC3D0: No such file or directory
[  294.276806] systemd-udevd[4354]: Failed to apply ACL on 
/dev/snd/midiC3D0: No such file or directory


So the call that must be failing is:

     err = snd_card_register(chip->card);

and of course this all works with the quirks table modified for the 
ur44. I'm at a loss. Any further debugging suggestions would be greatly 
appreciated.

thanks,

Cyrus



> Regards, Clemens --- a/sound/core/pcm.c +++ b/sound/core/pcm.c @@ 
> -1086,6 +1086,7 @@ static int snd_pcm_dev_register(struct snd_device 
> *device) mutex_lock(&register_mutex); err = snd_pcm_add(pcm); if (err) 
> { + printk(KERN_ERR "snd_pcm_add(%d) failed\n", pcm->device); 
> mutex_unlock(&register_mutex); return err; } @@ -1115,6 +1116,7 @@ 
> static int snd_pcm_dev_register(struct snd_device *device) 
> &snd_pcm_f_ops[cidx], pcm, str, dev); if (err < 0) { + dev_err(dev, 
> "snd_register_device_for_dev failed: %d\n", err); 
> list_del(&pcm->list); mutex_unlock(&register_mutex); return err;
