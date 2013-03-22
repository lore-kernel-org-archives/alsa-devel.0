From: Daniel Mack <zonque@gmail.com>
Subject: Re: how to combine mutil-channel in playback or
	capture?
Date: Fri, 22 Mar 2013 09:20:15 +0100
Message-ID: <514C143F.8060100@gmail.com>
References: <6B947C8AC4195040A8C6876A496C644A0819563C@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B36626627F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 09:20:14 +0100 (CET)
Received: by mail-wi0-f174.google.com with SMTP id hi8so7480999wib.1
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 01:20:14 -0700 (PDT)
In-Reply-To: <6B947C8AC4195040A8C6876A496C644A0819563C@BJ-MAIL-04.vimicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhang wei <zhangwei@vimicro.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Zhang,

On 22.03.2013 09:08, Zhang wei wrote:
> I have already achieved the alsa-driver which can playback and
> capture function with two channel.
> My board based on ARM9 which have 3 ADC & 1 DAC in IIS bus and all
> of them shared the same BCLK and LRCK. The pins figure Like this:
> 
>            _________________
>            |        BCLK   |___________
>            |               |
>            |        LRCK   |___________
>            |               |
>            |       ADCDAT0 |___________
>            |               |
>            |       ADCDAT1 |___________
>            |               |
>            |       ADCDAT2 |___________
>            |               |
>            |       DACDATA |___________
>            |               |
>            |_______________|
> 
> Every ADCDATn(n=0,1,2) has two channel so the question is how can I
> get multi-channel audio data such as 4 or 6 in capture funciton? 

It depends on how the whole setup looks like and what the driver for all
the DAIs support. If you have 4 different stereo Codecs, you would
usually instanciate 4 CPU DAI driver instances, each controlling one
bi-directional I2S bus, and then build links between each of them and
their Codec counterpart. If your Codec is capable of handling all 4
stereo pairs, you need to have support for the same in you CPU DAI.

So you need to be more specific about which components you are actually
using, and what kind of alsa-driver you have written.

In general, please also read up the documents in
Documentation/sound/alsa/soc/.



Daniel
