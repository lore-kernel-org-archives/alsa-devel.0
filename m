From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 0/7] Introduce AVTP Audio
	Format (AAF) plugin
Date: Wed,  3 Oct 2018 16:45:40 -0700
Message-ID: <20181003234547.16839-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ADF22677F0
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 01:46:49 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi all,

The AAF plugin RFC series v2 has been around on alsa-devel ML for more than two
weeks so I'm moving forward and sending it as PATCH series now.

The first 5 patches from this series are pretty much the same from the previous
version. The news are the top 2 patches which add more functionality to the
plugin. Patch 6/7 implements the dump() callback which has been useful for
debugging purposes and Patch 7/7 adds support for direct read/write transfers.

For general context information about the AAF plugin, I'm quoting below the
cover letter from the RFC series v1:

	"This patchset introduces the AAF plugin to the alsa-plugins project
	which enables TSN audio applications on Linux.

	For those not familiarized with TSN, it stands for Time-Sensitive
	Networking, and it's a set of IEEE technologies (enhancements to IEEE
	802.1Q and Ethernet protocols) that provide precise time
	synchronization, bounded latency and application interoperability to
	bridged networks. Those technologies enable time-sensitive applications
	such as audio, video and control loops to run on top of bridged
	networks, co-existing with regular applications. TSN technologies are a
	super set of Audio Video Bridging (AVB) technologies also developed by
	IEEE. AVTP is the protocol defined to transport data in a TSN system,
	and AAF is one of the formats defined by AVTP to encapsulate audio
	data. AAF is specified in Chapter 7 from the AVTP spec [1].

	This work is part of the effort to enable TSN technologies on upstream
	Linux ecosystem. All building-blocks required to enable TSN audio
	applications have been already developed and pushed to upstream
	projects. Time synchronization features are provided by linuxptp
	project [2], bounded latency features are provided by Linux Traffic
	Control subsystem since kernel version 4.15 [3], and AVTP packetization
	is provided by libavtp [4]. What is currently missing in the ecosystem
	to enable TSN audio applications is a piece of software that plumbs it
	all together and interfaces with Linux Audio system properly. That's
	the point of the AAF plugin introduced here.

	The AAF plugin is a PCM plugin that uses AVTP protocol to transmit /
	receive audio data through a TSN capable network.  When operating in
	playback mode, the plugin reads PCM samples from the audio buffer,
	encapsulates into AVTP packets and transmits to the network, mimicking
	a typical AVTP Talker. When operating in capture mode, the plugin
	receives AVTP packets from the network, retrieves the PCM samples, and
	present them to alsa-lib layer at the presentation time, mimicking a
	typical AVTP Listener."

For further information about what has been previously discussed, please refer
to RFC series v1 and v2 archives in [5] and [6]. Finally, all versions of this
series can be also found in my alsa-plugins tree in github [7].

Best regards,

Andre

[1] 1722-2016 - IEEE Standard for a Transport Protocol for Time-Sensitive
    Applications in Bridged Local Area Networks
[2] http://linuxptp.sourceforge.net
[3] https://patchwork.ozlabs.org/cover/826678/
[4] https://github.com/AVnu/libavtp
[5] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-August/139494.html
[6] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140290.html
[7] https://github.com/aguedes/alsa-plugins

Andre Guedes (7):
  aaf: Introduce plugin skeleton
  aaf: Load configuration parameters
  aaf: Implement Playback mode support
  aaf: Prepare for Capture mode support
  aaf: Implement Capture mode support
  aaf: Implement dump() ioplug callback
  aaf: Add support for direct read/write transfers

 Makefile.am     |    3 +
 aaf/Makefile.am |    9 +
 aaf/pcm_aaf.c   | 1197 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac    |    9 +
 doc/aaf.txt     |  142 +++++++
 5 files changed, 1360 insertions(+)
 create mode 100644 aaf/Makefile.am
 create mode 100644 aaf/pcm_aaf.c
 create mode 100644 doc/aaf.txt

-- 
2.14.4
