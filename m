From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3 08/16] ALSA: Oxygen: Add new CS4245 SPI
 functions
Date: Sat, 18 Jan 2014 11:36:14 +0100
Message-ID: <52DA591E.8050705@ladisch.de>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
 <1389971315-3215-8-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B526C261A28
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 11:36:26 +0100 (CET)
In-Reply-To: <1389971315-3215-8-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Roman Volkov wrote:
> +int cs4245_shadow_control(struct oxygen *chip, enum cs4245_shadow_operation op)
> +{
> +	unsigned char addr;
> +	int ret;
> +
> +	for (addr = 1; addr < ARRAY_SIZE((((struct dg *)0)->cs4245_shadow));
> +								addr++) {

This looks ugly (and there's one pair of parentheses too many).  Just
include the line "struct dg *data = chip->model_data;" in this function.


Regards,
Clemens
