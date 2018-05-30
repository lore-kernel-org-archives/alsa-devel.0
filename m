From: Daniel Mack <daniel@zonque.org>
Subject: Remove clkdiv and pll setters from pxa dais
Date: Wed, 30 May 2018 10:35:25 +0200
Message-ID: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id BA3542677C6
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 10:35:27 +0200 (CEST)
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
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

As discussed in the simple-card thread the other day, the .set_clkdiv 
and .set_pll callbacks for DAIs are considered legacy. In order to 
support PXA platforms with DT, we need get rid of those for the DAIs of 
PXA hardware.

On the good side, pxa-ssp is the only problematic one of the PXA dais, 
the ac97, i2s don't have any special clocking knbos, and the mmp-sspa 
should be straight forward to fix.

I looked into pxa-ssp and it seems the conversion to calculate the audio 
clock dividers automatically seems doable.

There are currently 4 platforms that use this cpu dai in mainline that 
also use snd_soc_dai_set_pll() or snd_soc_dai_set_clkdiv():

  * Zylonite
  * Brownstone
  * Magician
  * Raumfeld

I can test modifications on the latter one, but for the others, I need 
to understand what the machine drivers are doing, and there are some 
bits I don't grok.

For instance, code for Zylonite does this:

         /* Add 1 to the width for the leading clock cycle */
         pll_out = rate * (width + 1) * 8;

The commit which introduced these lines dates back to 2009 and was done 
by you, Mark. Can you remember what the reason for this was? I've never 
seen sample frames with 17 bits :) This is a setup that we can't 
generically describe through .hw_params() or .dai_fmt() in the cpu dai, 
correct?

In the magician code, you'll find this:

         case 22050:
                 acps = 5622000;
                 switch (width) {
                 case 16:
                         /* 702750 Hz ~= 22050 Hz * 32 (-0.41%) */
                         acds = PXA_SSP_CLK_AUDIO_DIV_2;
                         break;
                 default: /* 32 */
                         /* 1405500 Hz ~= 22050 Hz * 64 (-0.41%) */
                         acds = PXA_SSP_CLK_AUDIO_DIV_1;
                 }
                 break;
         case 44100:
                 acps = 5622000;
                 switch (width) {
                 case 16:
                         /* 1405500 Hz ~= 44100 Hz * 32 (-0.41%) */
                         acds = PXA_SSP_CLK_AUDIO_DIV_2;
                         break;
                 default: /* 32 */
                         /* 2811000 Hz ~= 44100 Hz * 64 (-0.41%) */
                         acds = PXA_SSP_CLK_AUDIO_DIV_1;
                 }
                 break;


So for both 22050 and 44100, the base frequency and all dividers are the 
same, which can't be right. I assume these rates have never been used. 
I'll ignore this and implement the table in the datasheet which should 
do the right thing. Philipp?

What we need, however, is a way to describe whether the dai is mclk 
master or slave. Would we add a DT propery for that?



Thanks,
Daniel
