From: Caleb Crome <caleb@crome.org>
Subject: Re: Audio routing in the tlv320aic3104
Date: Wed, 7 Oct 2015 05:52:31 -0700
Message-ID: <0665D4EF-04B7-4930-9921-2BA72CAB7AC9@crome.org>
References: <18B9FBAF-1EB4-413F-8639-9AC94B50F445@latencyzero.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C2A3F265E0B
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 14:52:35 +0200 (CEST)
Received: by pablk4 with SMTP id lk4so21010210pab.3
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2015 05:52:34 -0700 (PDT)
In-Reply-To: <18B9FBAF-1EB4-413F-8639-9AC94B50F445@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Sent from my iPhone

> On Oct 7, 2015, at 4:12 AM, Rick Mann <rmann@latencyzero.com> wrote:
> 
> I've managed to get a hacky, fragile config working, in the sense that it sends my tlv320aic3104 samples from speaker-test, and the clocks and data all look good on the oscilloscope, and it ping-pongs between the left and right channel.
> 
> But it's outputting the signal on the HPLOUT/HPROUT pins, not the L&R Line Out pins.
> 
> My DTS has this:
> 
>    fragment@3 {
>        target = <&ocp>;
>        __overlay__ {
>            sound {
>                compatible = "ti,da830-evm-audio";
>                ti,model = "DA830 EVM";
>                ti,audio-codec = <&tlv320aic3x>;
>                ti,mcasp-controller = <&mcasp0>;
>                ti,codec-clock-rate = <12000000>;
>                ti,audio-routing =
>                    "Line Out",             "LLOUT",
>                    "Line Out",             "RLOUT";
>            };
>        };
>    };
> 
> The original had:
> 
>    "Headphone Jack",       "HPLOUT",
>    "Headphone Jack",       "HPROUT",
>    "LINE1L",               "Line In",
>    "LINE1R",               "Line In";
> 
> I also have an asound.state file I got from the Audio Cape:
> 
>    https://raw.githubusercontent.com/CircuitCo/BeagleBone-Audio/files/asound.state
> 
> I don't really know how to interpret that file. One resource online said it held the current state of the system. I guess that suggests I should play with amixer. But how does the DTS routing come into play?
> 
> Thanks,
> 

Check for the routing in the davinci-evm.c file.  It has other routes,  I kind of recall it says some outputs are not connected.    You might have to edit routs there too. 


> 
> 
> -- 
> Rick Mann
> rmann@latencyzero.com
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
