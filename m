From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ASoC: TI codecs and their crazy variable length
	registers
Date: Thu, 31 Jul 2014 10:06:32 -0400
Message-ID: <CAKON4Oy=FAH0NBoQaYBcsc1mxTSXJP1fT+bx2S=vyFUDp8BHuw@mail.gmail.com>
References: <CAKON4OyCqvjLq09+WymcSKRwfLJrSBoLMRWksNO2hKrtR3u3vw@mail.gmail.com>
 <20140730231756.GE17528@sirena.org.uk>
 <53D9E9B5.4040303@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 4519126089A
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 16:06:33 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id s18so2117015lam.14
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 07:06:32 -0700 (PDT)
In-Reply-To: <53D9E9B5.4040303@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 31, 2014 at 3:01 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/31/2014 01:17 AM, Mark Brown wrote:
>>
>> On Wed, Jul 30, 2014 at 05:56:36PM -0400, jonsmirl@gmail.com wrote:
>>
>>> I'm working on a TI codec attached via I2C.  Just to make things
>>> interesting the registers have varying byte lengths of - 1,4,8,12,20
>>> bytes. What's the best strategy for using regmap with it?
>>
>>
>> I'd use the reg_read() and reg_write() callbacks to hide the registers
>> that will fit in an integer, the rest of the stack can pretend they've
>> got 32 bit values which should improve code reuse.[...]
>
>
> The adau1701 is a driver that for example does this.
>

Then use regmap_raw_read/regmap_raw_write for the registers over four bytes?

This might work generically if the size function was a regmap callback...

static int adau1701_reg_write(void *context, unsigned int reg,
     unsigned int value)
{
struct i2c_client *client = context;
unsigned int i;
unsigned int size;
uint8_t buf[5];
int ret;

size = adau1701_register_size(&client->dev, reg);
if (size == 0)
return -EINVAL;

buf[0] = reg >> 8;
buf[1] = reg & 0xff;

for (i = size + 1; i >= 2; --i) {
buf[i] = value;
value >>= 8;
}


-- 
Jon Smirl
jonsmirl@gmail.com
