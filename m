From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 3/4] dt-bindings: sound: add binding for
	pcm1792a
Date: Fri, 20 Nov 2015 16:04:32 +0100
Message-ID: <CAOf5uwmpcjrqsQPukr9t2Z-nuJn=8ML1G90RCdq=Zgm9nLW8Ww@mail.gmail.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
 <1448014157-36526-4-git-send-email-raphael.poggi@avalun.com>
 <20151120144245.GA12767@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 60C392606F6
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 16:04:34 +0100 (CET)
Received: by iofh3 with SMTP id h3so126206154iof.3
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 07:04:33 -0800 (PST)
In-Reply-To: <20151120144245.GA12767@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Raphael Poggi <poggi.raph@gmail.com>, tiwai@suse.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Raphael


On Fri, Nov 20, 2015 at 3:42 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Nov 20, 2015 at 11:09:16AM +0100, Raphael Poggi wrote:
>> From: Raphael Poggi <poggi.raph@gmail.com>
>>
>> Add a binding for specify channel selection.
>>
>> Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/sound/pcm1792a.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>

can you add me in the patch-set?

Michael

>> diff --git a/Documentation/devicetree/bindings/sound/pcm1792a.txt b/Documentation/devicetree/bindings/sound/pcm1792a.txt
>> index 970ba1e..6e87a3a 100644
>> --- a/Documentation/devicetree/bindings/sound/pcm1792a.txt
>> +++ b/Documentation/devicetree/bindings/sound/pcm1792a.txt
>> @@ -9,10 +9,15 @@ Required properties:
>>  For required properties on SPI, please consult
>>  Documentation/devicetree/bindings/spi/spi-bus.txt
>>
>> +Optional properties:
>> +- ti,side: specifie the channel side
>
> typo
>
>> +  insertion, removal.
>
> why the line wrap?
>
> I don't understand what this property is/does. Both the name and
> description are a bit terse.
>
>> +
>>  Examples:
>>
>>       codec_spi: 1792a@0 {
>>               compatible = "ti,pcm1792a";
>>               spi-max-frequency = <600000>;
>> +             ti,side = <left>
>                                 ^
> missing ;
>
>>       };
>>
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
