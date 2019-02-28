From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: hdmi-codec: modifying params in hw_params() callback
Date: Thu, 28 Feb 2019 12:15:16 +0000
Message-ID: <20190228121516.swd3vweisgcxlvld@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi all,

While looking at hdmi-codec issues, I spotted this code:

static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
                                struct snd_pcm_hw_params *params,
                                struct snd_soc_dai *dai)
{
...
        if (params_width(params) > 24)
                params->msbits = 24;

params->msbits is a parameter that is negotiated and refined by
libasound, and is part of the ALSA constraint system.  The "Writing an
ALSA driver" documentation says about the hw_params callback:

"This is called when the hardware parameter (``hw_params``) is set up
 by the application, that is, once when the buffer size, the period
 size, the format, etc. are defined for the pcm substream."

which suggests we should only be reading the parameters, not writing
to them.

What's more is that the msbits is a parameter that is refined with
userspace, so surely the above should be a declared constraint?

Digging a bit deeper, ASoC passes a private copy of the params to each
codec - a copy is made, then fixups for TDM slots are applied, followed
by any topology fixups by the DAI link (be_hw_params_fixup) before the
codec driver's hw_params() callback is made.  Afterwards, ASoC reads
back the rate, channels and physical (memory) width and stores them
in the codec's DAI structure.  The msbits are not read.

hdmi-codec also seems to do nothing with the msbits parameter other
than the above code.

So, all in all, it seems that the above code limiting msbits is
redundant - nothing will read this modified value.  Can we kill it?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
