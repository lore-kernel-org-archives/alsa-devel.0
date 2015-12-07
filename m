From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v2 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Mon, 7 Dec 2015 08:46:20 -0800
Message-ID: <CAG5mAdwy+xmc21+8nXdNEy6XWcWknU9vJstw=nJ1RR+mUkEycQ@mail.gmail.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
 <56657E71.1030405@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
 [209.85.213.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 429F6264F37
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 17:46:41 +0100 (CET)
Received: by igl9 with SMTP id 9so77874412igl.0
 for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2015 08:46:40 -0800 (PST)
In-Reply-To: <56657E71.1030405@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 7, 2015 at 4:41 AM, arnaud.mouiche@invoxia.com
<arnaud.mouiche@invoxia.com> wrote:
>
> Hi all.
>
> Yes, Caleb and I are working on issues when dealing with N channels, N > 2, but everyone can experience those issues with N=2.
> It is true that a Left/Right switching on audio in not tragic for most users, but I think is will be good if this kind of channel switch can be definitely fixed by the patches I propose.
>
> Here is a very basic test to demonstrate a 2 channels classical scenario that everyone can experience on a imx6 SOC.
>
>   #!/bin/sh
>
>   amixer set PCM 100%,0%
>   arecord -D hw:0,0 -c 2 -r 48000 -f S16_LE  /tmp/foo.wav </dev/null &
>   pid=$!
>   speaker-test -t sine -D hw:0,0 -r 48000 -c 2 -l 1
>   kill $pid
>
> what is done:
> - Right channel is muted at the codec level (so if we try to play something on the right channel only, nothing is heard).
> - We start recording (arecord)
> - then we start a tone generation (speaker-test), starting by the left channel during few first seconds.
>
> what is expected:
> - We should hear the tone on left channel right after speaker-test starts.
>
> what is experienced:
> - 50% of the time, we don't here anything, until speaker-test switch to the right meaning Left and Right channels are switched.
>
> Regards,
> Arnaud
>
Since I haven't been testing with channels==2, I never noticed that
the problem was very common even with 2 channels!  Yikes.

I've been delayed in working on your patch set.  I hope to get to it
soon, but other deadlines are looming, so I might have to wait for the
new year to put it together.

Thanks so much for the patches, I'm really looking forward to finally
having a robust MX6 driver.

-Caleb
