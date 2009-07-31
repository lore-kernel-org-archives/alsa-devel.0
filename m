From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 06/20] OMAP: McBSP: Use appropriate value
 for startup delay
Date: Fri, 31 Jul 2009 20:25:39 +0300
Message-ID: <20090731202539.c10b29b1.jhnikula__7413.37087606571$1249061107$gmane$org@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<20090730215642.2f509757.jhnikula@gmail.com>
	<1FFEF31EBAA4F64B80D33027D4297760047DF3D65A@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760047DF3D65A@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@nokia.com, linux-omap@vger.kernel.org, eduardo.valentin@nokia.com, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 31 Jul 2009 09:21:30 +0200
<ext-Eero.Nurkkala@nokia.com> wrote:

> Jarkko Nikula [jhnikula@gmail.com] wrote:
> > Are you sure this change is necessary? CLKSRG is kind of master
> > clock to McBSP so original stetson guessed (?) 100 us should be
> > fine for all serial links where bit clock is higher than 20 kHz.
> 
> The McBSP / DMA stuff doesn't really work properly, when PM is enabled
> to full extent. The first DMA goes in _before_ the omap_mcbsp_start(),
> so the higher delay compensates DMA misbehavior in a way...
> 
> .. L/R channels also may switch at random initially with full PM
> enabled. So the L/R fix is only working, if no PM is enabled (sigh).
> 
> Need to make that work fine (no L/R switching and early no DMA
> completions) to get rid of the higher, 500us, timeout. Maybe try not
> having XCCR/RCCR dma enable bit initially, but enabling them at
> omap_mcbsp_start()? (I'd try if I wasn't also on vacation).
> 
Ok, 500 us is not so long delay here compared to benefits but it would
be good to have a little revisit comment for future reference. I think
that by default 100 us provides enough time for two CLKSRG cycles but
due some unknown PM related, clock gating etc. reason it must be
extended to 500 us now.

-- 
Jarkko
