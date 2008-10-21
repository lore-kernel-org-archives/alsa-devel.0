From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH0/2] jack: Add support for SND_JACK_LINEOUT
Date: Tue, 21 Oct 2008 11:19:52 -0400
Message-ID: <48FDF318.8050502@embeddedalley.com>
References: <48FCFAA8.8070005@embeddedalley.com>
	<20081021084806.GC10841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id B4AA3247A0
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 17:20:20 +0200 (CEST)
In-Reply-To: <20081021084806.GC10841@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Brown wrote:
> On Mon, Oct 20, 2008 at 05:39:52PM -0400, Matthew Ranostay wrote:
>> Add support to the jack abstraction layer to report 'Line Out' presence insertions.
> 
> The line output parts of this look good.  However, there look to be some
> other things in here as well...
> 
> Please word-wrap your changelogs, also - they should have lines no
> longer than 80 columns.
> 
>> --- a/include/sound/jack.h
>> +++ b/include/sound/jack.h
>> @@ -35,6 +35,8 @@ enum snd_jack_types {
>>  	SND_JACK_HEADPHONE	= 0x0001,
>>  	SND_JACK_MICROPHONE	= 0x0002,
>>  	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
>> +	SND_JACK_LINEOUT	= 0x0004,
>> +	SND_JACK_SWITCH		= SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
>>  };
> 
> Like Takashi said, SND_JACK_LINEOUT I understand but SND_JACK_SWITCH is
> rather abstruse.  If it's just that the jack can be either a headphone
> or a microphone then there's no need for it - HEADSET is only provided
> to make it more obvious how to implement one since people often don't
> think of a headset as being its components.
> 
Actaully it's for the jack that has a mixer switch, in which the headphone
support turned off and becoming a line out. I can understand not adding this,
since only one codec patchset will probably use it.


>> index bd2d9e6..284432f 100644
>> --- a/sound/core/jack.c
>> +++ b/sound/core/jack.c
>> @@ -34,6 +34,7 @@ static int snd_jack_dev_free(struct snd_device *device)
>>  	else
>>  		input_free_device(jack->input_dev);
>>
>> +	kfree(jack->id);
>>  	kfree(jack);
>>
>>  	return 0;
>> @@ -87,7 +88,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
>>  	if (jack == NULL)
>>  		return -ENOMEM;
>>
>> -	jack->id = id;
>> +	jack->id = kstrdup(id, GFP_KERNEL);
> 
> These two changes look entirely unrelated to adding line output support
> and aren't mentioned in the changelog.  Please split them into a
> separate patch with a changelog entry.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj98xgACgkQ7s2wy7nhBHUqOwCdFs0U7v6/bPvsmiZ/2qiysz3G
E3QAnjdLoByV3M3s4m8JpjKRJFgfVpXz
=hB+0
-----END PGP SIGNATURE-----
