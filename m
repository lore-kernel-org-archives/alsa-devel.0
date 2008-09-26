From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
	3/3: adding directories)
Date: Fri, 26 Sep 2008 15:24:52 +0100
Message-ID: <20080926142452.GF15493@sirena.org.uk>
References: <48DCAA3A.8030209@atmel.com> <20080926125035.GB15493@sirena.org.uk>
	<48DCEF39.40003@endrelia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6670824358
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:24:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48DCEF39.40003@endrelia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Mandarino <fmandarino@endrelia.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 26, 2008 at 10:18:33AM -0400, Frank Mandarino wrote:

> Now that there are other Atmel ASoC machine drivers in the kernel, and
> given the fact that our company does not have the resources to actively
> maintain it, I think the eti_b1_wm8731.c driver should be removed.

> This reduces the effort in maintaining ASoC, as eti_b1_wm8731.c would no
> longer have to be kept up-to-date with ASoC changes.  It also eases the
> pressure on me to test ASoC updates against eti_b1_wm8731.c as they are
> made.

> So unless you or Mark feels the eti_b1_wm8731.c driver should remain in
> the kernel source, I'll submit a patch to remove it after your patches
> are in place.

Sounds like a plan - may be just as well to submit the patch now given
that Sedji is modifying the driver anyway, it might make his life
slightly easier?
