From: "Oskar Schirmer" <oskar@scara.com>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
Date: 1 Nov 2013 10:17:50 +0000
Message-ID: <20131101101750.GB16492@curry>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org, perex@perex.cz, r65073@freescale.com, LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com, grant.likely@linaro.org, devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Not that it would improve functionality, but:

On Fri, Nov 01, 2013 at 15:04:53 +0800, Xiubo Li wrote:
[...]
> diff --git a/sound/soc/fsl/fsl-sgtl5000-vf610.c b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> new file mode 100644
> index 0000000..f535b42
> --- /dev/null
> +++ b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> @@ -0,0 +1,208 @@
> +/*
> + * Freeacale ALSA SoC Audio using SGT1500 as codec.
          ^                             ^   ^
     "Freescale"                    "SGTL5000"

regards,
  Oskar
