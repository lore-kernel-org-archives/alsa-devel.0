From: "Misael Lopez" <mlopez@sta.samsung.com>
Subject: AK4671 pin sharing
Date: Wed, 25 Nov 2009 11:44:47 -0600
Message-ID: <2A201BEEC85E064DA2513CADA373DB0DA765C9@mx2.telecom.sna.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cuda1.sta.samsung.com (mailedge.sta.samsung.com [63.166.115.4])
	by alsa0.perex.cz (Postfix) with ESMTP id CC2EB2448D
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 18:45:11 +0100 (CET)
Received: from mx2.telecom.sna.samsung.com (localhost [127.0.0.1])
	by cuda1.sta.samsung.com (Spam Firewall) with ESMTP id 0D31B2A9483
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 11:45:06 -0600 (CST)
Received: from mx2.telecom.sna.samsung.com ([105.52.12.121]) by
	cuda1.sta.samsung.com with ESMTP id 6dwdx8OqCIGFR7ca for
	<alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 11:45:06 -0600 (CST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm interested in adding some functionalities to ak4671 codec driver
(currently hosted in for-2.6.33 branch). The driver has support for
single ended inputs/outputs only, but the actual hardware supports
full-differential mode as well. However, the chip doesn't have separate
pins for the differential input/outputs, but instead the same pins
used in single-ended mode can be reconfigured and reused.

For example: LIN1 and RIN1 inputs (single-ended) can become IN1+/-
(differential input), LIN2/RIN2 -> IN2+/-, etc. Similarly for outputs,
LOUT1 and ROUT1 (single-ended) can become Mono Receiver RCP/RCN
(BTL output), LOUT3/ROUT3 can become Mono Line Output LOP/LON
(full-differential). Changing the function of a pin also modifies the
audio map:

- Mic Amp Left Mux allow to choose between LIN1, LIN2, LIN3 and LIN4,
  when pins are configured as single-ended inputs. However, if they
  are as differential inputs, then the options of Mic Amp Left Mux
  becomes only IN1+/- and IN3+/-. Similarly for Mic Amp Right Mux:
  IN2+/- and IN4+/-.
- For outputs, single-ended stereo outputs LOUT1/ROUT1, LOUT2/ROUT2
  and LOUT3/ROUT3 have separate analog mixers for each channel. But
  when the output pins work as RCP/RCN or LOP/LON, the output is mono
  and then each output has a single analog mixer.

My concerns are:
- When inputs/outputs are single-ended, then they have its own widgets,
  i.e.: 
  SND_SOC_DAPM_INPUT("LIN1")
  SND_SOC_DAPM_INPUT("RIN1")
  But when they are switched to full-differential mode, they cannot have
  a separate widget anymore but a single widget instead:
  SND_SOC_DAPM_INPUT("IN1+/-")
  Then, it makes me think that input/output widgets cannot be reused in
  above case. I guess that having the three widgets at the same time is
  not a safe choice either.
- Audio map changes depending on the mode of inputs or outputs, I don't
  know how the SoC codec driver could handle that.

Any suggestion on what to do in above scenarios?

Thanks,
-Misa
