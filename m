From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: core: Fix Sparse incompatible types warning
Date: Wed, 09 Apr 2014 22:28:59 +0200
Message-ID: <5345AD8B.5050306@metafoo.de>
References: <1397028108-10976-1-git-send-email-k.kozlowski@samsung.com> <5345279F.6070005@metafoo.de> <1397041934.11424.2.camel@AMDC1943> <53452F67.3060400@metafoo.de> <20140409202520.GQ6518@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140409202520.GQ6518@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/09/2014 10:25 PM, Mark Brown wrote:
> On Wed, Apr 09, 2014 at 01:30:47PM +0200, Lars-Peter Clausen wrote:
>> On 04/09/2014 01:12 PM, Krzysztof Kozlowski wrote:
>>> On =C5=9Bro, 2014-04-09 at 12:57 +0200, Lars-Peter Clausen wrote:
>>>> On 04/09/2014 09:21 AM, Krzysztof Kozlowski wrote:
>
>>>>> -	buf_size =3D min(count, (sizeof(buf)-1));
>>>>> +	buf_size =3D min(count, (size_t)(sizeof(buf)-1));
>
>>>> But shouldn't the type of sizeof already be size_t?
>
>>> Hmmm... yes it should. It looks like a false positive from Sparse s=
o the
>>> commit message should be rather "Suppress" than "Fix".
>
>> I'm pretty sure it is a bug in sparse, we shouldn't suppress those, =
but
>> rather fix them in sparse itself.
>
> Either that or there's something else going on that hasn't been prope=
rly
> understood.  The above just looks completely bogus.
>

I had a look at the sparse code and the problem is that it sets the def=
ault=20
return type of sizeof according to the type of the host it was compiled=
 on=20
(either unsigned int or unsigned long). It can be overwritten by switch=
es like=20
-m32, but of course wont work when cross compiling. So if your host sys=
tem is=20
64bit, but your target system is 32bit you'll get that warning.

- Lars
