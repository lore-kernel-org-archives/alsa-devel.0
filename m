From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Status of ALSA firewire stack at Linux v4.12
	development period
Date: Mon, 24 Apr 2017 21:04:48 +0900
Message-ID: <431ad421-fa5f-6cd7-0315-63b79c68ab8a@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 8714E266D63
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 14:04:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

We are now in the last week of development period for Linux v4.12. All 
of my patches were already merged into 'for-next' branch on
maintainer's repository. This is a digest for the subject.

## New drivers
Two drivers were newly added to sound subsystem:
  * A driver for MOTU FireWire series (snd-firewire-motu)
   * 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/119055.html
  * A driver for RME Fireface series (snd-fireface)
   * 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-March/119360.html

Although both drivers support a part of units on each series, I won't
work for the other units by my self anymore. I wish users are going to
work for enhancement of support for more units.

## Changes for existent drivers
Additionally, below drivers were widely changed:
  * A driver for Digidesign Digi00x series (snd-firewire-dg00x)
   * 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119397.html
  * A driver for TASCAM FireWire series (snd-firewire-tascam)
   * 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/119748.html

Purpose of the changes is mainly for maintenance. Especially, digi00x
driver now got a proper support for its console models. Correspondingly,
some feature of firewire-lib move to firewire-tascam driver.

## Additional Tracepoints
Furthermore, ALSA firewire stack newly supports additional tracepoints:
  * snd_firewire_lib subsystem
   * in_packet_without_header/out_packet_without_header
  * snd_firewire_motu subsystem
   * in_data_block_sph/out_data_block_sph
   * in_data_block_message/out_data_block_mesasge

These tracepoints are available to debug behaviours of drivers newly
added in this development period. Of cource, below tracepoints are still
available for existent drivers:

  * snd_firewire_lib subsystem
   * in_packet/out_packet

These tracepoints are available via tracefs or perf_event_open(2). 
Please refer to proper documentation.

## Known issues
As known issues of IEC 61883-1/6 engine on ALSA firewire stack, the
engine takes target units to generate sound with periodical short
noise. This can be observed except for units based on BeBoB or
Fireface series, and this can not be observed every time of packet
streaming.

The tracepoints declare that the cause does _not_ come from packet
queueing timing and throughput of the amount of data blocks. Thus, It
comes from protocol implementation itself. When consider about a fact
that this depends on the timing to start packet streaming, the cause is
that each unit has a strong demand about sequence of the number of data
blocks in a packet. It might tight on actual isochronous cycle and the
other time clock somehow.

Additionally, as I have reported, some of units based on Dice don't
transfer/receive exactly the same number of total data block as sampling
transmission frequency. In detail, seee:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html

## Useful stuffs
For Linux kernel 4.4 or later, backported code is available in my github
repository:
https://github.com/takaswie/snd-firewire-improve

Drivers in ALSA firewire stack support ALSA HwDep interface. There's a
sample implementation for user space; libhinawa:
https://github.com/takaswie/libhinawa

In detail, please refer to documentation of the library.

Some functionalities of supported units are controllable by tools in
hinawa-utils. This is a sample application of the libhinawa with GOject
Introspection support:
https://github.com/takaswie/hinawa-utils

Currently, they're maintained to assist my work for ALSA firewire stack.
Although it can not satisfy all demands from usual users, I'm welcome to
receive PRs to integrate the tools.

$ git diff --shortstat v4.11-rc1.. sound/firewire/
  43 files changed, 5791 insertions(+), 502 deletions(-)


Regards

Takashi Sakamoto
