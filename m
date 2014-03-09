From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 14/39] firewire-lib: Add handling output
 connection by CMP
Date: Sun, 09 Mar 2014 22:27:17 +0100
Message-ID: <531CDCB5.7040908@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-15-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A2BA02655DF
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 22:27:54 +0100 (CET)
In-Reply-To: <1394016507-15761-15-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This patch adds some macros, codes with condition of direction and new functions
> to handle output connection. Once cmp_connection_init() is executed with its
> direction, CMP input and output connection can be handled by the same way.

> +++ b/sound/firewire/cmp.c
> +static unsigned long long get_offset(struct cmp_connection *c, bool master)
> +{
> +	unsigned long long offset = CSR_REGISTER_BASE;
> +
> +	if (!master) {
> +		if (c->direction == CMP_INPUT)
> +			offset += CSR_IPCR(c->pcr_index);
> +		else
> +			offset += CSR_OPCR(c->pcr_index);
> +	} else {
> +		if (c->direction == CMP_INPUT)
> +			offset += CSR_IMPR;
> +		else
> +			offset += CSR_OMPR;
> +	}
> +
> +	return offset;
> +}

This function is always used with a constant master parameter, and the
two branches don't really share much code.  Two functions would be simpler:

static u64 mpr_address(struct cmp_connection *c)
{
	if (c->direction == CMP_INPUT)
		return CSR_REGISTER_BASE + CSR_IMPR;
	else
		return CSR_REGISTER_BASE + CSR_OMPR;
}

static u64 pcr_address(struct cmp_connection *c)
{
	if (c->direction == CMP_INPUT)
		return CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index);
	else
		return CSR_REGISTER_BASE + CSR_OPCR(c->pcr_index);
}


Regards,
Clemens
