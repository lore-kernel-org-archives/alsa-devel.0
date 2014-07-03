From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v3] ASoC: tas5086: add regulator consumer
 support
Date: Thu, 03 Jul 2014 18:50:49 +0200
Message-ID: <53B589E9.3080608@zonque.org>
References: <1404399403-6316-1-git-send-email-zonque@gmail.com>
 <20140703151229.GF410@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 938FF261A50
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 18:50:50 +0200 (CEST)
In-Reply-To: <20140703151229.GF410@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/03/2014 05:12 PM, Mark Brown wrote:
> On Thu, Jul 03, 2014 at 04:56:43PM +0200, Daniel Mack wrote:
>> The TAS5086 has two power domains, DVDD and AVDD. Enable them
>> both as long as the codec is in use.
>> 
>> Also, switch on the power to identify the chip at device probe
>> level, and switch it off again afterwards. The codec level will
>> take care for power handling later.
> 
> Applied, thanks.  One small thing:
> 
>> +	/* +	 * The chip has been identified, so we can turn off the
>> power +	 * again until the dai link is set up. +	 */ +
>> regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
>> priv->supplies); + +	if (ret == 0) +		ret =
>> snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086, +
>> &tas5086_dai, 1);
> 
> It can be slightly smoother to do the disable after registering so
> that if we immediately cause a card to register and that causes the
> device to become active again we don't bounce the power.  Nobody is
> ever likely to notice the difference though.

True. I'll keep an eye on that.


Thanks,
Daniel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTtYnpAAoJELphMRr8Y1QkEfsP/07T02vEEjN76SW8gMrabEjX
KbhWTkDWJz361hqpY6JaZ3a03t0tL7TV4aMTlKSdK34Ch3WdJtMN8SvrXObWI7mw
iIgjxBmkrXO6OhZqDBwMSYA4OnTepnygM+zVwFqJjUo/k/bmWBWFZVYBaezHZLk8
Qj5BxtgNqELvKneEPK2J1OSbYsrgo4UEQyAv8FLCq/wn+F49uqMx9VYas/xqXYls
lCjoIS46MzhkP70mgdCRBchs5ngAXBxS4TFZByX9vmiwJJl0kyO2hQ9IEYiVUl5R
bEFAGrjg7fscjwo3h1fYa2XearL9NaTcww8HdoiS3YJcvV/SMMGN8QBr4xL3rSy1
RPCY8TD1rerGAfKtEYcqRoSx01ihKdx9uwo0qLffbcxjVG1suAuxlP0lFyuK+VQB
1WsG6WLW+Emh4xNpwYzFdKe5xg5YHktc0jBweh83NjS6HTB6wySyD6a7TTq67NkO
f3AxkJE39L+WklydsJHpt7Bl9oCRuWcQ2VLgnjLohoLx9VcyCik4sAZ7nfSeiZEh
XXKgl1dqO2Mwa8oBkMEQM354Z3PGNSilliwBWkSGYuUpWINkpQ0VRcyz9aWsaoCG
v+N+67mrCJ8kb6YZwSO4ir88dVi/pnga/U40LvJhpQ3zk9rhWLTt15B6qXqcszQq
kJ4d0r2wUKGtzhHBJqqk
=OduV
-----END PGP SIGNATURE-----
