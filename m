From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] ASoC: DaVinci: McASP FIFO related updates
Date: Wed, 30 Sep 2009 13:13:02 -0700
Message-ID: <4AC3BBCE.3000002@boundarydevices.com>
References: <1254346347-21711-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id A4CE41037EE
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 22:13:15 +0200 (CEST)
In-Reply-To: <1254346347-21711-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Chaithrika U S wrote:
> The DMA params for McASP with FIFO has been updated so that it works for
> various FIFO levels. A member- 'fifo_level' has been added to the DMA
> params data structure. The fifo_level can be adjusted by the tx[rx]_numevt
> platform data. This is relevant only for DA8xx/OMAP-L1xx platforms. This
> implementation has been tested for numevt values 1, 2, 4, 8.
> +	if (fifo_level)
> +		count /= fifo_level;

So can this be fifo_shift instead
		count >>= fifo_shift;
