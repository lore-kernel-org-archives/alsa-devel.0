From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/3] ASoC: Davinci: McASP: add support new
 McASP IP Variant
Date: Wed, 03 Oct 2012 00:28:45 +0200
Message-ID: <506B6A9D.3090100@gmail.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 31.08.2012 14:50, Hebbar, Gururaja wrote:
> The OMAP2+ variant of McASP is different from Davinci variant w.r.to some
> register offset and missing generic SRAM APIs support
> 
> Changes
> - Add new MCASP_VERSION_3 to identify new variant. New DT compatible
>   "ti,omap2-mcasp-audio" to identify version 3 controller.
> - The register offsets are handled depending on the version.
> - Provide a config option to indicate missing SRAM API support.

Could you give some insight which hardware this was tested on? I'm
trying to get this up and running on a AM33xx board, and the patches
look all reasonable to me. My problem is that I can't make the DMA
engine move forward, I fail to receive a single interrupt on this
peripheral after the stream starts. I will continue searching for the
reason of this tomorrow, but maybe you can give me some hint by
explaining your setup?

Note that I'm using your patches together with Matt's from this series:

  https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-rfc-v1

... but it doesn't work without those either.



Thanks,
Daniel
