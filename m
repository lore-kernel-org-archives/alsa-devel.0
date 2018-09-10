From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Mon, 10 Sep 2018 16:59:44 +0900
Message-ID: <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AEFD266E0E
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 09:59:49 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id y4-v6so10040369pgp.9
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 00:59:49 -0700 (PDT)
In-Reply-To: <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
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
To: Scott Bahling <sbahling@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Scott,

On Sep 8 2018 20:21, Scott Bahling wrote:
>> When enabling multiplexing messages to isochronous packet,
>> demultiplexer should be implemented to ALSA firewire-tascam driver,
>> but not yet. You can see my initial RFC in alsa-devel[1]. This patch
>> enables userspace applications to perform the demultiplexing, however
>> this idea easily brings cache-coherency problems due to page mapping
>> between kernel/userspace and impossible to be applied. We need to
>> investigate another idea to achieve the demultiplexing in kernel
>> land.
> 
> Thanks for the information! I read the RFC and your initial code. Why
> did you remove the virtual MIDI port code that was part of the RFC code
> (I don't see it upstream)? Did it not work? What I have discovered is
> that in "computer control" mode the unit sends MIDI messages via the
> virtual midi port (control port). The Tascam Native protocol as well as
> the other emulations like Mackie are routed via that virtual midi port
> and never touch the physical midi ports.
> 
> So the secret might be enabling the virtual midi ports - but it's still
> not clear to me if those ports are created/mapped within the FW-1884,
> or need to be created on the host OS based on the isochronous packet
> data. The latter would be more work.

I depict an overview relevant to messages from control surface of FW-1884.

           IEEE 1394 bus
  +-------+            +--------+
  |       |   isoc     |        |          +->PCM frames
  |FW-1884| ---------> |1394OHCI| -(demux)-+
  |       |   packet   |        |          +->control message
  +-------+            +--------+                   |
                                                (convert)
                                                    v
                                            Mackie control/HUI
                                                    v
                                               applications

The position of control message in isochronous packet is fixed and
unable to change. Conversion of control message to Mackie control or
HUI is done by software running on operating system.

Below is an actual sample of isochronous packets from the unit.

packet 1:
   CIP header: 0x001400EA,0x9E000000,
   datablock1: 0xE63AE63A,(..PCM frames..),0x00000000,
   datablock2: 0xE63BE63B,(..PCM frames..),0x00000001,
   datablock3: 0xE63CE63C,(..PCM frames..),0x00000000,
   datablock4: 0xE63DE63D,(..PCM frames..),0x00000000,
   datablock5: 0xE63EE63E,(..PCM frames..),0x00000000,
   datablock6: 0xE63FE63F,(..PCM frames..),0x00000000,
packet 2:
   CIP header: 0x001400F0,0x9E000000,
   datablock1: 0xE640E640,(..PCM frames..),0x00020000,
   datablock2: 0xE641E641,(..PCM frames..),0x000B0002,
   datablock3: 0xE642E642,(..PCM frames..),0x00000000,
   datablock4: 0xE643E643,(..PCM frames..),0x00000000,
   datablock5: 0xE644E644,(..PCM frames..),0x00000000,
packet 3:
   CIP header: 0x001400F5,0x9E000000,
   datablock1: 0xE645E645,(..PCM frames..),0xFFFF00C9,
   datablock2: 0xE646E646,(..PCM frames..),0xFFFFFFFF,
   datablock3: 0xE647E647,(..PCM frames..),0xFFFFFFFF,
   datablock4: 0xE648E648,(..PCM frames..),0xFFFFFFFF,
   datablock5: 0xE649E649,(..PCM frames..),0xFFFFFFFF,
   datablock6: 0xE64AE64A,(..PCM frames..),0x00000000,
packet 4:
   CIP header: 0x001400FB,0x9E000000,
   datablock1: 0xE64BE64B,(..PCM frames..),0x00000000,
   datablock2: 0xE64CE64C,(..PCM frames..),0x00000000,
   datablock3: 0xE64DE64D,(..PCM frames..),0x00000000,
   datablock4: 0xE64EE64E,(..PCM frames..),0x00000000,
   datablock5: 0xE64FE64F,(..PCM frames..),0x00000000,

The first quadlet in each data block represents the count of transferred
data blocks: 0x00000000,0x00010001,...,0xfffefffe,0xffffffff(back to
0x00000000). The last quadlet in each data block represents control and
status data. 64 quadlets of the data consists of one image of control
and status.

For example, the second data block of packet 3 can be parsed:
  * __be32 image[64];
  * pos = (0xE646E645 % 64)
  * image[pos] = 0xFFFF00C9

The above sample includes a part of the image, below.
   image[58] = 0x00000000
   image[59] = 0x00000001
   image[60] = 0x00000000
   image[61] = 0x00000000
   image[62] = 0x00000000
   image[63] = 0x00000000
   image[00] = 0x00020000
   image[01] = 0x000B0002
   image[02] = 0x00000000
   image[03] = 0x00000000
   image[04] = 0x00000000
   image[05] = 0xFFFF00C9
   image[06] = 0xFFFFFFFF
   image[07] = 0xFFFFFFFF
   image[08] = 0xFFFFFFFF
   image[09] = 0xFFFFFFFF
   image[10] = 0x00000000
   image[11] = 0x00000000
   image[12] = 0x00000000
   image[13] = 0x00000000
   image[14] = 0x00000000
   image[15] = 0x00000000

The frequency to update this image depends on the number of data blocks
per second(=current sampling transmission, sampling rate):
  - 44.1kHz: 1.45 msec (=64/44100)
  - 48.0kHz: 1.33 msec (=64/48000)
  - 88.2kHz: 0.72 msec (=64/88200)
  - 96.0kHz: 0.66 msec (=64/96000)

However, in current implementation of packet streaming engine for
IEC 61882-1/6 of ALSA firewire stack, 16 packets are handled in one 
interrupt (INTERRUPT_INTERVAL=16). Therefore, a period to handle a batch
of packet is 7.8125 msec (=16/8000, 8000 is the number of isochronous
cycles in IEEE 1394 bus).

As long as I know, the image consists of below information:
  - pos  0-15: control messages from physical control surface
  - pos 16-23: analog input level
  - pos 24-31: digital ADAT input level
  - pos 32-33: digital S/PDIF input level
  - pos 34-35: (not cleared yet)
  - pos 36-43: analog output level
  - pos 44-64: (not cleared yet)

When parsing the image, a parser should generate several types of
events. I prefer to implementing this complicated work in user space
instead of kernel space. Expecially for pos 16-23/24-31/32-33/36-43, the
parser should always generate events to notify each of the levels.

What we should do is to parsing the image and generate events with
enough consideration of task scheduling and eventing dencity. The parser
could be implemented as an application of ALSA sequencer.


Regards

Takashi Sakamoto
