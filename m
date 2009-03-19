From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/9] ARM: DaVinci: ASoC: Adds ASoC driver
	support for TI DM646X EVM platform
Date: Thu, 19 Mar 2009 10:33:26 -0700
Message-ID: <87r60tl8nt.fsf@deeprootsystems.com>
References: <1237204945-30039-1-git-send-email-naresh@ti.com>
	<200903161038.05404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by alsa0.perex.cz (Postfix) with ESMTP id AC60524384
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 18:33:30 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so721694wfg.23
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 10:33:29 -0700 (PDT)
In-Reply-To: <200903161038.05404.david-b@pacbell.net> (David Brownell's
	message of "Mon\, 16 Mar 2009 10\:38\:05 -0700")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Brownell <david-b@pacbell.net>
Cc: davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Brownell <david-b@pacbell.net> writes:

> On Monday 16 March 2009, Naresh Medisetty wrote:
>> @@ -43,14 +48,14 @@ static int evm_hw_params(struct snd_pcm_substream *s=
ubstream,
>> =A0=A0=A0=A0=A0=A0=A0=A0unsigned sysclk;
>> =A0
>> =A0=A0=A0=A0=A0=A0=A0=A0/* ASP1 on DM355 EVM is clocked by an external o=
scillator */
>
> ... and on this DM646x EVM ... ?
>
>
>> -=A0=A0=A0=A0=A0=A0=A0if (machine_is_davinci_dm355_evm())
>> +=A0=A0=A0=A0=A0=A0=A0if (cpu_is_davinci_dm355() || cpu_is_davinci_dm646=
x())
>
> Shouldn't that stay as a machine_is_*() test,
> just adding a machine_is_davinci_dm646x_evm() case?
>
> Code tends to get modified by clone-and-modify,
> and making this code be cpu-specific instead of
> board-specific will thus promote errors.
>
> On top of that, there's currently an effort to
> minimize the amount of cpu_is_*() testing found
> in drivers.  Patches that increase such testing,
> especially needlessly increasing it!, seem to be
> the wrong direction...
>

Agreed.

In an earlier thread, I mentioned that some of this board and chip
specific code does not belong in sound/asoc/* at all, but Mark seemed
to think it does so it can better stay in sync with ALSA API change
etc., which makes sense to m.

That being said, some effort should be made to split out the
chip/board specific settings into platform data which can be managed
by chip/board specific code.

Kevin
