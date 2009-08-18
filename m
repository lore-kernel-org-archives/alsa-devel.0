From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix data format configuration
	for	S3C64XX IISv2
Date: Tue, 18 Aug 2009 14:05:25 +0100
Message-ID: <20090818130524.GA24620@sirena.org.uk>
References: <4A8AA4F3.3010907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 63795246B5
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 15:05:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A8AA4F3.3010907@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 18, 2009 at 09:56:19PM +0900, Joonyoung Shim wrote:
> The data format configuration for S3C64xx IISv2 was hardcoded for IISMOD
> register. This patch changes to the defined values it.

> And instead of bits 9 and 10 of IISMOD we should clear bits 13 and 14.

Thanks - there's quite a few problems with this area.

Can you confirm if you've got the device DMAing usable audio (and if so
in what configuration)?
