From: "Gellner, Christoph (ADITG/SW1)" <cgellner@de.adit-jv.com>
Subject: ASOC snd_soc_dai_ops for clock mux control
Date: Wed, 3 Apr 2013 16:22:00 +0000
Message-ID: <8F928A9825EEF0458AC402C3ABF8BEB1053E0DEF@HI2EXCH01.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id CF451265CBE
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 18:22:02 +0200 (CEST)
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id D7FE11CE2BF
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 18:22:00 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id AD30A1CE2B7
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 18:22:00 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm working on the driver of an audio CPU DAI IP providing
-       Internal clocks which can be used for master clock generation by TX as well as RX section
-       One oversampling clock available to RX section
-       One oversampling clock available to TX section.

Kernel version is 3.5.7

I want to add support to the CPU DAI driver to
-       Specify the rate of the input clocks
-       Select which of the clock inputs shall be used by RX and which shall be used by TX section

I'm currently wondering how to map this to existing snd_soc_dai_ops functions.
Currently I see only set_sysclk, set_pll, set_clkdiv for clock control.

I plan to use set_sysclk to specify the rate as well as the direction of each clock.

What is currently missing for me is a way to specify the clock to be used by RX or TX section.

I can't really add this in set_sysclk. In case I switch to clock X when set_sysclk is called with clock ID of X, I need a way to distinguish if RX or TX section or both need to switch to this clock.
But I can't really double the internal clock X in virtual clocks X_TX, X_RX (one time for TX and one time for RX section) as the internal clock X has only one rate for both sections and this would not represent the hardware correctly.

Do you have any recommendation how to implement ?

What do you think about adding a new function pointer to snd_soc_dai_ops ?
int (*set_clkmux)(struct snd_soc_dai *dai, int mux_id, int source_id);
I think this would be the cleanest solution as it models the features of the hardware (the clock multiplexers for RX or TX sections)

It might be possible to use set_pll or set_clkdiv to realize.
I could use set_pll and ignore the freq_in and freq_out
I could use set_clkdiv and interpret div (divider integer value) as a source_id
But this is not a 100% clean solution in my opinion.


Best regards

Christoph
