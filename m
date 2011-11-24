From: Borg Onion <borg.onion@gmail.com>
Subject: PCM usage / seg fault in pcm_params.c
Date: Thu, 24 Nov 2011 02:20:05 -0800
Message-ID: <CAAs5ODsSYHW7GM8ia050=T0-HSQuGieCRUCnR-nB_t_yWXf9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f44.google.com (mail-qw0-f44.google.com
	[209.85.216.44]) by alsa0.perex.cz (Postfix) with ESMTP id 99318244D2
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:20:08 +0100 (CET)
Received: by qadb14 with SMTP id b14so3706720qad.17
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 02:20:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Program terminated with signal 11, Segmentation fault.
#0  0x00534502 in snd_pcm_hw_refine (pcm=0x94b36f0, params=0x94b36f0) at
pcm_params.c:2291
2291            res = pcm->ops->hw_refine(pcm->op_arg, params);
(gdb) bt
#0  0x00534502 in snd_pcm_hw_refine (pcm=0x94b36f0, params=0x94b36f0) at
pcm_params.c:2291
#1  0x0052a1e2 in snd_pcm_hw_params_any (pcm=0x94b36f0, params=0x94b36f0)
at pcm.c:3178
#2  0x080497a7 in print_pcm_hw_params (pcm=0x94b36f0) at list.c:109
#3  0x080499ef in print_pcm_devices (handle=0x94af638) at list.c:147
#4  0x08049362 in main (argc=1, argv=0xbfcf66b4) at list.c:227
(gdb) print pcm->ops
$1 = (const snd_pcm_ops_t *) 0x0

Source code at http://pastebin.com/rqBCDza7

Sound card is opened, PCM device is opened, hw params were just allocated,
and now I'm calling snd_pcm_hw_params_any().  Trying to populate the empty
params struct so as to interrogate it and find out the card's capabilities.

I'm sure I'm mis-using alsa-lib, but also shouldn't this have an assert()
on pcm->ops ?  What's the right call sequence to get capabilities of this
PCM channel (sample rates, bit depths, etc)?

Thanks for any help!

--BO
