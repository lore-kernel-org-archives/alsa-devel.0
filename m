From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: cs4271: free reset gpio in
	cs4271_remove()
Date: Wed, 19 Feb 2014 12:24:23 +0100
Message-ID: <53049467.60106@zonque.org>
References: <1392808032-25756-1-git-send-email-zonque@gmail.com>
 <20140219111529.GI2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0D32652E6
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:24:29 +0100 (CET)
In-Reply-To: <20140219111529.GI2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: brian.austin@cirrus.com, subaparts@yandex.ru, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On 02/19/2014 12:15 PM, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 12:07:12PM +0100, Daniel Mack wrote:
> 
>> +	if (gpio_is_valid(cs4271->gpio_nreset)) {
>>  		/* Set codec to the reset state */
>>  		gpio_set_value(cs4271->gpio_nreset, 0);
>> +		devm_gpio_free(codec->dev, cs4271->gpio_nreset);
>> +	}
> 
> If it's being requested as a managed resource shouldn't it be being
> freed automatically?
> 

Nope, as the module itself will not go away necessarily. I hit the bug
when unloading and reloading the machine driver. cs4271_probe(codec)
will fail to acquire and drive the reset line, and the codec stays in reset.

Daniel
