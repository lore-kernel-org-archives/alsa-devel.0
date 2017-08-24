From: cuhl@eit.uni-kl.de
Subject: Re: Alsa-devel Digest, Vol 126, Issue 233
Date: Thu, 24 Aug 2017 20:23:11 +0200
Message-ID: <31a1aecfbe193a8c03560e29553bb652.squirrel@postamt.eit.uni-kl.de>
References: <mailman.3181.1503497059.896.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 82915267825
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 20:23:13 +0200 (CEST)
In-Reply-To: <mailman.3181.1503497059.896.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: clemens@ladisch.de, cuhl@eit.uni-kl.de
List-Id: alsa-devel@alsa-project.org

Hello Clemens, hello Alsa Developers,

thank you for your interest and answer to my question.

Why is the behaviour hardware dependent?
As long as the I2S' are synced at the inputs of the SoC, are the relative
differences / phases preserved during processing and is this ensured?

I would like to use a device with multiple I2S-inputs and outputs, as far
as available and supported by the ALSA drivers.

Is this driver dependent? Are there drivers which take special effort to
preserve the relative position of channels?

Kind regards



> Date: Wed, 23 Aug 2017 15:41:36 +0200
> From: Clemens Ladisch <clemens@ladisch.de>
> To: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Fixed latency between multiple channels
> Message-ID: <b6c4c2f2-a01c-fc06-e1bb-73e14b3cf56c@ladisch.de>
> Content-Type: text/plain; charset=us-ascii
>
> cuhl@eit.uni-kl.de wrote:
>> I've read, that even with a realtime kernel the input-output latency
>> varies with time - especially if USB is inbetween.
>
> Yes, USB cam have a small but unknown delay between playback and capture.
>
>> I expect to require a fixed latency between multiple ( I2S ) channels.
>
>> So every channel's signal shall be exactly determined to its
>> relative position with respect to the other channels, e. g. it shall be
>> known inside the system which events occured simultanously.
>>
>> Likewise, the processed or generated signals shall be transferred to the
>> outputs in a way, that they occur there with intended and modifiable
>> relative latency to each other.
>
> This is essentially a hardware problem.
>
> Can't you just use a single device with many channels?
>
>
> Regards,
> Clemens
>
