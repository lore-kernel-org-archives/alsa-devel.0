From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add some system
	information	to	alsa-info.sh output
Date: Tue, 1 Jul 2008 10:52:55 +0100
Message-ID: <20080701095255.GB9730@sirena.org.uk>
References: <1214843497.11032.4.camel@temp-fallen>
	<20080630164210.GC21804@sirena.org.uk>
	<1214847360.11032.9.camel@temp-fallen>
	<20080701093452.GA14666@rakim.wolfsonmicro.main>
	<s5h7ic6exvn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D6F5B2433E
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 11:52:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7ic6exvn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Travis Place <wishie@wishie.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2008 at 11:50:52AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > The particular output varies with platform and some platforms allow
> > machine drivers to add entirely custom fields - it's probably safest to
> > just include the entire file.

> Agreed.  Maybe better to be marked to collapse, since this wouldn't be
> important in most cases with x86* architectures.

Yeah - I meant to only suggest including this information if there was
no DMI information available.
