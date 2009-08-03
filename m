From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 11/20] OMAP: McBSP: Add link DMA mode
	selection
Date: Mon, 3 Aug 2009 13:15:21 +0300
Message-ID: <20090803101521.GB16412__47184.064743533$1249453208$gmane$org@esdhcp037198.research.nokia.com>
References: <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<20090730130442.GD9975@sirena.org.uk>
	<20090730132808.GA22978@esdhcp037198.research.nokia.com>
	<20090730134725.GA29631@rakim.wolfsonmicro.main>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090730134725.GA29631@rakim.wolfsonmicro.main>
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
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 30, 2009 at 03:47:25PM +0200, ext Mark Brown wrote:
> On Thu, Jul 30, 2009 at 04:28:08PM +0300, Eduardo Valentin wrote:
> > On Thu, Jul 30, 2009 at 03:04:42PM +0200, ext Mark Brown wrote:
> 
> > > Is this really something that people would want to tweak at runtime
> > > (except for test purposes)?
> 
> > Yes, test purposes, bug also, the same link could be sometime used for low-power
> > playback while sometime for low-latency processing where as accurate as
> > possible DMA pointer position info is needed.
> 
> Latency you *should* be able to infer from the application behaviour.
Yes that's true. But I think using ELEMENT mode, position reports are much more accurate,
which will result in more precise inferences for latencies.


-- 
Eduardo Valentin
