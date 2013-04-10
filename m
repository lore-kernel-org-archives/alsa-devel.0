From: "Gellner, Christoph (ADITG/SW1)" <cgellner@de.adit-jv.com>
Subject: Re: ASOC snd_soc_dai_ops for clock mux control
Date: Wed, 10 Apr 2013 13:55:41 +0000
Message-ID: <8F928A9825EEF0458AC402C3ABF8BEB1053E230A@HI2EXCH01.adit-jv.com>
References: <8F928A9825EEF0458AC402C3ABF8BEB1053E0DEF@HI2EXCH01.adit-jv.com>
 <515D15B9.8080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2753A265F7B
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 15:55:44 +0200 (CEST)
In-Reply-To: <515D15B9.8080608@gmail.com>
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
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Thank you for your feedback.
Basically I want to specify clocks for RX section and TX section independently.

If this is "RX should use FLL1 and TX should use FLL2" or "RX should use FLL1 and TX should use MCLK" 
should not make any difference in my opinion.


As you state, solution A is cleaner as it clearly communicates what is happening below.

My target is to use ASOC architecture. Therefore I do not want to bypass it.

As I understand the ASOC architecture target to provide interfaces to all DAI configurations and handles the linking.
Therefore I would prefer to add the missing set_clkmux to ASOC architecture.
Is something like clock multiplexers really that special ?
What is your opinion, would set_clkmux be beneficial for ASOC architecture ? 

I understand that in case there is only one section for RX and TX this can be implicitly handled by set_sysclk.
I'm currently wondering what shall be configured by set_sysclk.
Is it only the clock, rate and direction of the clock or does it implies that the clock is to be used in all cases ?

What happens in case the oversampling clock FLL1 can be output, too (generated from MCLK).
Is it allowed to call set_sysclk two times
1) specify MCLK to be input and the rate
2) specify FLL1 to be output at a rate derived from MCLK


I believe in this case using set_sysclk for selecting the clock can be really difficult.
What is your opinion ?

Best regards

Christoph

-----Original Message-----
From: Gabriel M. Beddingfield [mailto:gabrbedd@gmail.com] 
Sent: Donnerstag, 4. April 2013 07:55
To: Gellner, Christoph (ADITG/SW1)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] ASOC snd_soc_dai_ops for clock mux control

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


Let's say your CPU DAI IP has 3 clocks which we'll call MCLK (master clock), FLL1, and FLL2 (the two oversampling clocks).

Are you wanting a way to say: "RX should use FLL1 and TX should use FLL2" ??

If so, there's a couple options I can think of.  (A) You could call a codec-specific API in your machine driver that expresses this intent. 
(B) you could create "virtual" clock ID's that express the mapping (e.g. 
FLL1_TX, FLL1_RX, FLL2_TX, FLL2_RX).  I think (A) is a cleaner solution that clearly communicates what is happening.

-gabriel
