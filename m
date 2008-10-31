From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Ubuntu - Alsa Installation Script
Date: Fri, 31 Oct 2008 11:17:04 +0000
Message-ID: <20081031111703.GB7516@sirena.org.uk>
References: <d9690f190810300103x31492740r9aa31830ea233f36@mail.gmail.com>
	<200810310200.00960.wishie@wishie.net>
	<d9690f190810300925v5f2480e9vc7342a343c4290b1@mail.gmail.com>
	<20081030195509.GB13678@sirena.org.uk>
	<490A151A.3090109@fungus.sh.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C3F1244F5
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 12:17:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <490A151A.3090109@fungus.sh.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel T Chen <crimsun@fungus.sh.nu>
Cc: alsa-devel@alsa-project.org, Klaus Schulz <kls.schlz@googlemail.com>, Travis Place <wishie@wishie.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 04:12:10PM -0400, Daniel T Chen wrote:

> Luke Yelavich and I have briefly discussed using DKMS foralsa-driver in
> modules are relevant (i.e., predicting the future is, uh, hard)?  Preparing
> an integrated HDA codec is straightforward, but what for a USB audio
> device?

USB audio is fairly straightforward for the most part since there's a
standard class for it.  TBH I'd been more thinking of just installing
the ALSA drivers wholesale rather than only trying to cherry pick the
drivers when they're needed.
