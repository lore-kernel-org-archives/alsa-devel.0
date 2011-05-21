From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] ASoC: core: Don't set "(null)" as a
	driver name
Date: Sat, 21 May 2011 18:58:01 +0800
Message-ID: <20110521105800.GA25146@opensource.wolfsonmicro.com>
References: <1305895660-15383-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93CB210381D
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 12:58:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1305895660-15383-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2011 at 03:47:40PM +0300, Jarkko Nikula wrote:
> Commit 22de71b ("ASoC: core - allow ASoC more flexible machine name")
> writes "(null)" to driver name string in struct snd_card if card->driver_name
> is NULL. This causes segmentation faults with some user space ALSA utilities
> like aplay and arecord.

Applied, thanks.
