From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Thu, 31 Jan 2013 10:04:25 +0100
Message-ID: <510A3399.1010600@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510644E5.1040505@perex.cz> <5106747A.5070803@ivitera.com>
 <5106ECE1.7040608@gmail.com> <510799FE.3020904@ivitera.com>
 <5109C6AB.8050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id BD90A261734
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 10:04:28 +0100 (CET)
In-Reply-To: <5109C6AB.8050407@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 31.1.2013 02:19, Jonas Petersen wrote:
> Am 29.01.2013 10:44, schrieb Pavel Hofman:
>> On 28.1.2013 22:25, Jonas Petersen wrote:
>>>> Jonas, please could you check if ak4114 pins XTL0/1 (10, 11) are
>>>> connected to logical high? They should be :)
>>> Physically they're both on ground. I don't know what active state that
>>> chip has though.

That would mean the chip is fed 11.2896MHz clock. I do not see any
crystal on
http://www.nix.ru/autocatalog/m_audio_midiman_sound/34397_2245_draft.jpg
. Is it the same card you have, with the crystal position empty? Are you
really sure they are not on power supply?

>> Let 's wait until we get the ak4114 register dump file :)
> 
> Can't wait. :) 

Did the patch work?


I did a quick test in Windows 7. This driver is able to
> detect the sample rate. If I set the clock source to "spdif in" at the
> control pannel, then I can see the rate changing when I switch to
> another rate on the spdif source.

Did you test 192kHz and 176,4kHz? The receiver can work in two modes.
Either it knows it is fed an independent clock and detects the sample
rate precisely, or it simply reads the sample rate from SPDIF preamble
of the incoming stream. The mode is select by the XTL0,1 pins. Often the
streams do not contain correct information, especially for consumer mode
which does not have room for the larger samplerates code. Could you
please test both consumer and professional modes, all common samplerates?

Thanks,

Pavel.
