From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/4] ALSA: dice: force to add two pcm
 devices for listed models
Date: Sun, 6 Mar 2016 21:39:48 +0900
Message-ID: <56DC2514.2010101@sakamocchi.jp>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D6545260591
 for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2016 13:39:53 +0100 (CET)
In-Reply-To: <20160305160733.6306be3f@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 6 2016 00:07, Stefan Richter wrote:
> On Mar 05 Takashi Sakamoto wrote:
>> +static bool force_two_pcm_support(struct fw_unit *unit)
>> +{
>> +	const char *const models[] = {
>> +		/* TC Electronic models. */
>> +		"StudioKonnekt48",
>> +		/* Focusrite models. */
>> +		"SAFFIRE PRO 40",
>> +		"LIQUID SAFFIRE 56",
>> +		"SAFFIRE PRO 40 1",
>> +	};
>> +	char model[32];
>> +	unsigned int i;
>> +	int err;
>> +
>> +	err = fw_csr_string(unit->directory, CSR_MODEL, model, sizeof(model));
>> +	if (err < 0)
>> +		return false;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(models); i++) {
>> +		if (strcmp(models[i], model) == 0)
>> +			break;
>> +	}
>> +
>> +	return i < ARRAY_SIZE(models);
>> +}
> 
> The model name of my old Saffire PRO 40 is "SAFFIRE_PRO_40", and
> according to e.g. Alban Bernard on ffado-user, the newer model is
> "SAFFIRE_PRO_40_1".  Saffire 56's name is "LIQUID_SAFFIRE_56"
> according to https://forum.ubuntuusers.de/topic/focusrite-liquid/.

OK. Thanks for your correction. I'll include them in next patchset.

Well, can this patchset enable snd-dice to drive your Saffire Pro 40
with several isochronous streams?  (of cource, the strings should be fixed.)


Regards

Takashi Sakamoto
