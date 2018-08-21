From: Andre Guedes <andre.guedes@intel.com>
Subject: [RFC - AAF PCM plugin 0/5] Introduce AVTP Audio Format
	(AAF) plugin
Date: Mon, 20 Aug 2018 18:06:48 -0700
Message-ID: <20180821010653.15838-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 30CC626766C
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 03:07:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi all,

This patchset introduces the AAF plugin to the alsa-plugins project which
enables TSN audio applications on Linux.

For those not familiarized with TSN, it stands for Time-Sensitive Networking,
and it's a set of IEEE technologies (enhancements to IEEE 802.1Q and Ethernet
protocols) that provide precise time synchronization, bounded latency and
application interoperability to bridged networks. Those technologies enable
time-sensitive applications such as audio, video and control loops to run on
top of bridged networks, co-existing with regular applications. TSN
technologies are a super set of Audio Video Bridging (AVB) technologies also
developed by IEEE. AVTP is the protocol defined to transport data in a TSN
system, and AAF is one of the formats defined by AVTP to encapsulate audio
data. AAF is specified in Chapter 7 from the AVTP spec [1].

This work is part of the effort to enable TSN technologies on upstream Linux
ecosystem. All building-blocks required to enable TSN audio applications have
been already developed and pushed to upstream projects. Time synchronization
features are provided by linuxptp project [2], bounded latency features are
provided by Linux Traffic Control subsystem since kernel version 4.15 [3], and
AVTP packetization is provided by libavtp [4]. What is currently missing in the
ecosystem to enable TSN audio applications is a piece of software that plumbs
it all together and interfaces with Linux Audio system properly. That's the
point of the AAF plugin introduced here.

The AAF plugin is a PCM plugin that uses AVTP protocol to transmit/receive
audio data through a TSN capable network.  When operating in playback mode, the
plugin reads PCM samples from the audio buffer, encapsulates into AVTP packets
and transmits to the network, mimicking a typical AVTP Talker. When operating
in capture mode, the plugin receives AVTP packets from the network, retrieves
the PCM samples, and present them to alsa-lib layer at the presentation time,
mimicking a typical AVTP Listener.

Details about the plugin implementation are provided in the patches
description, and information on how to configure and run the AAF plugin is
provided in doc/aaf.txt file.

Best regards,

Andre

[1] 1722-2016 - IEEE Standard for a Transport Protocol for Time-Sensitive
    Applications in Bridged Local Area Networks
[2] http://linuxptp.sourceforge.net
[3] https://patchwork.ozlabs.org/cover/826678/
[4] https://github.com/AVnu/libavtp

Andre Guedes (5):
  aaf: Introduce plugin skeleton
  aaf: Load configuration parameters
  aaf: Implement Playback mode support
  aaf: Prepare for Capture mode support
  aaf: Implement Capture mode support

 Makefile.am     |    3 +
 aaf/Makefile.am |    9 +
 aaf/pcm_aaf.c   | 1172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac    |    9 +
 doc/aaf.txt     |  110 ++++++
 5 files changed, 1303 insertions(+)
 create mode 100644 aaf/Makefile.am
 create mode 100644 aaf/pcm_aaf.c
 create mode 100644 doc/aaf.txt

-- 
2.14.4
