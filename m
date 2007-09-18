From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 10:17:43 +0200
Message-ID: <46EF89A7.9020906@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<Pine.LNX.4.58.0709171757500.27377@shell4.speakeasy.net>
	<20070918100246.6cd37e1b.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F51124475
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 10:18:41 +0200 (CEST)
In-Reply-To: <20070918100246.6cd37e1b.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 10:02 AM, Krzysztof Helt wrote:

>> +	timeout = jiffies + msecs_to_jiffies(250);
>> +	do {
>>  		spin_unlock_irqrestore(&chip->reg_lock, flags);
>> -		if (time_after(jiffies, end_time)) {
>> -			snd_printk(KERN_ERR "mce_down - auto calibration time out (2)\n");
>> -			return;
>> -		}
>>  		msleep(1);
>>  		spin_lock_irqsave(&chip->reg_lock, flags);
>> -	}
>> -
>> -	snd_printdd("(3) jiffies = %lu\n", jiffies);
>> -
>> -	end_time = jiffies + msecs_to_jiffies(100);
>> -	while (inb(AD1848P(chip, REGSEL)) & AD1848_INIT) {
>> -		spin_unlock_irqrestore(&chip->reg_lock, flags);
>> -		if (time_after(jiffies, end_time)) {
>> -			snd_printk(KERN_ERR "mce_down - auto calibration time out (3)\n");
>> -			return;
>> -		}
>> -		msleep(1);
>> -		spin_lock_irqsave(&chip->reg_lock, flags);
>> -	}
>> -	spin_unlock_irqrestore(&chip->reg_lock, flags);
>> +		regsel = snd_ad1848_in(chip, AD1848_TEST_INIT);
>> +	} while ((regsel & AD1848_CALIB_IN_PROGRESS) && time_before(jiffies, timeout));
> 
> Break this long line. You may calculate "regsel & AD1848_CALIB_IN_PROGRESS"
> inside the loop and use it in the condition outside the loop too.

Or just break out directly with a goto:

		regsel = snd_ad1848_in();
		if (!(regsel & AD1848_CALIB_IN_PROGRESS))
			goto out;
	while (time_before(jiffies, timeout));

	snd_printk(KERN_ERR "mce_down - auto calibration time out (2)\n")
out:
	spin_unlock_irqrestore()
	snd_printd()
	return;
}

Have grown to like those best generally -= falling off a timeout-loop means 
you've timed out, and if not, you jump over the error handling for that.

But I'm quite sure we'll be able to get religious over that. We're four 
people patching the same little function over and over again, so we're 
pretty daft anyway :-)

Rene.
