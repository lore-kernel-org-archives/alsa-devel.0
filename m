From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH] ALSA: via82xx: Use common error handling
 code in snd_via82xx_create()
Date: Tue, 22 Aug 2017 22:05:37 +0200
Message-ID: <d9b9dc7e-9c00-3f1d-f6f8-a2e67110c449@users.sourceforge.net>
References: <2332472c-61d2-8c21-bf46-5c80745d6380@users.sourceforge.net>
 <20170822190757.76e5edh5t6tgvzpu@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A52AE266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:05:58 +0200 (CEST)
In-Reply-To: <20170822190757.76e5edh5t6tgvzpu@mwanda>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>> @@ -1121,30 +1121,27 @@ static int snd_via82xx_create(struct snd_card *card,
>>  
>>  	if ((err = pci_request_regions(pci, card->driver)) < 0) {
>>  		kfree(chip);
>> -		pci_disable_device(pci);
>> -		return err;
>> +		goto disable_device;
>>  	}
> 
> [ snip ]
> 
>> @@ -1153,6 +1150,14 @@ static int snd_via82xx_create(struct snd_card *card,
>>  
>>  	*r_via = chip;
>>  	return 0;
>> +
>> +disable_device:
>> +	pci_disable_device(pci);
>> +	goto exit;
> 
> Why is this "goto exit" here?

Should the same return statement be reached after the proposed refactoring?

Would you like to move such a function call to this source code place?


> It's leaking now.

How do you come to this conclusion?


>> +free_chip:
>> +	snd_via82xx_free(chip);
>> +exit:
>> +	return err;
>>  }

Is this update suggestion worth for another look?

Regards,
Markus
