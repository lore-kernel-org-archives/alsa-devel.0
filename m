From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Use of default device with snd_pcm_link()
Date: Mon, 28 Dec 2009 11:11:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912281109100.11550@eeebox2.perex-int.cz>
References: <829197380912271659k5b9fd29aj3927fda3a1001874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F512103810
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 11:11:40 +0100 (CET)
In-Reply-To: <829197380912271659k5b9fd29aj3927fda3a1001874@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Devin Heitmueller <dheitmueller@kernellabs.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

O Sun, 27 Dec 2009, Devin Heitmueller wrote:

> I am working on some code which captures from one PCM device and plays
> to another, based off of the latency.c found in alsa-lib.  I noticed
> something strange:
>
> The code works if I set the capture device to hw:1,0 and playback
> device to hw:0,0.  However, if I change the playback device to
> "default:0", the snd_pcm_link() call fails with -ENOSYS (error 38).
>
> If I dump out the properties, I can see that the the default device
> *is* mapped to device 0,0, so it's not clear why the behaviour would
> differ.
>
> My goal was just to playback to whatever the default device is, and I
> was under the impression that default:0 should be equivalent to
> "hw:0,0".  Can anyone offer any brief explanation as to why the
> snd_pcm_link() call would fail?

Some alsa-lib plugins do not have the link feature implemented. If you use 
snd_pcm_dump(), you may list all plugins in chain. I think that dmix is in 
path. And no, "default:0" is NOT equivalent to "hw:0,0".

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
