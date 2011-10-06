From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 06/10] ASoC: wm8940: Convert to snd_soc_cache_sync
Date: Thu, 06 Oct 2011 14:35:48 +0100
Message-ID: <4E8DAEB4.9090601@cam.ac.uk>
References: <1317881417.13399.1.camel@phoenix> <1317881863.13399.10.camel@phoenix> <4E8D90E9.5060208@cam.ac.uk> <20111006131811.GA16404@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111006131811.GA16404@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/06/11 14:18, Mark Brown wrote:
> On Thu, Oct 06, 2011 at 12:28:41PM +0100, Jonathan Cameron wrote:
>> On 10/06/11 07:17, Axel Lin wrote:
> 
>>> +static int wm8940_volatile_register(struct snd_soc_codec *codec,
>>> +				    unsigned int reg)
>>> +{
>>> +	switch (reg) {
>>> +	case WM8940_SOFTRESET:
>>> +		return 1;
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
> 
>> I guess this makes sense from point of view of keeping things inline with
>> more complex drivers.  Otherwise I'd expect to see something like:
>> {
>> 	return !!(reg == WM894_SOFTRESET);
>> }
> 
> On the other hand we actually want people to be able to read the code
> (though the !! there which is the major complication isn't actually
> doing anything...).
Fair point.
