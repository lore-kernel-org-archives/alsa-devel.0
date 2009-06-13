From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Sat, 13 Jun 2009 11:37:33 +0200
Message-ID: <ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 26537243B5
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 11:37:35 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3601396qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2009 02:37:33 -0700 (PDT)
In-Reply-To: <20090604085921.GD6983@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 4, 2009 at 10:59 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 03, 2009 at 09:26:34PM -0400, Mike Frysinger wrote:
>
>> it could be. =A0i was going by the changes that werent in 2.6.30. =A0i
>> thought i looked for previous submissions, but i must have missed
>> previous attempts. =A0i'm not familiar with alsa stuff, so i'm not
>
> The patch hadn't previously been sent in that form but it looks like
> it's attempting to fix a bug which had had some previous goes at fixing
> it that required updates.
>
>> always sure when i need to bang on Cliff to get things fixed up
>> (changes split / better comments / etc...).
>
> If you're not sure there's a case for better changelogs at least! :)
>
>> if fixes miss a merge window, then that's an issue. =A0but in general,
>> users only see fixes per release, so sending things more quickly there
>> wouldnt really help ?
>
> The issue is that things are missing merge windows - they're getting
> sent in but if there's any review comments a revised version of the
> patch isn't getting posted until the next batch of submissions. =A0It's
> these revisions rather than the initial submissions that I'm concerned
> about.
>

This - f692fce - should not have reached upstream, how come ?
