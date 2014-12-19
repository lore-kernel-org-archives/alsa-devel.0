From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: dapm: Remove
 snd_soc_of_parse_audio_routing() due to deferred probe
Date: Fri, 19 Dec 2014 10:58:40 +0000
Message-ID: <20141219105840.GE11285@n2100.arm.linux.org.uk>
References: <1418903548-20935-1-git-send-email-broonie@kernel.org>
 <20141218180258.GZ11285@n2100.arm.linux.org.uk>
 <20141218180812.GA11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 414992612D6
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 11:58:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141218180812.GA11764@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 18, 2014 at 06:08:12PM +0000, Mark Brown wrote:
> On Thu, Dec 18, 2014 at 06:02:58PM +0000, Russell King - ARM Linux wrote:
> 
> > Thanks Mark - I'll add it for testing this evening.  Please modify the
> > Reported-by: line to:
> 
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> > please, thanks.
> 
> Done.

Great news, the SDP4430 now boots again.  Thanks for the fix, and
Merry Christmas.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

omap-abe-twl6040 sound: ASoC: CODEC DAI twl6040-legacy not registered
omap-abe-twl6040 sound: snd_soc_register_card() failed: -517
platform sound: Driver omap-abe-twl6040 requests probe deferral
...
omap-abe-twl6040 sound: twl6040-legacy <-> 40132000.mcpdm mapping ok
omap-abe-twl6040 sound: dmic-hifi <-> 4012e000.dmic mapping ok

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
