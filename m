From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: ASoC: cs4271: init/timing problem
Date: Wed, 01 Apr 2015 11:57:22 +0200
Message-ID: <551BC102.6010403@gmail.com>
References: <551A5FC9.4010109@gmail.com>
 <alpine.DEB.2.10.1503311600000.13828@heelrod-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC50260434
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 11:57:24 +0200 (CEST)
Received: by wixo5 with SMTP id o5so43136906wix.1
 for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2015 02:57:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1503311600000.13828@heelrod-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

Hey Brian,

On 31.03.2015 23:01, Brian Austin wrote:
> On Tue, 31 Mar 2015, Pascal Huerst wrote:
> 
>> Hey all,
>>
>> We have a custom built hw, based on am335x and from time to time we need
>> to rmmod/modprobe the ASoC machine driver. Depending on the hw, the
>> first call to regmap_update_bits(..) in cs4271_codec_probe(..) fails
>> with -EREMOTEIO.
>>
>> The error is originated in:
>>
>> drivers/i2c/busses/i2c-omap.c
>>
>> and happens if no i2c package acknowledge is received by the host.
>>
>> I think this is a timing issue and on some devices, the codec is just
>> not ready yet, for communication.
>>
>> What is the right way to fix that? My attempt would be something like this:
> 
> The error you are referring to is a NACK from a device (CODEC). That is 
> usually seen when you dont have it hooked up correctly. Could also be that 
> the I2C bus is too fast. How fast are you running the bus?

clock-frequency is set to 100000, hence 100 kHz, which should be ok,
according to the datasheet.
