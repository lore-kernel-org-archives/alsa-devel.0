From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: Re: My Codec: IDT 92HD75B3X5 issues
Date: Tue, 29 Sep 2009 07:40:56 +0300
Message-ID: <200909290740.57029.munzirtaha@gmail.com>
References: <200909280658.46580.munzirtaha@gmail.com>
	<s5hfxa74g1b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f205.google.com (mail-bw0-f205.google.com
	[209.85.218.205])
	by alsa0.perex.cz (Postfix) with ESMTP id A53E624429
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 06:41:01 +0200 (CEST)
Received: by bwz1 with SMTP id 1so3726387bwz.46
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2009 21:41:01 -0700 (PDT)
In-Reply-To: <s5hfxa74g1b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Yaum al-Ithnain 08 Shawwal 1430 11:41:52 am Takashi Iwai wrote:
> At Mon, 28 Sep 2009 06:58:46 +0300,
> 
>  Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=   
=?utf-8?q?_=D8=B7=D9=87?=) wrote:
> > Hi sirs,
> > These are the issues I have with my Laptop HP Pavilion dv6 1225ee
> > regarding audio support.
> >
> > 1. No sense for headphone jack (jack_present?), when headphone is plugged
> > (present_int_hp?)
> >
> > 2. There headphone mic jack is not working. The one next to the webcam is
> > always recording even when I change the "Mic Jack" control from "Mic In"
> > to "Line In"
> 
> Make sure that you use alsa-driver-snapshot tarball instead of 1.0.21
> released version.  There are many fixes since 1.0.21 release.


>  ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-sn
> apshot.tar.gz

Thanks a lot Takashi, things are better now. However, when I tested the 
internal mic it's very noisy. I played a bit with the capture and digital 
controls but still compared with Windows, it's lame. 

> > 3. The mute/unmute LED doesn't change color to RED when its muted like in
> > Windows.
> 
> This isn't supported yet as we have no hardware information.
> Likely one of GPIO pins corresponds to the LED on/off.  You can try
> hda-verb to change the GPIO data bit.

Ok, I will try it and report back.

> > Touching that LED shows this in /var/log/messages:
> >
> > Sep 28 06:53:47 dv6 kernel: [ 9197.986789] atkbd.c: Unknown key released
> > (translated set 2, code 0x94 on isa0060/serio0).
> > Sep 28 06:53:47 dv6 kernel: [ 9197.986791] atkbd.c: Use 'setkeycodes e014
> > <keycode>' to make it known.
> > Sep 28 06:53:47 dv6 kernel: [ 9198.353568] atkbd.c: Unknown key pressed
> > (translated set 2, code 0x94 on isa0060/serio0).
> > Sep 28 06:53:47 dv6 kernel: [ 9198.353572] atkbd.c: Use 'setkeycodes e014
> > <keycode>' to make it known.
> > Sep 28 06:53:47 dv6 kernel: [ 9198.359205] atkbd.c: Unknown key released
> > (translated set 2, code 0x94 on isa0060/serio0).
> > Sep 28 06:53:47 dv6 kernel: [ 9198.359208] atkbd.c: Use 'setkeycodes e014
> > <keycode>' to make it known.
> 
> It's not about the sound driver but the input layer, as you can find.
> You can defien the scan code 0xe014 by yourself.

You are right. What's the best component to report this bug against? kernel?

-- 
Munzir Taha
Telecommunications and Electronics Engineer
Master CIW Designer, ICDL, MOUS, Linux+, LPI, SCSA
Riyadh, SA
