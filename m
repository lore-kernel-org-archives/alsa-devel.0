From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware
	helper	for matching bus and codec drivers
Date: Fri, 18 Jul 2008 11:00:39 +0100
Message-ID: <20080718100037.GB14416@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
	<20080714171632.GH25448@sirena.org.uk>
	<20080718071720.GA2174@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 953F12447D
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 12:08:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080718071720.GA2174@secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2008 at 01:17:20AM -0600, Grant Likely wrote:

> Okay, I've changed my mind.  :-)  I'll back off a bit from this extreme and
> call it:

> sound/soc/fsl/soc-of-simple.c

> Does that sound okay?  If non-freescale chips decide to use it then it
> can be moved out of the freescale director.

Fine by me - you could add an of directory but I don't mind either way
so long as the people actually using the code are happy.
