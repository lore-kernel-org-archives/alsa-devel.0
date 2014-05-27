From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RFC 02/11] sound: ASoC: kirkwood: Remove
	unused drivers
Date: Tue, 27 May 2014 20:18:18 +0200
Message-ID: <20140527181818.GK26379@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-5-git-send-email-andrew@lunn.ch>
 <20140526155901.GF22111@sirena.org.uk>
 <20140527164530.GJ26379@lunn.ch>
 <20140527180047.GA12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id A65AE261A01
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 20:21:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140527180047.GA12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 27, 2014 at 07:00:47PM +0100, Mark Brown wrote:
> On Tue, May 27, 2014 at 06:45:30PM +0200, Andrew Lunn wrote:
> 
> > This is an RFC patch, as it says in the Subject line, and the cover
> > note. It is not intended to be applied yet. Please unapply it, and the
> > other one in the series you have applied.
> 
> Eh?  I thought the discussion was that everything was OK and we were
> going to go ahead with this approach.  Or to put it another way what's
> wrong with this and what's expected to change?

Hi Mark

What is wrong is that the merge path for the first patch, which
removes the boards making use of these drivers, has already closed for
patches.  So we now have boards left in the tree with broken audio. We
can leave it that way, because these boards are actually in the tree
twice. One using DT, which will work as things are now, and old style
board file boards which are broken.

> The only issue you identified in the cover letter was me applying
> some patches I'd already applied

That was my error. I should of also added that you need to apply those
patches before arm-soc closes, so we have time to feed in these
patches. arm-soc generally closes around rc6/rc7, with the mvebu
maintainer closing a little before that.

Since we are past that now, i planned to send these patches next
cycle, without the RFC tag.

       Andrew
