From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Ubuntu - Alsa Installation Script
Date: Thu, 30 Oct 2008 19:55:10 +0000
Message-ID: <20081030195509.GB13678@sirena.org.uk>
References: <d9690f190810300103x31492740r9aa31830ea233f36@mail.gmail.com>
	<200810310200.00960.wishie@wishie.net>
	<d9690f190810300925v5f2480e9vc7342a343c4290b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BCA61037F5
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 20:55:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d9690f190810300925v5f2480e9vc7342a343c4290b1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>
Cc: alsa-devel@alsa-project.org, Travis Place <wishie@wishie.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 05:25:29PM +0100, Klaus Schulz wrote:

> 2. If I got two or more  kernels on the system I don't know how to install
> Alsa manually on both of them

You probably want to look into hooking the kernel parts of ALSA into
DKMS for this - doing that would be useful for users on all distros, not
just Ubuntu.  It's a standard for building out of tree modules for
distro kernels automatically which ought to deal with this for you.
