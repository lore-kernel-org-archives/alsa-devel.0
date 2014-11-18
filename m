From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 25/29] ALSA: oxfw: Add support
	for	Behringer/Mackie devices
Date: Wed, 19 Nov 2014 00:24:40 +0900
Message-ID: <546B64B8.5040405@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
 <1414328610-12729-26-git-send-email-o-takashi@sakamocchi.jp>
 <54690FC0.6020909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7408D2604B6
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 16:25:00 +0100 (CET)
In-Reply-To: <54690FC0.6020909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Nov 17 2014 05:57, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> +++ b/sound/firewire/oxfw/oxfw.c
>> +static bool detect_loud_models(struct fw_unit *unit)
>> +{
>> +	const char *const models[] = {
>> +		"Onyxi",
>> +		"Onyx-i",
>> +		"d.Pro",
>> +		"Mackie Onyx Satellite",
>> +		"Tapco LINK.firewire 4x6",
>> +		"U.420"};
>> +	char model[32] = {0};
> 
> This initialization is not needed.
> 
>> +	unsigned int i;
>> +	int err;
>> +
>> +	err = fw_csr_string(unit->directory, CSR_MODEL,
>> +			    model, sizeof(model));
>> +	if (err < 0)
>> +		return err;
>> +
>> +	model[31] = '\0';
> 
> The returned string is guaranteed to be zero-terminated.
> 
>> +	for (i = 0; i < ARRAY_SIZE(models); i++) {
>> +		if (strncmp(models[i], model, strlen(model) == 0))
> 
> Why not simply strcmp()?
> 
>>  static int name_card(struct snd_oxfw *oxfw)
>>  {
>>  	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
>> +	char vendor[24] = {0};
>> +	char model[32] = {0};
> 
> Same unneeded initialization.

I forgot that fw_csr_string() guarantees to return string with
null-terminated...


Thanks

Takashi Sakamoto
