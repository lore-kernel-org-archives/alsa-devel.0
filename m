From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH - AAF PCM plugin 0/7] Introduce AVTP Audio
 Format (AAF) plugin
Date: Mon, 22 Oct 2018 11:51:58 -0500
Message-ID: <cc4cf88f-9262-360a-24c3-1cf5f760955c@linux.intel.com>
References: <20181003234547.16839-1-andre.guedes@intel.com>
 <s5hefcyxfmm.wl-tiwai@suse.de> <1539206363.3120.14.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 841B32677D0
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 18:52:02 +0200 (CEST)
In-Reply-To: <1539206363.3120.14.camel@intel.com>
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
To: "Guedes, Andre" <andre.guedes@intel.com>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


On 10/10/18 4:19 PM, Guedes, Andre wrote:
> Hi Takashi,
>
> On Wed, 2018-10-10 at 12:25 +0200, Takashi Iwai wrote:
>> On Thu, 04 Oct 2018 01:45:40 +0200,
>> Andre Guedes wrote:
>>> Hi all,
>>>
>>> The AAF plugin RFC series v2 has been around on alsa-devel ML for
>>> more than two
>>> weeks so I'm moving forward and sending it as PATCH series now.
>>>
>>> The first 5 patches from this series are pretty much the same from
>>> the previous
>>> version. The news are the top 2 patches which add more
>>> functionality to the
>>> plugin. Patch 6/7 implements the dump() callback which has been
>>> useful for
>>> debugging purposes and Patch 7/7 adds support for direct read/write
>>> transfers.
>>>
>>> For general context information about the AAF plugin, I'm quoting
>>> below the
>>> cover letter from the RFC series v1:
>>>
>>> 	"This patchset introduces the AAF plugin to the alsa-plugins
>>> project
>>> 	which enables TSN audio applications on Linux.
>>>
>>> 	For those not familiarized with TSN, it stands for Time-
>>> Sensitive
>>> 	Networking, and it's a set of IEEE technologies (enhancements
>>> to IEEE
>>> 	802.1Q and Ethernet protocols) that provide precise time
>>> 	synchronization, bounded latency and application
>>> interoperability to
>>> 	bridged networks. Those technologies enable time-sensitive
>>> applications
>>> 	such as audio, video and control loops to run on top of bridged
>>> 	networks, co-existing with regular applications. TSN
>>> technologies are a
>>> 	super set of Audio Video Bridging (AVB) technologies also
>>> developed by
>>> 	IEEE. AVTP is the protocol defined to transport data in a TSN
>>> system,
>>> 	and AAF is one of the formats defined by AVTP to encapsulate
>>> audio
>>> 	data. AAF is specified in Chapter 7 from the AVTP spec [1].
>>>
>>> 	This work is part of the effort to enable TSN technologies on
>>> upstream
>>> 	Linux ecosystem. All building-blocks required to enable TSN
>>> audio
>>> 	applications have been already developed and pushed to upstream
>>> 	projects. Time synchronization features are provided by
>>> linuxptp
>>> 	project [2], bounded latency features are provided by Linux
>>> Traffic
>>> 	Control subsystem since kernel version 4.15 [3], and AVTP
>>> packetization
>>> 	is provided by libavtp [4]. What is currently missing in the
>>> ecosystem
>>> 	to enable TSN audio applications is a piece of software that
>>> plumbs it
>>> 	all together and interfaces with Linux Audio system properly.
>>> That's
>>> 	the point of the AAF plugin introduced here.
>>>
>>> 	The AAF plugin is a PCM plugin that uses AVTP protocol to
>>> transmit /
>>> 	receive audio data through a TSN capable network.  When
>>> operating in
>>> 	playback mode, the plugin reads PCM samples from the audio
>>> buffer,
>>> 	encapsulates into AVTP packets and transmits to the network,
>>> mimicking
>>> 	a typical AVTP Talker. When operating in capture mode, the
>>> plugin
>>> 	receives AVTP packets from the network, retrieves the PCM
>>> samples, and
>>> 	present them to alsa-lib layer at the presentation time,
>>> mimicking a
>>> 	typical AVTP Listener."
>>>
>>> For further information about what has been previously discussed,
>>> please refer
>>> to RFC series v1 and v2 archives in [5] and [6]. Finally, all
>>> versions of this
>>> series can be also found in my alsa-plugins tree in github [7].
>> The codes look mostly good.  I'll post just a new nitpicking later.
>>
>> But I'd like to postpone the merge until Pierre back from his
>> vacation and getting some feedback from him.

I'm back and will look at those patches this week. I'll probably have to 
talk to Andre to figure out how the clocks are managed, I didn't fully 
understand the answers from August that

"The plugin requires both CLOCK_REALTIME and PTP to be synchronized, and 
this can add some usage scenarios limitation, indeed. However, the 
scenario you described looks still feasible. For instance, at the host 
running as PTP master, we could have NTP disciplining CLOCK_REALTIME 
(ntp daemon) and CLOCK_REALTIME disciplining PTP (phc2sys daemon). At 
the hosts running as PTP slave, we have PTP disciplining CLOCK_REALTIME 
(phc2sys daemon). This way, CLOCK_REALTIME time from all systems is NTP 
time while CLOCK_REALTIME and PTP clock are in sync"

For audio usages we typically have all clocks derived from ART, and we'd 
need the CLOCK_MONOTONIC_RAW to align with the PTP clock to allow for 
loopbacks without ASRC (or ASRC between the audio clock and ART). Not 
sure who uses CLOCK_REALTIME for audio?

> Ok, thanks for letting me know. I'll address your comments locally and
> wait for his feedback before pushing the v2.
>
>> BTW, what's the good way to test this stuff locally?
> The minimal setup to test the plugin requires 2 machines connected
> back-to-back. The machines should be equipped with a TSN-capable NIC
> that supports PTP and FQTSS features. I'm using Intel i210 NIC.
>
> doc/aaf.txt provides detailed instructions on how to setup the PTP and
> FQTSS features from the NIC as well as how to run the plugin. If you
> have any trouble with the instructions, please let me know and I'll fix
> it for the next series version.

I was planning to experiment with two stacked MinnowBoard Turbot quad 
core dual ethernet [1], they have i210 support and would be the 
cheapest/compact way to test all this. You can connect to each board 
from your workstation with one of the two ports for 
updates/command/control and dedicate the second port to AVB/TSN 
transfers between the two boards.

[1] 
https://store.netgate.com/MinnowBoard-Turbot-Dual-Ethernet-Quad-Core-Board-P2780.aspx

>
> Thanks,
>
> Andre
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
