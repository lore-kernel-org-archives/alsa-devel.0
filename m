From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste@laposte.net>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Sun, 26 Feb 2017 23:49:49 +0100
Message-ID: <97c0ea59-edbd-ed59-eb4a-82019dae080c@laposte.net>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <141ed0ce-2801-1ace-84b5-c2881ad8921d@laposte.net>
 <bb7f470f-ab3c-4185-ac4b-431bc8b9c000@flatmax.org>
Reply-To: emmanuel.fuste@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.laposte.net (smtpoutz25.laposte.net [194.117.213.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C533266A74
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 23:49:49 +0100 (CET)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout013 (Postfix) with ESMTP id E0593104C4B
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 23:49:48 +0100 (CET)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout013 (Postfix) with ESMTP id D295F104C77
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 23:49:48 +0100 (CET)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
 by lpn-prd-vrout013 (Postfix) with ESMTP id CEA2B104C4B
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 23:49:48 +0100 (CET)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
 by lpn-prd-vrin003 (Postfix) with ESMTP id BC90048EA14
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 23:49:48 +0100 (CET)
In-Reply-To: <bb7f470f-ab3c-4185-ac4b-431bc8b9c000@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Le 26/02/2017 =E0 22:44, Matt Flax a =E9crit :
>
>
> On 27/02/17 07:41, Emmanuel Fust=E9 wrote:
>>
>>
>> I'm a complete newbie to ASoC  but I take part to this tread to learn =

>> as I hate to see how badly all diy and amateur audio hw are =

>> integrated with Alsa/ASoC/Linux and so never go upstream. On a =

>> professional/commercial dev, you would never take this ... convoluted =

>> I2S multi channel path.
>>
>
> Hey Emmanuel,
>
> We now know that we can retrofit legacy I2S silicon for multichannel, =

> in a very direct manner.
>
> If you were a chip manufacturer and you could potentially increase =

> your market take up by hundreds of millions of new potential low power =

> devices, wouldn't you manufacture ALL new chips with these minor =

> modifications ?
>
> Matt
Hi,

No, because this is a hack. There is established an more importantly  =

interoperable bus standards to do multichannel digital audio : TDM/DSP =

A/DSP B
As today standards, even ultra low power and low powerfull IC are able =

to do standard multichannel serial audio. Atmel AT & ARM cortex  M =B5C, =

STMicro STM32 family etc ...
I2S signaling is only part of the equation, fifo, DMA handling, etc... =

of the multichannel part could be important depending of the implementation.
And the FPGA glue logic is way more costly than choosing a SOC / =B5C with =

a properly designed multichannel serial audio IP.
The real question is why this SOC so poorly endowed with bad device IP =

is so popular... but this is another story...

Don't get me wrong. I'm nevertheless a real supporter of this "hack". =

But it should be done the "right" way.

Emmanuel.
