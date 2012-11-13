From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH] ASoC: codecs/wm8978: Only reconfigure
 GPIO1 when used for PLL output
Date: Tue, 13 Nov 2012 09:43:08 -0500
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3459CEDE0D5@dekaexchange07.deka.local>
References: <1352482418-64950-1-git-send-email-emillbrandt@dekaresearch.com>
 <20121113064410.GE18224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 356452651FE
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 15:43:10 +0100 (CET)
In-Reply-To: <20121113064410.GE18224@opensource.wolfsonmicro.com>
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
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark,

On 2012-11-13 Mark Brown wrote:

>> -            snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 0x30,
>> +            /*
>> +             * GPIO1 is used for OPCLK, reconfigure into default
>> +             * mode as input - before configuring OPCLKDIV and PLL
>> +             */
>> +            snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 0x37,
>>                                  (opclk_div - 1) << 4);
>
> Previously we weren't changing the pin mode at all, we were only
> updating the bitfield that contains OPCLK.  With your change we will
> also change the pin mode to input, but if the pin is doing any form of
> output (or anything other than input mode) I'd expect this to at least
> glitch things which seems actively harmful.  Why is it being set up as
> an input?  Though I have to say that all this handling of the pin in the
> existing driver looks at best odd.
>
> Your changelog describes what you're doing but not what is being
> fixed...

The issue was in the following snippet:

@@ -529,9 +533,6 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
                        return idx;

                wm8978->mclk_idx = idx;
-
-               /* GPIO1 into default mode as input - before configuring PLL */
-               snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 7, 0);
        } else {
                return -EINVAL;
        }

This bit of code was always reconfiguring the pin to input when it was known
that OPCLK was not needed.  I am using GPIO1 to enable an amplifier, so I do
not want it reconfigured.  I moved the reconfiguring of GPIO1 to the block of
code under "if (f_opclk)", so we can safely assume that that pin is not being
used for something else.

However, I agree that the handling of the pin is odd.  Does OPCLK really need
to be reconfigured as input whenever the PLL values are updated?  I didn't
see anything in the user manual to suggest that that needed to be done.

Eric



This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
