From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Wed, 2 Jul 2014 19:02:12 +0100
Message-ID: <20140702180212.GS32514@n2100.arm.linux.org.uk>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20140702195154.47d6f6b4@armhf>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 02, 2014 at 07:51:54PM +0200, Jean-Francois Moine wrote:
> On Wed, 2 Jul 2014 18:56:28 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > How well will this work with Russell concept of a front end and two
> > backends? Can you uses your CODEC twice, once with the I2S backend and
> > a second time with the S/PDIF backend?
> 
> Hi Andrew,
> 
> The TDA998x CODEC has two functions:
> - it sets the possible formats and rates when the screen connects and
> - it sets the audio input port when audio streaming starts.
> 
> I tested this CODEC with both DAPM and DPCM. If the audio subsystem
> asks for streaming on both I2S and S/PDIF, only the last call is served
> (this depends on the order of the DAI links in the audio card creation
> table).
> 
> As I told to Russell, DPCM just asks for a 'system' DAI (front-end),
> but it also asks for some additional code in the kirkwood DMA driver
> because all PCMs are activated on streaming start.

Well, as far as I'm concerned right now, it's for Mark to sort out this
situation, and tell us what he wants to do with the Kirkwood stuff.  I
suspect he's keeping quiet because he doesn't care about it.

Given that he's the one with the knowledge of DPCM, and he's the maintainer
of ASoC, he has the ultimate responsibility for sorting out this and
giving direction as to how he wants to proceed.

As I understand it though, my solution is the full and proper DPCM solution,
and I believe that what's currently in mainline is not a DPCM solution.

Mark needs to correct that, because he is one of the few who knows this
stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
