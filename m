From: Daniel Mack <zonque@gmail.com>
Subject: Re: GR-55 Driver
Date: Thu, 12 May 2011 21:47:17 +0200
Message-ID: <BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
References: <1305224448.5083.37.camel@TrinaryDragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 168531037E3
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 21:47:18 +0200 (CEST)
Received: by pwi9 with SMTP id 9so1018001pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 12 May 2011 12:47:17 -0700 (PDT)
In-Reply-To: <1305224448.5083.37.camel@TrinaryDragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jeff,

On Thu, May 12, 2011 at 8:20 PM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
> I need a Driver for the Roland GR-55 Guitar Synthesizer, not sure how to
> get started, so I thought this would be a good place to ask.

First of all, thanks for considering contribution to the ALSA project.

> The GR-55 has MIDI and AUDIO
>
> KSNAME_Wo11="WaveOut1-1"
> WDM.Wo11.szPname="OUT (GR-55)"
>
> KSNAME_Wi11="WaveIn1-1"
> WDM.Wi11.szPname="IN (GR-55)"
>
> KSNAME_Md11="Midi1-1"
> WDM.Md11.szPname="GR-55"
>
> My thinking is that there may be a driver that is similar, or someone
> could already be working on a driver, if so, I would like to find out if
> I could work on that project or if I could start a new project here.

Given that this device is connected via USB, the first thing to find
out is whether the device is implemented in any class-compliant way.
"lsusb -v" will provide a lot of information that is needed to know
where to start.

Basically, there are two options. Either the device just needs some
entries in the quirks tables of the generic ALSA USB audio driver,
which is very likely. Or the device uses an entirely proprietary
protocol on the bus (like the usx2y, ua101, Terratec 6fire or the
older Native Instruments cards do) which means that there is need to
write a specific driver from scratch. The drivers I mentioned are all
in the mainline kernel git repository and serve well as examples for
new implementations.

So in short: the first thing to do is to share the output of "lsusb
-v" on this list.

HTH,
Daniel
