From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix Blackfin I2S _pointer()
 implementation return in bounds values
Date: Wed, 29 Jun 2011 16:36:13 +0100
Message-ID: <4E0B466D.5040800@ti.com>
References: <1308855731-24430-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 02A041038F2
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 17:36:16 +0200 (CEST)
In-Reply-To: <1308855731-24430-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

On 23/06/11 20:02, Mark Brown wrote:
> The Blackfin DMA controller can report one frame beyond the end of the
> buffer in the wraparound case but ALSA requires that the pointer always
> be in the buffer. Do the wraparound to handle this. A similar bug is
> likely to apply to the other Blackfin PCM drivers but the code is less
> obvious to inspection and I don't have a user to test.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
