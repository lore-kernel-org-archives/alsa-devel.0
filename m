From: Piotr Lewandowski <piotr.lewandowski@gmail.com>
Subject: Bug#527074: [Pkg-alsa-devel] Bug#527074: /etc/init.d/alsa-utils: `/etc/init.d/alsa-utils stop` triggers amixer error
Date: Fri, 25 Sep 2009 20:54:18 +0200
Message-ID: <20090925185405.GA7479@snowball.coredump>
References: <alpine.DEB.2.00.0905151647420.8826@errno>
 <20090826184219.GA4544@snowball.coredump>
 <20090826200822.GB3089@aragorn.home.lxtec.de>
 <20090826203409.GA5604@snowball.coredump>
 <20090827080612.GA10228@chico.puz>
 <20090827153028.GA2191@snowball.coredump>
 <20090918170255.GB3424@aragorn.home.lxtec.de>
 <20090918200830.GA2320@snowball.coredump>
 <20090918202332.GA5152@aragorn.home.lxtec.de>
Reply-To: Piotr Lewandowski <piotr.lewandowski@gmail.com>, 527074@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.527074.B527074.125390486925241@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20090918202332.GA5152@aragorn.home.lxtec.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: alsa-devel@alsa-project.org
Cc: Elimar Riesebieter <riesebie@lxtec.de>, 527074@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Hi alsa-devel@!

One of the maintainers of alsa-utils package in Debian advised me to ask 
for your help. I've encountered following problem:

#v+
$ amixer -c 0 -q set Mic 0% mute
amixer: Invalid command!
#v-

This command is invoked from /etc/init.d/alsa-utils script during 
system shutdown. Do you have any ideas how to fix that?

Here is some basic info about my hardware:

#v+
$ lspci -v | sed -ne '/Audio/,/^$/p'
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01)
         Subsystem: Hewlett-Packard Company Device 30a2
         Flags: bus master, fast devsel, latency 0, IRQ 16
         Memory at f4580000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: <access denied>
         Kernel driver in use: HDA Intel

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.18a.

$ cat /proc/asound/cards
  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xf4580000 irq 16

$ lsmod | grep snd
snd_hda_codec_si3054     3920  1
snd_hda_codec_analog    53708  1
snd_hda_intel           22092  0
snd_hda_codec           58808  3 snd_hda_codec_si3054,snd_hda_codec_analog,snd_hda_intel
snd_hwdep                6000  1 snd_hda_codec
snd_pcm                 62708  3 snd_hda_codec_si3054,snd_hda_intel,snd_hda_codec
snd_seq                 42120  0
snd_timer               17808  2 snd_pcm,snd_seq
snd_seq_device           6108  1 snd_seq
snd                     48420  9 snd_hda_codec_si3054,snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq,snd_timer,snd_seq_device
soundcore                6204  1 snd
snd_page_alloc           8036  2 snd_hda_intel,snd_pcm
#v-

Notes from the battlefield can be found at Debian BTS #527074[1].

[1] http://bugs.debian.org/527074

Thanks for your help!

Regards,
-- 
Piotr Lewandowski
