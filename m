From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PROBLEM: [Lenovo ThinkPad X61s] Speaker volume
 mutes itself in random intervals after upgrading from 3.11 to 3.15.
Date: Mon, 2 Jun 2014 21:35:50 +0800
Message-ID: <CAN8cciYJN-rwdDy8nrZV0jqY0EX9H8Rny11DjYdhQ2AgJQ8oMg@mail.gmail.com>
References: <538ACE22.9020306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id B45022651F3
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 15:35:51 +0200 (CEST)
Received: by mail-qg0-f49.google.com with SMTP id a108so10498219qge.8
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 06:35:50 -0700 (PDT)
In-Reply-To: <538ACE22.9020306@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Fedora <alexander.fedora@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> [1.] One line summary of the problem: [Lenovo ThinkPad X61s] Speaker
> volume mutes itself in random intervals after upgrade to latest kernel
> [2.] Full description of the problem/report:
>
> Speaker mutes itself in random intervals. Headphones are working fine at
> that moment. I can see what volume of the Speaker drops to 0% and then back
> to 100% using alsamixer. It seems like Internal Mic Boost also jumps from
> 100% to 0% and back. It is regression from 5ccc618fee67f0f0b2122dd4b32a02fd2b6a1569
> (ALSA: hda - Remove static quirks for AD1884/1984 & variants). I've tested
> previous commit aa95d61b43e0fcb0b2ce68e5efa37174fd9e5cd3 (ALSA: hda -
> Remove static quirks for AD1882) and audio works as expected.
>
> New kernel shows two controls "Headphone Playback Volume" and "Speaker
> Playback Volume". But old one shows single control "PCM Playback Volume".
> "Speaker Playback Volume" is the one which gets muted randomly.
>
> [3.] Keywords (i.e., modules, networking, kernel):
> [4.] Kernel version (from /proc/version):
> Linux version 3.15.0-999-generic (apw@gomeisa) (gcc version 4.6.3
> (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201405310205 SMP Sat May 31 06:06:08 UTC
> 2014
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
>
>
>
> Codec: Analog Devices AD1984
> Address: 0
> AFG Function Id: 0x1 (unsol 0)
> Vendor Id: 0x11d41984
> Subsystem Id: 0x17aa20d6
> Revision Id: 0x100400
> Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
>   Control: name="Headphone Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Device: name="AD1984 Analog", type="Audio", device=0
>   Device: name="AD1984 Alt Analog", type="Audio", device=2
>   Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x27 0x27]
>   Converter: stream=0, channel=0
>   Power states:  D0 D3
>   Power: setting=D0, actual=D0
> Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
>   Control: name="Speaker Playback Volume", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>   Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Converter: stream=0, channel=0
>   Power states:  D0 D3
>   Power: setting=D0, actual=D0
>
> APLAY
>
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 2: AD1984 Alt Analog [AD1984 Alt Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>
>
==> lo_type=2, wired=1, mio=1, badness=0x0
multi_outs = 11/0/0/0 : 3/0/0/0 (type HP)
  out path: depth=4 :03:22:07:11
spk_outs = 12/0/0/0 : 4/0/0/0
  spk path: depth=3 :04:0a:12
==> Best config: lo_type=2, wired=1, mio=1
multi_outs = 11/0/0/0 : 3/0/0/0 (type HP)
  out path: depth=4 :03:22:07:11
spk_outs = 12/0/0/0 : 4/0/0/0
  spk path: depth=3 :04:0a:12


Even driver can handle automute when HP is transferred to multi out (Line
out type = HP )

But independent headphone assume headphone must be placed in the hp path
and line out in multi_out.

Device: name="AD1984 Analog", type="Audio", device=0
  Device: name="AD1984 Alt Analog", type="Audio", device=2

this mean indep_hp_possible() should return false when Line out type is not
AUTO_PIN_LINE_OUT

if (cfg->line_out_type != AUTO_PIN_LINE_OUT)
      return false;
