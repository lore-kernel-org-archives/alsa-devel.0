From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: Add BUG() assertion if max98088_get_channel
 returns -EINVAL
Date: Thu, 29 Sep 2011 21:28:39 +1000
Message-ID: <4E845667.3050404@gmail.com>
References: <1317218471.8008.3.camel@phoenix> <4E83AA77.9040700@gmail.com> <20110929103413.GK3697@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110929103413.GK3697@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Peter Hsiang <peter.hsiang@maxim-ic.com>, Jesse Marroquin <jesse.marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On 29/09/11 20:34, Mark Brown wrote:
> On Thu, Sep 29, 2011 at 09:15:03AM +1000, Ryan Mallon wrote:
>> On 29/09/11 00:01, Axel Lin wrote:
>>> The callers use the return value of max98088_get_channel as array index to
>>> access max98088->dai[] array.
>>> Add BUG() assertion for out of bound access of max98088->dai[] array.
>> BUG() is pretty heavy handed for a driver. Why not fix the problem
>> properly in the callers?
> There's nothing constructive that any of the callers can do with an
> error code - it's a clear bug in something (probably the driver) if we
> get called for a bad control.  Simply returning an error code isn't
> terribly helpful, it's very obscure what's gone wrong and why.  We at
> least need a log message.

Yeah, it can basically only happen if there is a mismatch between the
kcontrol definition and the get_channel function in the driver. Would
you be happy with adding a:

  dev_err(codec->dev, "Bad kcontrol channel name\n");

and then returning the error? It doesn't seem worth panicking the whole
driver/system for a bug like this.

~Ryan
