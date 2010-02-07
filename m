From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: ALSA Driver 1.0.22.1
Date: Sun, 7 Feb 2010 05:29:09 -0500
Message-ID: <604760771002070229w6f12e501vd783c895cb00b2a7@mail.gmail.com>
References: <c75a76611002070020v245a4edckb6b85dbd187365db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f200.google.com (mail-px0-f200.google.com
	[209.85.216.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 3346F2412E
	for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2010 11:29:10 +0100 (CET)
Received: by pxi38 with SMTP id 38so15896pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 07 Feb 2010 02:29:10 -0800 (PST)
In-Reply-To: <c75a76611002070020v245a4edckb6b85dbd187365db@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: darsen@berkeley.edu
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 7, 2010 at 3:20 AM, Darsen Lu <darsenlu@gmail.com> wrote:
> After that I started noticing conflicts between different sound-playback
> applications.
> For example, if I watch a Flash video on Firefox, stop it, and then start
> playing an MP3 file on Totem (a Media Player), I don't hear any sound.
> Once I close Firefox the music from Totem starts coming out.
> This never happened before on my Linux system. I'd be very grateful if
> someone could give me advices!

This symptom is very improbably related to your upgrading of the
driver. Instead, it's a userspace issue. Use "sudo fuser -v /dev/dsp*
/dev/snd/* /dev/seq*" when you're experiencing the symptom to start
troubleshooting.

Best,
-Dan
