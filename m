From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [patch] ASoC: sigmadsp: uninitialized variable in
	sigmadsp_activate_ctrl()
Date: Thu, 27 Nov 2014 09:09:41 +0100
Message-ID: <5476DC45.6030809@metafoo.de>
References: <20141126223516.GB443@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-064.synserver.de (smtp-out-064.synserver.de
 [212.40.185.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 529BE265DD8
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 09:09:36 +0100 (CET)
In-Reply-To: <20141126223516.GB443@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/26/2014 11:35 PM, Dan Carpenter wrote:
> The "changed" variable should be set to false at the start.
>
> Fixes: a35daac77a03 ('ASoC: sigmadsp: Add support for fw v2')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
