From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: cs4271: free reset gpio in
	cs4271_remove()
Date: Wed, 19 Feb 2014 13:09:27 +0100
Message-ID: <53049EF7.5040709@zonque.org>
References: <1392808032-25756-1-git-send-email-zonque@gmail.com>
 <20140219111529.GI2669@sirena.org.uk> <53049467.60106@zonque.org>
 <20140219114303.GJ2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 691A926157F
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 13:09:30 +0100 (CET)
In-Reply-To: <20140219114303.GJ2669@sirena.org.uk>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/19/2014 12:43 PM, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 12:24:23PM +0100, Daniel Mack wrote:
>> On 02/19/2014 12:15 PM, Mark Brown wrote:
>>> On Wed, Feb 19, 2014 at 12:07:12PM +0100, Daniel Mack wrote:
> 
>>>> +	if (gpio_is_valid(cs4271->gpio_nreset)) { /* Set codec to
>>>> the reset state */ gpio_set_value(cs4271->gpio_nreset, 0); +
>>>> devm_gpio_free(codec->dev, cs4271->gpio_nreset); +	}
> 
>>> If it's being requested as a managed resource shouldn't it be
>>> being freed automatically?
> 
>> Nope, as the module itself will not go away necessarily. I hit
>> the bug when unloading and reloading the machine driver.
>> cs4271_probe(codec) will fail to acquire and drive the reset
>> line, and the codec stays in reset.
> 
> The fix here is to move the resource acquisition to the bus level
> probe instead of the ASoC card startup.
> 

Alright. I thought there was a verdict once that resource claiming
should be done right before usage, but you're right, it really rather
belongs into the bus probe functions.

I'll send another version.


Thanks!
Daniel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTBJ72AAoJELphMRr8Y1QkXt8P/RErTL26/X3s/MnYfhuPDzsx
T7oU/YSpYvcqBVBab3rZjbyELRPqcrWO0XaiVFLiOqwt2KslKK/k8zz8gZIsvOxM
YzheQMzI45sosYCFf1OssC7ojwTTks/hwgKzOj0Hi0aWtSVYRgV2kvg8S4tiwEzl
OpM9Z4r0lCw9kJidlSwPCXcg+s4BN6xMcqaTIFfU1QCQ84dxHwzhf7cYZliOtWEv
FlnMVKYAtBVCACVqBxHS+2OdopcTuwQ0aqts7UMXFq2MGCIYf6Fyq/qmmCMuaZrN
yDcm3fpJodIoZo20nIf2zpaPGgD7ce+LK/Mu46sZ4MFRBxHgGlQ0C2UNZgNlVILI
mY6hj8s44kCptX1sDPTviYoRnxQ4PTAdRUjfVRuShjkEFi8WHKEbIHwLqn0BvjSB
FaaESTg5NhBJsAroTK83nqqY7MxcLZV4YBhnoH4Mhc2IZHa5hOxcHy5crGyUUEGF
4QWMJoHW+J3s8malsvwcNj8Fv4a6SaeptNr+4EkGW/lwrVAjl/03Ei7MvvqApyPm
TSRuBXQUbiJhxBpkAMhFQ7jIj3Gw+CcgiudcwLA1sVdN2uTvbe/YRas/ZlWQn/W9
TVihbfTM8apHwCacyJYX7yE16eJ162AznYqCZC5ZCJ1L2k8ep30bhwEJk2nq4GP1
6FikGJ1wGOLdvDbwOc8b
=dthk
-----END PGP SIGNATURE-----
