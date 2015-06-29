From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH lib] Replace unsafe characters with _ in
	card name
Date: Mon, 29 Jun 2015 22:44:47 +0500
Message-ID: <5591840F.9070705@gmail.com>
References: <1435415569-17771-1-git-send-email-patrakov@gmail.com>
 <s5hh9pqed36.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id D7FFE2654CD
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 19:44:49 +0200 (CEST)
Received: by wgjx7 with SMTP id x7so74177739wgj.2
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 10:44:49 -0700 (PDT)
In-Reply-To: <s5hh9pqed36.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

29.06.2015 20:41, Takashi Iwai wrote:
> At Sat, 27 Jun 2015 19:32:49 +0500,
> Alexander E. Patrakov wrote:
>>
>> Otherwise, they get misinterpreted as argument separators
>> in USB-Audio PCM definitions, and thus prevent SPDIF blacklist entries
>> from working.
>>
>> While at it, add my Logitec C910 webcam to the SPDIF blacklist.
>>
>> Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
>> ---
>> I did not send this patch earlier because of hesitation whether to send
>> it as it is or to implement proper escaping, and then forgot about it.
>
> I find the idea is fine.  Just small nitpicking:

Thanks for the review, I will send a new version soon.

>
>
>>   include/conf.h                |  1 +
>>   src/conf.c                    | 32 ++++++++++++++++++++++++++++++++
>>   src/conf/cards/USB-Audio.conf |  3 ++-
>>   src/confmisc.c                |  2 +-
>>   4 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/conf.h b/include/conf.h
>> index ff270f6..087c05d 100644
>> --- a/include/conf.h
>> +++ b/include/conf.h
>> @@ -126,6 +126,7 @@ int snd_config_imake_integer(snd_config_t **config, const char *key, const long
>>   int snd_config_imake_integer64(snd_config_t **config, const char *key, const long long value);
>>   int snd_config_imake_real(snd_config_t **config, const char *key, const double value);
>>   int snd_config_imake_string(snd_config_t **config, const char *key, const char *ascii);
>> +int snd_config_imake_safe_string(snd_config_t **config, const char *key, const char *ascii);
>>   int snd_config_imake_pointer(snd_config_t **config, const char *key, const void *ptr);
>>
>>   snd_config_type_t snd_config_get_type(const snd_config_t *config);
>> diff --git a/src/conf.c b/src/conf.c
>> index bb256e7..e72a58a 100644
>> --- a/src/conf.c
>> +++ b/src/conf.c
>> @@ -2228,6 +2228,38 @@ int snd_config_imake_string(snd_config_t **config, const char *id, const char *v
>>   	return 0;
>>   }
>>
>> +int snd_config_imake_safe_string(snd_config_t **config, const char *id, const char *value)
>> +{
>> +	int err;
>> +	snd_config_t *tmp;
>> +	char *c;
>> +
>> +	err = snd_config_make(&tmp, id, SND_CONFIG_TYPE_STRING);
>> +	if (err < 0)
>> +		return err;
>> +	if (value) {
>> +		tmp->u.string = strdup(value);
>
> The NULL check is put in a wrong place.

I don't see what's wrong, could you please elaborate? And if this is 
wrong, then snd_config_imake_string() has the same bug.

>
>> +		for (c = tmp->u.string; *c; c++) {
>> +			if (*c == ' ' || *c == '-' || *c == '_' ||
>> +				(*c >= '0' && *c <= '9') ||
>> +				(*c >= 'a' && *c <= 'z') ||
>> +				(*c >= 'A' && *c <= 'Z'))
>> +					continue;
>
> Can the last three be isalnum()?

No. isalnum() is locale-dependent.

>
>> +			*c = '_';
>> +		}
>> +
>> +		if (!tmp->u.string) {
>> +			snd_config_delete(tmp);
>> +			return -ENOMEM;
>> +		}
>
> This should be before conversion.

Oops...

-- 
Alexander E. Patrakov
