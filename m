From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC updates for 2.6.30
Date: Wed, 11 Mar 2009 15:29:39 +0000
Message-ID: <20090311152938.GA15629@sirena.org.uk>
References: <20090310195551.GA8255@sirena.org.uk>
	<s5htz60czu4.wl%tiwai@suse.de> <49B7CD71.7020606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BFAB1037E3
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 16:29:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49B7CD71.7020606@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gamari <bgamari@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 10:40:49AM -0400, Ben Gamari wrote:
> On 03/11/2009 02:56 AM, Takashi Iwai wrote:
> > Pulled now.  Thanks.

> Can someone see to it that the BeagleBoard machine driver is re-added to 
> sound/soc/omap/Makefile? It seems to have be dropped by accident.

As I said earlier on the OMAP list it's present in ALSA git.  If you
think there's something else for this missing from ALSA git please post
a patch - the only patch that was posted for this was applied in
January.

If you want the patch cherry-picking over into an OMAP development
branch you will need to speak to the people who maintain the relevant
git tree about that or wait for the commit to get merged up from
mainline after the 2.6.30 merge window.
