From: Darsen Lu <darsenlu@gmail.com>
Subject: Re: ALSA Driver 1.0.22.1
Date: Sun, 7 Feb 2010 09:55:07 -0500
Message-ID: <c75a76611002070655q77d0429fjeff973eb10287d79@mail.gmail.com>
References: <c75a76611002070020v245a4edckb6b85dbd187365db@mail.gmail.com>
	<604760771002070229w6f12e501vd783c895cb00b2a7@mail.gmail.com>
Reply-To: darsen@berkeley.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D0932452D
	for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2010 15:55:07 +0100 (CET)
Received: by pzk36 with SMTP id 36so5855683pzk.23
	for <alsa-devel@alsa-project.org>; Sun, 07 Feb 2010 06:55:07 -0800 (PST)
In-Reply-To: <604760771002070229w6f12e501vd783c895cb00b2a7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the reply.

I tried "fuser -v /dev/dsp* /dev/snd/* /dev/seq*" and found out that Adobe
Flash Player was directly controlling /dev/snd/pcmC0D0p.  That is when I
realized I need to create /etc/asound.conf to route ALSA library to
PulseAudio.  The content of asound.conf follows this webpage
https://wiki.ubuntu.com/PulseAudio .

Regards,
Darsen

On Sun, Feb 7, 2010 at 5:29 AM, Daniel Chen <seven.steps@gmail.com> wrote:

> On Sun, Feb 7, 2010 at 3:20 AM, Darsen Lu <darsenlu@gmail.com> wrote:
> > After that I started noticing conflicts between different sound-playback
> > applications.
> > For example, if I watch a Flash video on Firefox, stop it, and then start
> > playing an MP3 file on Totem (a Media Player), I don't hear any sound.
> > Once I close Firefox the music from Totem starts coming out.
> > This never happened before on my Linux system. I'd be very grateful if
> > someone could give me advices!
>
> This symptom is very improbably related to your upgrading of the
> driver. Instead, it's a userspace issue. Use "sudo fuser -v /dev/dsp*
> /dev/snd/* /dev/seq*" when you're experiencing the symptom to start
> troubleshooting.
>
> Best,
> -Dan
>
