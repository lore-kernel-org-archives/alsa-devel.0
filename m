From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Bug#701498: hda: Internal mic does not work on
 Thinkpad T420s (CX20590 codec)
Date: Mon, 25 Feb 2013 13:51:12 +0800
Message-ID: <CAN8ccibeWhvCJMRjR0WuppYFqTZY6Fa_-J8FDN3uUS7yt0QGOA@mail.gmail.com>
References: <20130223194257.7554.82839.reportbug@katniss.segie>
 <1361735995.27602.118.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f169.google.com (mail-ia0-f169.google.com
 [209.85.210.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 0353A265136
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 06:51:13 +0100 (CET)
Received: by mail-ia0-f169.google.com with SMTP id j5so2198666iaf.0
 for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2013 21:51:12 -0800 (PST)
In-Reply-To: <1361735995.27602.118.camel@deadeye.wl.decadent.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: alsa-devel@alsa-project.org, Adrian Lang <debian@adrianlang.de>, 701498@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

> On Sat, 2013-02-23 at 20:42 +0100, Adrian Lang wrote:
> > Package: src:linux
> > Version: 3.2.35-2
> > Severity: normal
> >
> > There are two microphones in alsamixer and Gnome 3 audio settings (i.
e.,
> > pulseaudio), but I can't get any sound using either of them. I think
that's the
> > same problem as reported to [openSUSE] and [Ubuntu].
> >
> > The problem persists with 3.7 (3.7.8-1~experimental.1) from
> > experimental.
> >
> > [openSUSE]
> >
http://forums.opensuse.org/english/get-technical-help-here/laptop/469210-opensuse-12-1-cannot-get-internal-mic-work-lenovo-g770-laptop.html
> > [Ubuntu]
> > https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/938644
>
> I happen to have a Thinkpad T420 with the same audio codec, and the
> internal mic works fine.  (There does seem to be a problem with external
> mics, now that I check, but let's ignore that for now.)  So this is more
> board-specific, not chip-specific, behaviour.
>
> [...]
> > ** Model information
> > sys_vendor: LENOVO
> > product_name: 4171CTO
> > product_version: ThinkPad T420s
> [...]
>
> Does the T420s also have a single socket that can be used with either
> headphones or headset?

Seem related to

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=6b45214277bec2193ad3ccb8d7aa6100b5a0f1a9

Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Control: name="Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Internal Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Internal Mic Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Device: name="CONEXANT Analog", type="Audio", device=0
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80] [0x4a 0x4a] [0x50 0x50] [0x4a 0x4a]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0
  Connection: 4
     0x17 0x18 0x23* 0x24
