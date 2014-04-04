From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH] ASoC: rsnd: SSI needs to prepare clocks
 before enabling
Date: Fri, 4 Apr 2014 12:42:50 +0100
Message-ID: <20140404114250.GS4400@trinity.fluff.org>
References: <1396009626-24699-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140329100906.GE21628@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FA252657C9
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:42:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140329100906.GE21628@sirena.org.uk>
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
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, lgirdwood@gmail.com, Ben Dooks <ben.dooks@codethink.co.uk>, magnus.damm@opensource.se, William Towle <william.towle@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 29, 2014 at 10:09:06AM +0000, Mark Brown wrote:
> On Fri, Mar 28, 2014 at 12:27:06PM +0000, Ben Dooks wrote:
> > From: William Towle <william.towle@codethink.co.uk>
> > 
> > The rsnd_ssi_hw_{stop|start} functions need to call clk_prepare_enable()
> > and clk_disable_unprepare(), otherwise the following warning occurs on
> > attempt to play sound:
> 
> This doesn't apply cleanly against current code, can you please check and
> resend - I can't apply this anyway since...
> 
> > Signed-off-by: William Towle <william.towle@codethink.co.uk>
> > [ben.dooks@codethink.co.uk: add more bug info to report]
> > Tested-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> 
> ...you forgot to sign off.  I'm also not seeing the debug info you
> mention in the changelog, indeed there's no error checking.

Ooops. 

I need to re-do this anyway as we need to prepare the clock separately
from the enable, as the enable code is occasionally being called from
an interrupt context.

I anm not sure what you mean by debug info... there is the log from
the WARN_ON() which is trigger from the clock driver.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
