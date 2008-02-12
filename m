From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: snd-hda-intel AD1981 - the microphone doesn't work
Date: Tue, 12 Feb 2008 21:02:07 +0100
Message-ID: <200802122102.07320.grzegorz.chwesewicz@chilan.com>
References: <47B1D340.4070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 464FF103848
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 21:02:19 +0100 (CET)
In-Reply-To: <47B1D340.4070907@gmail.com>
Content-Disposition: inline
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
Cc: chilek@chilan.com, Robert Gonciarz <ruppertus@gmail.com>
List-Id: alsa-devel@alsa-project.org

Tuesday 12 of February 2008 18:11:28 Robert Gonciarz napisa=B3(a):
> Hi, I'm trying to activate a microphone (I have just external one) in my
> HP NX7300 (RU374ES) notebook (it has two jacks without internal mic) for
> six months. Alsamixer says that it's AD1981 chipset.
>
> The sound works great execept two things:
> - it's too silent when I set almost the maximum level (if you compare it
> with Windows XP driver) - but it's not so bad. It is said that a tothem
> can change some hidden settings to make it louder.
>
> - the microphone doesn't work even though I setted it in alsamiser (the
> settings: <capture tab> the "Mic" is red, "Mic boss" is setted with
> 67/67, "Capture" 80/80, Mix is blue and "-----", "Digital" 62/62,
> "Docking-" is blue and "----", "Internal" 67/67.
> The mic doesn't capture any voice at all.
>
> I was trying to load the module with different names: default, hp and
> toshiba works but the mic still doesn't work.
>
> lspci | grep Audio
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
> Definition Audio Controller (rev 01)
>
> lspci -nv
> 00:1b.0 0403: 8086:27d8 (rev 01)
> 	Subsystem: 103c:30a2
> 	Flags: bus master, fast devsel, latency 0, IRQ 16
> 	Memory at f4580000 (64-bit, non-prefetchable) [size=3D16K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: HDA Intel
> 	Kernel modules: snd-hda-intel
>
> It was tested with snd-hda-intel module from the lastest sources from
> your website: alsa-driver-1.0.16rc2.
>
> I'm using 2.6.24.1 kernel. At the begining I tried to compile the kernel
> with a module which was included to it (it was working without a mic)
> and then I compiled the external module from your web.
>

Hi Robert. I have NX6325, it has same sound card (AD1981HD), but different =

chipset (I have AMD processor). Take a look at description of my problem in =

links below.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2449
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-February/005817.h=
tml

-- =

Greetings
Grzegorz Chwesewicz, Chilan =

mailto:grzegorz.chwesewicz@chilan.com
