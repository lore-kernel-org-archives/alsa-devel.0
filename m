From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 16/17] ASoC: Basic split of mpc5200 DMA
	code out from mpc5200_psc_i2s
Date: Tue, 28 Apr 2009 15:59:52 -0400
Message-ID: <9e4733910904281259r1188acb0r7063ea809668b6b5@mail.gmail.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
	<1240932222-3718-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljpk233w.wl%tiwai@suse.de>
	<9e4733910904280859t6409e9b7w4eccee65959598e5@mail.gmail.com>
	<s5hk554sow9.wl%tiwai@suse.de>
	<9e4733910904280955u179bc260k80dd955fce6d1c0a@mail.gmail.com>
	<9e4733910904281014t1472281cn48070de201a85a8@mail.gmail.com>
	<s5hd4awr2m9.wl%tiwai@suse.de> <20090428195353.GD4241@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A21524561
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 21:59:55 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so580123qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 12:59:52 -0700 (PDT)
In-Reply-To: <20090428195353.GD4241@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 3:53 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Apr 28, 2009 at 09:37:34PM +0200, Takashi Iwai wrote:
>
>> Also, we need to reconsider which of you change is really needed
>> since the current problem of the PCM will be solved in the PCM
>> core side soon later without the change of the driver side.
>
> AFAICT all the currently posted patches are needed since they're only
> doing the refactoring of the code required to support AC97. =A0They're
> only related to the fixes in that John's board doesn't have I2S but
> since the DMA is shared the fixes that John develops while making AC97
> work will also fix I2S.

I purposely sent in refactoring changes that made no functional
changes to the code.

I have been caught in this mess before. This isn't a simple case of
resolving conflicts. What happens is that git isn't smart enough to
track changes across a refactor. That results in big conflicts
covering most of the contents of the files involved. The conflicts in
the refactor then cascade into all of the other patches.

If we put the refactor in front of the fixes git will get everything right.

Why are people going to complain about patches to a driver marked
broken? You can't even compile it without editing the Kconfig.


>



-- =

Jon Smirl
jonsmirl@gmail.com
