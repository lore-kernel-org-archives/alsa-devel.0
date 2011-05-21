From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: UCM files for tegra-wm8903 on seaboard
Date: Sat, 21 May 2011 16:48:20 +0100
Message-ID: <1305992900.3317.16.camel@odin>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47B0F@HQMAIL01.nvidia.com>
	<4DD518D5.8030509@ti.com>
	<BANLkTi=3n1P7V_TOdOzGY0dX9jO5ri9cQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D26E8103810
	for <alsa-devel@alsa-project.org>;
	Sat, 21 May 2011 17:48:26 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3765486wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 21 May 2011 08:48:25 -0700 (PDT)
In-Reply-To: <BANLkTi=3n1P7V_TOdOzGY0dX9jO5ri9cQA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, "Mark Brown
	(broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "jiesun@chromium.org" <jiesun@chromium.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-05-19 at 14:22 -0500, pl bossart wrote:
> >> 2) In the ChromeOS kernel, there's a separate PCM for playback to WM8903
> >> and playback to the SPDIF controller, and hence on to HDMI. Since these
> >> use different values for PlaybackPCM, I defined separate use-cases for
> >> analog and HDMI/SPDIF playback. Is this the typical way of splitting
> >> things up, or would one typically have a unified use-case with the
> >> PlaybackPCM Value being part of the SectionDevice?
> >
> > If the use case is the same, e.g. "Music", I would just add them as different Music devices and have a PlaybackPCM for each of them.
> 
> Looks like Stephen and I share the same questions.
> If we have a single "Music" use case with multiple PCM playback
> devices (in the ALSA sense hw:x,y) listed the same file, how would one
> specify that for example the UCM headphone or speaker devices are
> valid only for the WM8903 output?

Do you mean here that the headphones or speaker are only valid with a
WM8903 PCM i.e. hw0,0 ? If so, I would use the PlaybackPCM tag to
identify that the valid PCM device.

> I am struggling a bit to link Devices as defined by UCM (headset,
> earpiece, etc) and Devices as defined by ALSA...for example I am not
> sure what the cdev statement means in the device definition.
> Confused...
> -Pierre


Sorry, there is a little overlap here with naming. Devices wrt to ALSA
mean the PCM device or card device i.e. the cdev refers the to the sound
card (Jaroslav, pls correct me if I'm wrong here with the cdev naming). 

UCM treats devices as the physical audio transducers (like speakers,
headphones, mic, etc).

Liam  

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
