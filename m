From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: fsl: pcm030-audio-fabric use
 snd_soc_register_card
Date: Sat, 22 Sep 2012 11:01:54 -0400
Message-ID: <20120922150153.GF4495@opensource.wolfsonmicro.com>
References: <1348151805-93991-1-git-send-email-emillbrandt@dekaresearch.com>
 <1348151805-93991-2-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5059F261643
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 17:01:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1348151805-93991-2-git-send-email-emillbrandt@dekaresearch.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 20, 2012 at 10:36:44AM -0400, Eric Millbrandt wrote:
> Convert pcm030-audio-fabric to use the new snd_soc_register_card api
> instead of the older method of registering a separate platform device.
> Create the dai_link to the mpc5200_psc_ac97 platform using the device tree.
> Convert the pcm030-audio-fabric driver to a platform-driver and add a
> remove function.

Applied, thanks.
