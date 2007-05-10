From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] SH7760 ASoC support
Date: Thu, 10 May 2007 15:07:39 +0200
Message-ID: <20070510130739.GA9903@roarinelk.homelinux.net>
References: <20070510120833.GA9539@roarinelk.homelinux.net>
	<20070510125817.GC18534@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070510125817.GC18534@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>, alsa-devel@alsa-project.org, linuxsh-dev@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2007 at 09:58:17PM +0900, Paul Mundt wrote:
> On Thu, May 10, 2007 at 02:08:33PM +0200, Manuel Lauss wrote:
> > +##
> > +## Audio unit modules
> > +##
> > +
> > +config SND_SOC_SH4_HAC
> > +	select AC97_BUS
> > +	select SND_SOC_AC97_BUS
> > +	select SND_AC97_CODEC
> > +	tristate
> > +
> > +config SND_SOC_SH4_SSI
> > +	tristate
> > +
> This might seem like a silly question, but how are these two supposed to
> be enabled? At the very least you should have some dependencies on the
> CPU subtypes that support these blocks.
> 
> > +
> > +
> > +##
> > +## Boards
> > +##
> > +
> Or are you expecting that the board-specific code will simply select
> these?

That was the idea; the other ASoC boards do similar things.
 
> Are you planning on submitting a stub that enables these? Or is this just
> to be a placeholder until some board wants them?

I suppose I can submit my AC97 board code, it does not depend
on anything that is not already submitted.

I'll add the ac97 board code to the patch and re-submit it.

Thanks,
	Manuel Lauss

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
