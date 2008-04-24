From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2][ASoC v2] Replace snd_soc_free_codec
	with snd_soc_unregister_codec
Date: Thu, 24 Apr 2008 21:56:27 +0100
Message-ID: <20080424205625.GC19029@sirena.org.uk>
References: <1209064017-5147-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DCE112464C
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 22:56:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1209064017-5147-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 24, 2008 at 02:06:57PM -0500, Timur Tabi wrote:

> So we replace snd_soc_free_codec() with snd_soc_unregister_codec().  This new
> function only unregisters the codec but does not free the memory resources.
> The caller can now allocate and free the memory resources as it sees fit.

Thanks!  I've applied this locally and will push it out into the ASoC v2
git branch after some testing.

> Also updated all callers of snd_soc_free_codec() to call
> snd_soc_unregister_codec() instead and free the resources themselves.

As discussed on IRC we should probably also convert all codec drivers to
embed the struct snd_soc_codec in their private_data.
