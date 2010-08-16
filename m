From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Mon, 16 Aug 2010 11:07:05 +0100
Message-ID: <20100816100705.GA3276@rakim.wolfsonmicro.main>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDBDC10381E
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 12:07:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 16, 2010 at 10:29:30AM +0300, Jarkko Nikula wrote:
> This optional kcontrol_prefix allows to specify unique prefix for ALSA
> control names for each DAI link. This makes possible to have a sound card
> configuration with multiple DAIs and each of them using the same codec
> driver without name collision.

This isn't going to work in general - consider what happens for CODECs
with multiple DAIs, or for devices with no DAIs at all like external
analogue amps.  We do need to do this but it probably needs to be per
CODEC rather than per link I fear.
