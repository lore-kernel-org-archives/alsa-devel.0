From: Daniel T Chen <crimsun@fungus.sh.nu>
Subject: Re: Ubuntu - Alsa Installation Script
Date: Thu, 30 Oct 2008 16:12:10 -0400
Message-ID: <490A151A.3090109@fungus.sh.nu>
References: <d9690f190810300103x31492740r9aa31830ea233f36@mail.gmail.com>	<200810310200.00960.wishie@wishie.net>	<d9690f190810300925v5f2480e9vc7342a343c4290b1@mail.gmail.com>
	<20081030195509.GB13678@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id D94A524524
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 21:12:04 +0100 (CET)
In-Reply-To: <20081030195509.GB13678@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>, Travis Place <wishie@wishie.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/30/2008 03:55 PM, Mark Brown wrote:

>
> You probably want to look into hooking the kernel parts of ALSA into
> DKMS for this - doing that would be useful for users on all distros, not
> just Ubuntu.  It's a standard for building out of tree modules for
> distro kernels automatically which ought to deal with this for you.
Luke Yelavich and I have briefly discussed using DKMS foralsa-driver in
Ubuntu 9.04, because maintaining it in-tree is problematic given the pace
at which quirks are added (e.g., pci/hda/patch_*.c).  At the developers
summit in Mountain View, CA, in December, we'll be investigating the
feasibility of using DKMS to compile newer drivers as hardware is
hotplugged.  At least one gotcha is present:  how does one determine which
modules are relevant (i.e., predicting the future is, uh, hard)?  Preparing
an integrated HDA codec is straightforward, but what for a USB audio
device?
