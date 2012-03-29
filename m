From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: trying to get an eleven rack to work
Date: Thu, 29 Mar 2012 09:08:26 +0200
Message-ID: <4F740A6A.3030608@ladisch.de>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
	<4F6883F9.4010405@ladisch.de>
	<CACckToUeX7oJmQ9NeRLGecxOxWaLpxbZDnNWA0+t5+XxFvf+FQ@mail.gmail.com>
	<4F718114.5020602@ladisch.de>
	<CAOyn=DFig0m1zFRWyTE6Neimrcy12PPAoNL8BdFVaAUrYEYbGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7804D10436E
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 09:05:09 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0583921232
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 03:05:07 -0400 (EDT)
In-Reply-To: <CAOyn=DFig0m1zFRWyTE6Neimrcy12PPAoNL8BdFVaAUrYEYbGw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Alexander <lidxv0n@gmail.com>, Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Alexander wrote:
> kernel: [   74.128035] usb 2-4: new high speed USB device number 2
> kernel: [   74.634592] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
> kernel: [   74.634606] snd-usb-audio: probe of 2-4:1.0 failed with error -5

0x09 is UAC2's EXTENSION_UNIT, which should not be a reason for failing.
Please try the patch below.


Regards,
Clemens


--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1926,7 +1926,7 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 			return parse_audio_processing_unit(state, unitid, p1);
 	default:
 		snd_printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
-		return -EINVAL;
+		return 0;
 	}
 }
