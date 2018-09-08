From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Sat, 8 Sep 2018 11:53:31 +0900
Message-ID: <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 57885267827
 for <alsa-devel@alsa-project.org>; Sat,  8 Sep 2018 04:53:36 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so7844465pgc.6
 for <alsa-devel@alsa-project.org>; Fri, 07 Sep 2018 19:53:35 -0700 (PDT)
In-Reply-To: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
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
To: sbahling@suse.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Scott,
(C.Ced to alsa-devel, ffado-devel)

On Sep 7 2018 23:01, Scott Bahling wrote:
> I recently got my hands on a FW-1884 and would like to get it working in
> Linux. I'm mostly interested in using the control interface which should
> support several midi control interface protocols like Mackie Control or
> Mackie HUI. From the user manual it appears that the host computer needs to
> set the registers on the FW-1884 to switch modes (they reference Windows
> applications).
> 
> I see that you have recently been working on user space support asynchronous
> commands to such devices. The hinawa_utils code has some beginnings of
> support for setting options on the Tascam devices and I have just started
> playing with that.

Thanks for your suggestion.

At present, the most of features on control surface of FW-1884 are not
available, especially for fader, knob and start/stop buttons.

In data transmission between system and devices on IEEE 1394 bus,
both of asynchronous transactions and isochronous packet streams are
available. In a case of TASCAM FireWire series, messages via MIDI
physical interface is bypassed to asynchronous transaction, while
messages generated on control surface are bypassed to isochronous
packets, multiplexed with PCM frames.

When enabling multiplexing messages to isochronous packet,
demultiplexer should be implemented to ALSA firewire-tascam driver,
but not yet. You can see my initial RFC in alsa-devel[1]. This patch
enables userspace applications to perform the demultiplexing, however
this idea easily brings cache-coherency problems due to page mapping
between kernel/userspace and impossible to be applied. We need to
investigate another idea to achieve the demultiplexing in kernel land.

As another option, according to page 26 in 'TASCAM FW-1884 Owner's
Manual', when programming Keys to port 1-4, system could receive MIDI
messages from control surface of FW-1884. However, I've not investigated
it.

> How are you determining the registers and flags? Do you have documentation,
> or are you reverse engineering? Do you know the registers and flags for
> setting the control protocol?
> 
> If you have any hints on how figure out the proper registers and flags I'm
> happy to contribute to the work you have started and help support more
> functions of the FW-1884.

User manuals are documents to which we can refer. The most vendors
licenses their drivers/software with EULA and in most cases it can't
allow users to binary-based reverse engineering.

All of my work are done with external protocol analyzer unit on
IEEE 1394 bus. When working to implement drivers, I
read/classified/parsed content of many packets sniffed by the analyzer.
An initial idea of libhinawa/hinawa-utils is to assist this my work.

I heard FFADO developers uses some ways for this type of work:
  - Usage of host controller of TI PCILynx and driver module (nosy.ko)
  - Windows application; bushound[2]

However, this type of work takes you long time, so I don't necessarily
recommend you. It's 2018 and I think you can find alternative control
surfaces on USB. If you take long time to make devices available on
GNU/Linux, it's better to select devices on 'live' buses instead of
'legacy' buses such as IEEE 1394 bus, IMO. In a case of USB, wireshark
with usbcap is the easiest way for us to sniff packets on Windows.

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094817.html
[2] http://perisoft.net/bushound/

Regards

Takashi Sakamoto
