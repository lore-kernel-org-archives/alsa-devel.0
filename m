From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] alsa: Add support for timberdale I2S block
Date: Mon, 26 Oct 2009 13:09:31 +0000
Message-ID: <20091026130931.GA18781@sirena.org.uk>
References: <4AE59E01.9000802@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 56F53244EE
	for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2009 14:09:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AE59E01.9000802@mocean-labs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard R?jfors <richard.rojfors@mocean-labs.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 26, 2009 at 02:02:57PM +0100, Richard R?jfors wrote:
> This driver adds support for the I2S block of the timberdale FPGA.
> 
> The timberdale is a FPGA found on intel development boards for
> In-Vehicle Infotainment.
> 
> The block has support for up to 8 I2S channels, can be clocked
> from either the FPGA or the device side.
> 
> This driver introduces support for this block, by exposing each
> I2S channel as an ALSA PCM channel.
> 
> Signed-off-by: Richard R?jfors <richard.rojfors@mocean-labs.com>

Without having investigated in any great detail I'd really expect this
driver to be done within ASoC if it's producing generic I2S output.  If
it's producing I2S out then presumably system designers will be able to
attach whatever CODECs they desire and if those CODECs require any soft
control then there will be a need to interoperate with CODEC drivers.
