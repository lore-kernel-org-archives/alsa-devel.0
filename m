From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
Date: Mon, 5 Aug 2013 12:33:10 +0100
Message-ID: <20130805113310.GU23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130805112733.GY9858@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 05, 2013 at 12:27:33PM +0100, Mark Brown wrote:
> On Sun, Aug 04, 2013 at 08:31:04PM +0100, Russell King wrote:
> > Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
> > I2S inputs/outputs.
> 
> > +	{ "i2sdi",		NULL,	"Capture" },
> > +	{ "Playback",		NULL,	"i2sdo" },
> 
> This doesn't look good - this is adding DAPM routes which should
> correspond to the DAI link that's already been configured.

No, you're wrong there:

CPU DAI:				Codec DAI
dma-playback	--->	i2sdo	--->	Playback
		`-->	spdifdo -> not connected
dma-capture	<---	i2sdi	<---	Capture

And the intermediate level is needed to determine which outputs from
the chip are wired up.

This structure, which is what ASoC normally does, for this SoC is wrong:

CPU DAI:		Codec DAI
dma-playback	--->	Playback
dma-capture	<---	Capture

because it contains no information on how the connectivity between the
codec and DAI is performed.

And don't even say "use dpcm" - if you say that, I want _you_ to write
it because dpcm is totally and utterly unusable as it currently stands -
as you can see from all the emails I've sent over the weekend.
