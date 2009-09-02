From: hari n <hnagalla@gmail.com>
Subject: <alsa-dev> RFC for OMAP4 audio driver
Date: Tue, 1 Sep 2009 21:27:30 -0500
Message-ID: <baee637d0909011927m5df3bd58uf7cabfc474f50274@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EC7E24427
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 04:27:32 +0200 (CEST)
Received: by fxm3 with SMTP id 3so502756fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2009 19:27:30 -0700 (PDT)
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

Hardware Background
-------------------
ABE (Audio back end) IP on the OMAP4 SoC of TI provides digital
audio signal processing features (real-time mixing, equalization,
etc) on the media processor. ABE allows flexible routing of the
audio paths with dedicated equalizer and acoustics protection for
earphone/ headphone, hands-free and vibra paths. Typically the ABE
is connected to a companion analog audio chip via a dedicated McPDM
(multi-channel pulse density modulation) as show at

http://dev.omapzoom.org/?p=misael/kernel-audio.git;a=blob;f=sound/soc/codecs/abe/abe.jpg;h=f9217d7bfa82c28562726cda087d88d29c6a5fad
;

Proposal
--------
On OMAP4, audio codec functionality is spread between ABE of OMAP4
and the companion analog audio chip. The interface between the ABE
and Phoenix audio chip is proprietary McPDM interface. The proposal
is to combine both ABE and Phoenix into a codec driver. OMAP4 ABE
also provides other links for routing digital processed data to
McBSP, McASP interfaces, which are at the same level as McPDM
interface.

               +---------+  +---------------------+
ALSA Library --|ASOC Core|--|OMAP4 Platform Driver|
               +---------+  +---------------------+
                                       |
                                   <DMA-DAI>
                                       |
                           +-----------------------+
                           |ABE--<McPDM>--Phoenix--|--o Speaker/MIC
                           +-----------------------+

ABE provides a FIFO interface (similar to McBSP FIFO) and the audio
data transfer between the audio buffers and ABE FIFO is handled
through the CPU DAI. Handling of the McPDM interface between the
digital audio (ABE) and analog audio chip (Phoenix) is handled
internally in the codec driver as part of the codec DAI operations.

This RFC addresses the basic audio usecases using Phoenix companion
chip with the OMAP4 audio IP block. Support and configuration for
using different codecs (connectivity with BT/FM etc) using I2S/PCM
interfaces are targeted for future enhancements.

High Level Design
-----------------
Following are the files consisting of the TI OMAP4 audio driver:

sound/soc/omap/omap-pcm.c: This is the platform driver for OMAP
   audio. It remains the same across all OMAP chip versions.

sound/soc/codecs/abe-twl6030.c: This is the codec driver interface
   file for OMAP4 audio. It defines the codec DAIs for the HIFI,
   voice and Vibra subdevices. Handles the configuration of Phoenix
   companion chip using i2c control interface. Handles the
   initialization and configuration of ABE. All codec related widget
   controls are also handled in this file. Both, digital (ABE) and
   analog (twl6030) widgets will be contained in this same driver.

sound/soc/codecs/abe/*: This folder contains the ABE specific
   handlers. i.e reset, clock, configuration of ABE ports for
   different stream inputs/outputs etc.

sound/soc/omap/oma-abe.c: This is the DAI driver towards the abe.

sound/soc/omap/sdp4430.c: This is the machine driver for SDP4430
and defines the stream connections.

Questions
---------
How to handle routing of digital audio from ABE to external devices
like Bluetooth/FM connectivity devices which are usually connected
using McBSP interfaces?. In these scenarios, we need another DAI
between the ABE (platform codec) and an external codec.


ABE(platform Codec (Digital) -----> Phoenix audio codec
                               |
                               |
                   +--> BT/FM codec
