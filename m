From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: dapm: Remove
 snd_soc_of_parse_audio_routing() due to deferred probe
Date: Thu, 18 Dec 2014 18:02:58 +0000
Message-ID: <20141218180258.GZ11285@n2100.arm.linux.org.uk>
References: <1418903548-20935-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id BCE5826046B
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 19:03:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1418903548-20935-1-git-send-email-broonie@kernel.org>
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

On Thu, Dec 18, 2014 at 11:52:28AM +0000, Mark Brown wrote:
> This reverts commit f8781db8aeb18d (ASoC: dapm: Augment existing card
> DAPM routes in snd_soc_of_parse_audio_routing) since it is broken for
> deferred probing as it ends up storing data allocated with devm_ over
> multiple instantiations of the device.
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Thanks Mark - I'll add it for testing this evening.  Please modify the
Reported-by: line to:

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>

please, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
