From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: poor sound from ALC 850/880 in alsa 1.0.21 and
	1.0.23
Date: Wed, 1 Dec 2010 17:35:57 +0800
Message-ID: <AANLkTimxEgzf6Pu5Kti2YC+9GyWDxw=sYv8i+DBdcw+b@mail.gmail.com>
References: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
	<AANLkTikWLaEomZBVSd5iGo8D5rz51aFiA6waMw6JqpUh@mail.gmail.com>
	<AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
	<AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
	<AANLkTi=GJgmYcDd-d6hqOW2uYwJ0i5KYOviv4Dx+JVg_@mail.gmail.com>
	<AANLkTi=Z1mzT70LSySZoY5W-j70p=AB=HJ5ezTYP=FLG@mail.gmail.com>
	<AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AF9CF10393C
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 10:35:57 +0100 (CET)
Received: by eyg24 with SMTP id 24so3312606eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 01:35:57 -0800 (PST)
In-Reply-To: <AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/12/1 Colin Kincaid Williams <discord@uw.edu>

> I selected node 0x0c in  hdaanalyzer and see audio mixer [OxOb] in the
> Connection list, but I cannot select the radio button.
>

According to the block diagram of alc880 datasheet, it look like two mute
switches for node 0x02 and 0x0b or checkbox in hda_analyzer

> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>  Amp-In vals:  [0x00 0x00] [0x00 0x00]

Unfortunately hda_analyzer seem fail to parse your codec -info

  File "./hda_analyzer.py", line 483, in <module>
    sys.exit(main(sys.argv))
  File "./hda_analyzer.py", line 460, in main
    if read_nodes(sys.argv[1:]) == 0:
  File "./hda_analyzer.py", line 110, in read_nodes
    read_nodes3(card, idx, i)
  File "./hda_analyzer.py", line 77, in read_nodes3
    c = HDACodecProc(card, codec, proc_file)
  File "/home/raymond/hda-analyzer/hda_proc.py", line 474, in __init__
    self.parse(proc_file)
  File "/home/raymond/hda-analyzer/hda_proc.py", line 678, in parse
    node.add_ampvals(line[15:], HDA_INPUT)
  File "/home/raymond/hda-analyzer/hda_proc.py", line 353, in add_ampvals
    self.wrongfile('amp vals ]')
  File "/home/raymond/hda-analyzer/hda_proc.py", line 143, in wrongfile
    raise ValueError, "wrong proc file format (%s)" % msg
ValueError: wrong proc file format (amp vals ])




>
> On Sun, Nov 28, 2010 at 11:40 PM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
> > 2010/11/28 Colin Kincaid Williams <discord@uw.edu>
> >
> >> no, the motherboard has 6 plugs, but no digital outputs on the back.
> >> Furthermore, I muted the CD channel, the line in was already muted,
> >> but I still have crap sound compared to my $20 mp3 player. Something
> >> else is wrong!
> >>
> >>
> > Take a look at the block diagram of alc880 datasheet
> >
> > does it help when you use hda-analyzer to mute the amp-in value from node
> > 0x0b in 0x0c ?
> >
> >
> > Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> >  Control: name="Front Playback Volume", index=0, device=0
> >    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> >  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> >  Amp-In vals:  [0x00 0x00] [0x00 0x00]
> >  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
> >  Amp-Out vals:  [0x33 0x33]
> >  Connection: 2
> >     0x02 0x0b
> >
>
