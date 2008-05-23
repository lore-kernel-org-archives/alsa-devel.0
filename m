From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about "control names"
Date: Fri, 23 May 2008 11:49:55 +0100
Message-ID: <20080523104954.GA14608@sirena.org.uk>
References: <200805231028.22282.jbe@pengutronix.de>
	<4836902D.7000408@alsa-project.org>
	<200805231201.41820.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200805231201.41820.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 23, 2008 at 12:01:41PM +0200, Juergen Beisert wrote:
> On Friday 23 May 2008 11:36, Clemens Ladisch wrote:
> > Juergen Beisert wrote:

> > > names, its confusing (BTW: "Line Bypass Capture Volume" is of type
> > > SNDRV_CTL_ELEM_TYPE_ENUMERATED).

> > This may be caused by the control type.  Why is the volume "enumerated"?

> Its not linear. Its defined in dB and has some "holes" in it.
> When I change it to SNDRV_CTL_ELEM_TYPE_INTEGER I see the slider in the 
> [Capture] screen, and also something at its bottom, but I can't switch 
> anything:

Couldn't this be covered by providing TLV ranges for it?
