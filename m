From: Timur Tabi <timur@freescale.com>
Subject: Possible problem with snd_pcm_oss_sync()
Date: Tue, 20 May 2008 11:03:42 -0500
Message-ID: <4832F65E.5070008@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EB7B2489B
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 18:03:47 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4KG3gei029491
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 09:03:43 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4KG3gNj005473
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 11:03:42 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



-------- Original Message --------
Subject: 	RE: Regarding MPC8610 BSP question and issue
Date: 	Tue, 20 May 2008 08:55:46 -0700
From: 	Hayasaka Manabu <manabu.hayasaka@freescale.com>
To: 	Hayasaka Manabu <manabu.hayasaka@freescale.com>, Johnson Kelly
<Kelly.Johnson@freescale.com>
CC: 	sun york <yorksun@freescale.com>, Namiki Ayumi
<namiki@freescale.com>, Beck Glenn <Glenn.Beck@freescale.com>, Cox Kevin
<K.Cox@freescale.com>, Hamano Masahiro <M.Hamano@freescale.com>, Tabi
Timur <timur@freescale.com>
References:
<E03EE6E38549E949AE8138F60493E1E801C49A0C@zja67exm20.fsl.freescale.net>
<4807899D.3000901@freescale.com>
<E03EE6E38549E949AE8138F60493E1E801DA1B11@zja67exm20.fsl.freescale.net>
<48110FCF.7070302@freescale.com>
<BD243C8D8F65694A966948E9D51F9815C29409@zja67exm21.fsl.freescale.net>
<48189540.9060309@freescale.com>
<BD243C8D8F65694A966948E9D51F9815C29422@zja67exm21.fsl.freescale.net>
<E03EE6E38549E949AE8138F60493E1E801DA25D9@zja67exm20.fsl.freescale.net>
<4821CA02.2020504@freescale.com>
<E03EE6E38549E949AE8138F60493E1E801FA11C8@zja67exm20.fsl.freescale.net>
<4829C444.7010206@freescale.com>
<E03EE6E38549E949AE8138F60493E1E801FA13D2@zja67exm20.fsl.freescale.net>
<482B1D10.7090402@freescale.com> <482B2699.8020409@freescale.com>

I'm working with a customer that has discovered a possible problem with OSS
emulation.  Unfortunately, I don't have a lot of experience with OSS, so I need
help understanding whether the customer's observations point to a real problem
or not.

The customer is using an old application called "bplay" to test OSS audio
support on our hardware.  The application works fine on x86, but fails on our
PowerPC board.  It could be an endian issue, but I doubt it.

Here is the forwarded email (slightly edited).  Can someone familiar with the
OSS "sync" functionality comment?

---------------

They reported that it seemed some ioctl commands in the OSS emulation did not
work correctly.

The tested procedure of the ioctl commands are as following,

#1) Stopped audio stream output after doing followings:
1. Opening /dev/mixer
2. Getting a channel value (0x00000001) that is used for "ioctl(fd,
SOUND_MIXER_READ_DEVMASK, &Sndsts);".
3. Write audio volume information by "ioctl(fd,
SOUND_MIXER_WRITE_VOLUME, &Value);",

#2) Stopped audio stream output after doing following:
1. Opening /dev/dsp
2. Executing command "ioctl(fd, SNDCTL_DSP_SYNC, NULL);",

XXXX found that by commenting out the "sync_audio" function on the source
code of "bplay" made "bplay" work. So XXXX suspects the implementation of the
ioctl on the OSS emulation may have a problem.

-- 
Timur Tabi
Linux kernel developer at Freescale
