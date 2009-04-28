From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 16/17] ASoC: Basic split of mpc5200 DMA
	code out from mpc5200_psc_i2s
Date: Tue, 28 Apr 2009 16:16:31 -0400
Message-ID: <9e4733910904281316l57f5873cw45d1cd4c536a9ff@mail.gmail.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
	<1240932222-3718-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljpk233w.wl%tiwai@suse.de>
	<9e4733910904280859t6409e9b7w4eccee65959598e5@mail.gmail.com>
	<s5hk554sow9.wl%tiwai@suse.de>
	<9e4733910904280955u179bc260k80dd955fce6d1c0a@mail.gmail.com>
	<9e4733910904281014t1472281cn48070de201a85a8@mail.gmail.com>
	<s5hd4awr2m9.wl%tiwai@suse.de> <20090428195353.GD4241@sirena.org.uk>
	<9e4733910904281259r1188acb0r7063ea809668b6b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 39FFE10387D
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 22:16:33 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so588117qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 13:16:32 -0700 (PDT)
In-Reply-To: <9e4733910904281259r1188acb0r7063ea809668b6b5@mail.gmail.com>
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

On Tue, Apr 28, 2009 at 3:59 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Tue, Apr 28, 2009 at 3:53 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>> On Tue, Apr 28, 2009 at 09:37:34PM +0200, Takashi Iwai wrote:
>>
>>> Also, we need to reconsider which of you change is really needed
>>> since the current problem of the PCM will be solved in the PCM
>>> core side soon later without the change of the driver side.
>>
>> AFAICT all the currently posted patches are needed since they're only
>> doing the refactoring of the code required to support AC97. =A0They're
>> only related to the fixes in that John's board doesn't have I2S but
>> since the DMA is shared the fixes that John develops while making AC97
>> work will also fix I2S.
>
> I purposely sent in refactoring changes that made no functional
> changes to the code.
>
> I have been caught in this mess before. This isn't a simple case of
> resolving conflicts. What happens is that git isn't smart enough to
> track changes across a refactor. That results in big conflicts
> covering most of the contents of the files involved. The conflicts in

Thinking about this for a couple minutes, what happens is the three
way merge becomes a four or more way merge depending on how many new
files were created in the the refactor. Git doesn't have an n-way
merge tool so it just kicks the entire files out as conflicts.


> the refactor then cascade into all of the other patches.
>
> If we put the refactor in front of the fixes git will get everything righ=
t.
>
> Why are people going to complain about patches to a driver marked
> broken? You can't even compile it without editing the Kconfig.
>
>
>>
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Jon Smirl
jonsmirl@gmail.com
