From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Sun, 1 Jan 2012 18:09:49 +0100
Message-ID: <CAFz=ag6pqhfOvxv_ScbxJFs6OEZt18GM+Dgs1KWQMG7mdZO21g@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag7_qzPJq44havp=EbFVKud5VvKaOLJk0i0dM43X3urp9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 890B1243FD
	for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2012 18:09:51 +0100 (CET)
Received: by werb12 with SMTP id b12so7896378wer.38
	for <alsa-devel@alsa-project.org>; Sun, 01 Jan 2012 09:09:49 -0800 (PST)
In-Reply-To: <CAFz=ag7_qzPJq44havp=EbFVKud5VvKaOLJk0i0dM43X3urp9Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com
List-Id: alsa-devel@alsa-project.org

Happy New Year!

That being said, I've tested a kernel without Daniel's patch set. It
doesn't work either. The error messages are only slightly different:

Jan  1 11:52:31 weasel mtp-probe: checking bus 1, device 4:
"/sys/devices/pci0000:00/0000:00:1a.7/usb1/1-1"
Jan  1 11:52:31 weasel mtp-probe: bus: 1, device: 4 was not an MTP device
Jan  1 11:52:31 weasel kernel: [  161.880773] usbcore: registered new
interface driver snd-usb-audio
Jan  1 11:52:34 weasel kernel: [  164.284980] cannot submit datapipe
for urb 0, error -28: not enough bandwidth

So, It's not related to Daniel's rework. But nevertheless, something's broken...
