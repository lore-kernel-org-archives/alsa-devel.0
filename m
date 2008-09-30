From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 3/5] [RFC] ALSA ASOC Adds DSP DAI format
 support for platform driver
Date: Tue, 30 Sep 2008 16:11:38 +0300
Message-ID: <20080930161138.41de23b3.jarkko.nikula__7135.16940963945$1222780447$gmane$org@nokia.com>
References: <dfeb90390809290250x7c9d3aafh232fbcbe8ae77d7e@mail.gmail.com>
	<20080929141540.e6ae8ead.jarkko.nikula@nokia.com>
	<dfeb90390809292341l2264ff52m80830952b38ea25f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <dfeb90390809292341l2264ff52m80830952b38ea25f@mail.gmail.com>
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
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Sep 2008 12:11:45 +0530
"ext Arun KS" <arunks@mistralsolutions.com> wrote:

> > I think this is not enough. The word clock length equals to one BCLK
> > cycle in DSP mode. Not n channel bit BCLK cycles like in I2S.
> >
> 
> In DSP Mode, Frame sync is followed by two data words.
> I tested this patch and its working. Am i missing something ?
> 
I meant length of FS/LRC[IN | OUT] signal itself. E.g. see figures 3-7
and 3-8 in AIC23 data manual:

http://www.ti.com/lit/gpn/tlv320aic23

Now omap-mcbsp.c sets this FS length to 16 BCLK periods in
omap_mcbsp_dai_hw_params. Currently code is pretty much tailored for
16-bit stereo I2S so probably some McBSP configuration bits are better
set in another function than currently :-)


Jarkko
