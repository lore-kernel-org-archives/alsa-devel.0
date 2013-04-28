From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3/3] Add handling CMP output connection
Date: Sun, 28 Apr 2013 14:52:25 +0200
Message-ID: <517D1B89.506@ladisch.de>
References: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
 <1367125189-377-4-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B9D2B2616C5
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2013 14:52:48 +0200 (CEST)
In-Reply-To: <1367125189-377-4-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> To handle CMP output connection, this patch adds some macros, codes with
> condition of direction and new functions. Once cmp_connection_init() is
> executed with its direction, CMP input and output connection can be
> handled by the same way.

> +++ b/sound/firewire/cmp.c

> +	if (c->direction == CMP_INPUT)
> +		offset = CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index);
> +	else
> +		offset = CSR_REGISTER_BASE + CSR_OPCR(c->pcr_index);

This code is used twice and could be moved into a helper function.

> +static int get_overhead_id(struct cmp_connection *c)

> +	/*
> +	 * apply "oPCR overhead ID encoding"
> +	 * the encoding table can convert up to 512.
> +	 * here the value over 512 is converted as the same way as 512.
> +	 */

	/*
	 * Apply "oPCR overhead ID encoding":
	 * The encoding table can convert up to 512.
	 * Here any value over 512 is converted in the same way as 512.
	 */

> +	for (id = 1; id < 16; id += 1) {
> +		if (c->resources.bandwidth_overhead < (id << 5))
> +			break;
> +	}
> +	if (id == 16)
> +		id = 0;

	id = DIV_ROUND_UP(c->resources.bandwidth_overhead, 32);
	if (id >= 16)
		id = 0;

> +static __be32 opcr_set_modify(struct cmp_connection *c, __be32 opcr)

> +	/* generate speed and extended speed field value */

This comment is superfluous; it does not tell anything non-obvious about
the code.

> +	/*
> +	 * here zero is applied to payload field.
> +	 * it means the maximum number of quadlets in an isochronous packet is
> +	 * 1024 when spd is less than three, 1024 * 2 * xspd + 1 when spd is
> +	 * equal to three. An arbitrary value can be set here but 0 is enough
> +	 * for our purpose.
> +	 */
> +	opcr |= cpu_to_be32(0 << OPCR_PAYLOAD_SHIFT);

In an oPCR, the payload field is changed only by the device.


Regards,
Clemens
