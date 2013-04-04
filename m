From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: ASOC snd_soc_dai_ops for clock mux control
Date: Wed, 03 Apr 2013 22:55:05 -0700
Message-ID: <515D15B9.8080608@gmail.com>
References: <8F928A9825EEF0458AC402C3ABF8BEB1053E0DEF@HI2EXCH01.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C1E1265E31
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 07:55:08 +0200 (CEST)
Received: by mail-pd0-f181.google.com with SMTP id y10so1253773pdj.12
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 22:55:08 -0700 (PDT)
In-Reply-To: <8F928A9825EEF0458AC402C3ABF8BEB1053E0DEF@HI2EXCH01.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gellner, Christoph (ADITG/SW1)" <cgellner@de.adit-jv.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 09:22 AM, Gellner, Christoph (ADITG/SW1) wrote:
> Hi all,
>
> I'm working on the driver of an audio CPU DAI IP providing
> -       Internal clocks which can be used for master clock generation by TX as well as RX section
> -       One oversampling clock available to RX section
> -       One oversampling clock available to TX section.
>
> Kernel version is 3.5.7
>
> I want to add support to the CPU DAI driver to
> -       Specify the rate of the input clocks
> -       Select which of the clock inputs shall be used by RX and which shall be used by TX section
>
> I'm currently wondering how to map this to existing snd_soc_dai_ops functions.
> Currently I see only set_sysclk, set_pll, set_clkdiv for clock control.
>
> I plan to use set_sysclk to specify the rate as well as the direction of each clock.
>
> What is currently missing for me is a way to specify the clock to be used by RX or TX section.
>
> Do you have any recommendation how to implement ?


Let's say your CPU DAI IP has 3 clocks which we'll call MCLK (master 
clock), FLL1, and FLL2 (the two oversampling clocks).

Are you wanting a way to say: "RX should use FLL1 and TX should use FLL2" ??

If so, there's a couple options I can think of.  (A) You could call a 
codec-specific API in your machine driver that expresses this intent. 
(B) you could create "virtual" clock ID's that express the mapping (e.g. 
FLL1_TX, FLL1_RX, FLL2_TX, FLL2_RX).  I think (A) is a cleaner solution 
that clearly communicates what is happening.

-gabriel
