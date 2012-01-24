From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: soc-dsp programming model for loopbacks
Date: Tue, 24 Jan 2012 13:36:18 -0800
Message-ID: <45282.1752442562$1327441035@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 57A91103B29
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 22:36:58 +0100 (CET)
Content-Language: en-us
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
Cc: 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,
I've been doing some work on audio loopback (FM radio, BT, Modem -> audio
codec), and I am somewhat confused by the soc-dsp programming model. Let me
take the FM radio example:

If the FM radio is directly connected to the audio codec, my understanding
is that changing the routing with codec controls will trigger the DAPM
logic, which will turn on everything that needs to be on. Very simple, no
matter if the FM-codec link is analog or digital.

Now if the FM radio routing is handled with a digital loopback on the
application processor audio dsp (omap-abe, Intel SST, etc), then soc-dsp
will need to be used. And for a simple FM playback, I need to 
1. configure the audio codec routing for output selection 
2. open a virtual front-end for FM capture 
3. configure the DSP routing to link capture front-end to I2S1 backend (FM
interface) 
4. open a virtual front-end for FM playback 
5. configure the DSP routing to link playback front-end to I2S2 backend
(codec interface)

That seems complicated. To some extent, having the ability to have two
back-ends connected together would make more sense, and would simplify the
programming model a great deal. User-space code would be similar for
loopbacks internal to the codecs or handled on the application processor.
This would apply to Bluetooth and modem connections as well. Without this
capability, we will end-up with multiple 'virtual' front-ends (6 in my
case), making user-space code quite complex.
Looking at the current soc-dsp code, I saw that each back-end is supposed to
have at least one front-end client, and the impact of my proposal seems
fairly important. Before I start looking further into code changes, I wanted
to see if my understanding is correct and if there are other ideas to
simplify loopbacks.
Thanks for your feedback,
-Pierre
