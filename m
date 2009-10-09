From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage
	of regulator	framework to control avdd_dac
Date: Fri, 9 Oct 2009 11:19:45 +0100
Message-ID: <20091009101945.GA23679__29098.6994783909$1255084305$gmane$org@opensource.wolfsonmicro.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com>
	<1255004227.30157.159.camel@eenurkka-desktop>
	<1FFEF31EBAA4F64B80D33027D42977600E85F0CC91@NOK-EUMSG-02.mgdnok.nokia.com>
	<1C729A43-F9F2-4FF6-A07E-5450E595982B@opensource.wolfsonmicro.com>
	<1255062483.30157.171.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255062483.30157.171.camel@eenurkka-desktop>
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
Cc: "<tony@atomide.com>" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<alsa-devel@vger.kernel.org>" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2009 at 07:28:03AM +0300, Eero Nurkkala wrote:
> On Thu, 2009-10-08 at 18:01 +0200, ext Mark Brown wrote:

> > I'd expect the usage would be that after the audio subsystem has been  
> > idle for some configurable period of time the core would bring the  
> > audio subsystem down to bias off, at which point supplies could also  
> > be switched off.

> Right. That would also sound like the RST line also needs also be
> asserted, and then rewriting all register contents upon wakeup? And also
> redirecting all i2c traffic to the cache instead of any real i2c writes
> (meanwhile the device is shut down)? Like in tpa6130?

Yes.  I'd expect that if this is being implemented there'll be some
degree of assistance from the core for some of this.
