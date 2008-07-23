From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] Support internal I2S clock sources on
	MPC5200
Date: Wed, 23 Jul 2008 11:36:40 +0100
Message-ID: <20080723103639.GB8377@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CB84724732
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 12:36:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080722235349.11648.90112.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 07:53:49PM -0400, Jon Smirl wrote:
> Support internal I2S clock sources on MPC5200

Looks good from an ASoC point of view.  There's quite a few checkpatch
warnings that should be fixed (all fairly straightforward, though) but
other than that I'm happy to apply it with Grant's ack.
