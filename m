From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic23 fix rate selection
Date: Wed, 18 Nov 2009 13:25:21 +0000
Message-ID: <20091118132521.GC698@sirena.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C9109@dbde02.ent.ti.com>
	<1258491061-11633-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 56219243DD
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 14:25:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258491061-11633-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: anuj.aggarwal@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2009 at 01:51:01PM -0700, Troy Kisky wrote:
> Fix the ordering of sr_valid_mask array.
> The lower bit of the index represents USB
> not bosr.

> Reported-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Applied, thanks.
