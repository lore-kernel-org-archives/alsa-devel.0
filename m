From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v10 00/13] Introduce framework for SLIMbus
	device driver
Date: Thu, 14 Dec 2017 13:18:40 +0000
Message-ID: <23befa69-b2f3-b2d0-1d38-6a7b488f00ec@linaro.org>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
 <20171213092502.GA12631@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id D553A266D86
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 14:18:43 +0100 (CET)
Received: by mail-lf0-f53.google.com with SMTP id f18so6604478lfg.8
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 05:18:43 -0800 (PST)
In-Reply-To: <20171213092502.GA12631@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 13/12/17 09:25, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2017 at 11:42:54PM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
>> developed by MIPI (Mobile Industry Processor Interface) alliance.
>> SLIMbus is a 2-wire implementation, which is used to communicate with
>> peripheral components like audio-codec.
>> SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
>> channels, and control channel. Control channel has messages to do
>> device-enumeration, messages to send/receive control-data to/from
>> SLIMbus devices, messages for port/channel management, and messages to
>> do bandwidth allocation.
>> Framework is introduced to support  multiple instances of the bus
>> (1 controller per bus), and multiple slave devices per controller.
>> SPI and I2C frameworks, and comments from last time when I submitted
>> the patches were referred-to while working on this framework.
>>
>> These patchsets introduce device-management, OF helpers, and messaging
>> APIs, controller driver for Qualcomm's SLIMbus controller, and
>> clock-pause feature for entering/exiting low-power mode for SLIMbus.
>> Framework patches to do channel, port and bandwidth
>> management are work-in-progress and will be sent out once these
>> initial patches are accepted.
>>
>> These patchsets were tested on IFC6410 board with Qualcomm APQ8064
>> processor using the controller driver, and a WCD9310 codec.
>>
>> v9: https://lkml.org/lkml/2017/12/7/289
>>
>> Changes from v9 to v10:
>> * Added kernel-doc reference into slimbus driver api doc suggested by
>>   Jonathan Corbet
> 
> These all look good to me.  I can take this through my tree if I get the
> ack from Mark for the regmap changes.
> 

Greg, Can you please pick up the series except the regmap patch, Mark 
said that he will apply it separately.


Thanks
srini
> thanks,
> 
> greg k-h
> 
