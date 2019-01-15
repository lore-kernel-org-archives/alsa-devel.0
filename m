From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [RFC PATCH] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Tue, 15 Jan 2019 13:11:45 +0200
Message-ID: <CAHEwa0BhKp2hqgBR+ZrCmZ92LCxhsWd-8Pjc1pQ7HJ4==jz6WA@mail.gmail.com>
References: <900a4f74-9312-58d8-a5b3-035305fe184e@gmail.com>
 <4b8ce92c-9239-3a8a-f061-eb114050bd3a@axentia.se>
 <CAHEwa0BmUedqYR0Q0RtHtsHCqHCggtK75uY3hDcDzqAM8Qu4ZQ@mail.gmail.com>
 <9b479bdb-2c29-86ad-1ea4-9f76b9b47f7b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B8592666B3
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 12:11:57 +0100 (CET)
Received: by mail-io1-f67.google.com with SMTP id m19so1747035ioh.3
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 03:11:57 -0800 (PST)
In-Reply-To: <9b479bdb-2c29-86ad-1ea4-9f76b9b47f7b@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2019 at 10:06 AM Peter Rosin <peda@axentia.se> wrote:
> ...and when double-checking that, this dai op is only ever called from
> snd_soc_dai_set_bclk_ratio, and that function is in turn not called from
> anywhere AFAICT. What's the point of this dai op anyway? Or, what am I
> missing?

Well, my use for this, would be to allow the machine driver to call
snd_soc_dai_set_bclk_ratio, in order to explicitly set the frame
width.  This would allow it to use 32-bit frames for 24-bit data and
avoid the fractional dividers that would otherwise result.  Right now,
the machine driver (which lives in the Raspberry Pi kernel tree) uses
a workaround for this, that relies on a patch made to the CODEC driver
to half-support TDM slots, which hasn't be pushed upstream, and
wouldn't be accepted if it had, since it's essentially a hack.  You
can find more details here:

http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143507.html

What the intended use for the snd_soc_dai_set_bclk_ratio is, I'm not
so clear about, hence this RFC.
