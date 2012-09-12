From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] ASoC: fsl: mpc5200-soc-audio driver
Date: Tue, 11 Sep 2012 20:33:45 -0600
Message-ID: <504FF489.6040307@wwwdotorg.org>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-4-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D9732615E3
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 04:33:48 +0200 (CEST)
In-Reply-To: <1347416089-23393-4-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/11/2012 08:14 PM, Eric Millbrandt wrote:
> Add a generic mpc5200 driver that allows asoc cards to be defined in the
> device tree.

> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt

> +A sound node is defined for each asoc platform.  A sound node must
> +have at least one child DAI node.
> +- card-name           - The card name to register in asoc
> +- audio-platform      - Contains a phandle to a ac97 or i2s node
> +- number-of-dais      - The number of DAIs defined

Can't you get that value simply by counting all the child nodes? It
seems redundant.
