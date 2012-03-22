From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Subject: Re: [PATCH 02/16] ASoC: core: Add 8bit multi reg
	control accessors
Date: Thu, 22 Mar 2012 17:58:41 +0100
Message-ID: <4F6B5A41.9020107@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-3-git-send-email-ola.o.lilja@stericsson.com>
	<20120313212512.GD3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id ED8961044F8
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 17:59:12 +0100 (CET)
In-Reply-To: <20120313212512.GD3177@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 2012-03-13 22:25, Mark Brown wrote:

> On Tue, Mar 13, 2012 at 04:11:29PM +0100, Ola Lilja wrote:
>> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>>
>> Added get/put accessors for controls that span multiple 8bit registers
>> which together forms a single signed value in a MSB/LSB manner.
>>
>> snd_soc_get_xr8_sx
>> snd_soc_put_xr8_sx
>>
>> Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
> 
> This needs to be part of a patch adding one or more actual control
> types, just adding bits like this makes things harder to review as it's
> hard to see how things fit together.


I agree. I will provide a more complete patch including actual control type so
that reviewing would be made easier. The patch will expose parameters like
"register base" and "register count". This control will then fully support any
composite values composed from a parameterized number of contiguous 8-bit
registers in only one single macro while fully supporting both writing and
reading back the composite values transparently to the client.

We do have several controls composed by chunks of 8-bit registers that both are
contiguous and supports reading back in our hardware and I guess that this
might not be such an unusual setup for other hardwares either, which would make
for a useful generic control I believe.

Do you agree that such a control type could be an useful generic one in the
framework?
