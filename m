From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 25/29] ALSA: oxfw: Add support
	for	Behringer/Mackie devices
Date: Sun, 16 Nov 2014 21:57:36 +0100
Message-ID: <54690FC0.6020909@ladisch.de>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
 <1414328610-12729-26-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 020EB2612CC
 for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2014 21:57:50 +0100 (CET)
In-Reply-To: <1414328610-12729-26-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> +++ b/sound/firewire/oxfw/oxfw.c
> +static bool detect_loud_models(struct fw_unit *unit)
> +{
> +	const char *const models[] = {
> +		"Onyxi",
> +		"Onyx-i",
> +		"d.Pro",
> +		"Mackie Onyx Satellite",
> +		"Tapco LINK.firewire 4x6",
> +		"U.420"};
> +	char model[32] = {0};

This initialization is not needed.

> +	unsigned int i;
> +	int err;
> +
> +	err = fw_csr_string(unit->directory, CSR_MODEL,
> +			    model, sizeof(model));
> +	if (err < 0)
> +		return err;
> +
> +	model[31] = '\0';

The returned string is guaranteed to be zero-terminated.

> +	for (i = 0; i < ARRAY_SIZE(models); i++) {
> +		if (strncmp(models[i], model, strlen(model) == 0))

Why not simply strcmp()?

>  static int name_card(struct snd_oxfw *oxfw)
>  {
>  	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
> +	char vendor[24] = {0};
> +	char model[32] = {0};

Same unneeded initialization.


Regards,
Clemens
