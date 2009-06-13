From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC
	codec:	SSM2602: assign last substream to the master when
	shutting down
Date: Sat, 13 Jun 2009 11:44:36 +0100
Message-ID: <20090613104435.GA4795@sirena.org.uk>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
	<ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9211F24426
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 12:44:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2009 at 11:37:33AM +0200, Karl Beldan wrote:

> This - f692fce - should not have reached upstream, how come ?

The entire discussion of the patch occurred in response to my saying I'd
applied it, with most of the discussion being a couple of days later
after it'd have already gone into ALSA.  Since nobody asked to have it
reverted or indicated that there was any actual problem other than a
repitition of code it wasn't reverted.  For the most part repitition
in ASoC would just be a no-op and therefore a code quality rather
than behavioural issue.  As I indicated when accepting the patch I've
lowered my standards there for blackfin due to the past issues with
iteration speed (which Mike has already said will be being addressed
now).

I've now reverted the shutdown hunk of the patch where duplication will
actually introduce a bug.
