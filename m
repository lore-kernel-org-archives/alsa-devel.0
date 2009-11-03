From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: Conexant CX20561 - Microphone problems
Date: Tue, 3 Nov 2009 14:30:15 -0500
Message-ID: <200911031430.15869.shawn.starr@rogers.com>
References: <200910291859.41076.shawn.starr@rogers.com>
	<200911021136.22201.shawn.starr@rogers.com>
	<s5htyxbvpx0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp100.rog.mail.re2.yahoo.com (smtp100.rog.mail.re2.yahoo.com
	[206.190.36.78]) by alsa0.perex.cz (Postfix) with SMTP id D65721037FF
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 20:30:18 +0100 (CET)
In-Reply-To: <s5htyxbvpx0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On November 3, 2009 05:55:07 am Takashi Iwai wrote:
> At Mon, 2 Nov 2009 11:36:21 -0500,
> 
> Shawn Starr wrote:
> > On November 2, 2009 08:05:37 am Takashi Iwai wrote:
> > > At Thu, 29 Oct 2009 18:59:40 -0400,
> > >
> > > Shawn Starr wrote:
> > > > Hello ALSA developers,
> > > >
> > > > I am having problems with the microphone on the following hardware
> > > > this is on a Lenovo W500 laptop.
> > > >
> > > > Card: HDA Intel
> > > > Chip: Conexant CX20561 (Hermosa)
> > > >
> > > > Here is the problems im noticing:
> > > >
> > > > 1) If I use ALSA 'default' with the microphone I get noise
> > > > interference on output [high/low/high/low].
> > > >
> > > > If I switch this to use the "ALSA Capture on HDA Intel [CONEXANT
> > > > Analog] I get interference except it is the standard 60Hz electrical
> > > > noise [steady noise]
> > > >
> > > > 2) Using the internal/external microphones gives an inconsistent
> > > > volume. It also does not seem to work with the microphone cutting out
> > > > so much. I need to adjust Digital + another microphone but it still
> > > > drops capturing.
> > > >
> > > > Alsamixer shows:  Digital/Docking Microphone/External
> > > > Microphone/Internal Microphone
> > > >
> > > > Here is the module options I give to the sound driver:
> > > >
> > > > options snd-intel-hda enable_msi=1 power_save=10
> > > > power_save_controller=true model=laptop index=0
> > > >
> > > > Assuming power saving/controller causes the microphone to cut out or
> > > > not.
> > > >
> > > > 3) I'm now aware that this card has no pinouts for PCM capture
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=502293
> > >
> > > Could you give alsa-info.sh output?  Run with --no-upload option, and
> > > attach the generated file.
> >
> > Here's the attached output,
> 
> Judging from the pin config, in your case, "Docking" seems controlling
> the external-mic volume.  The "External Mic Volume" should be zero.
> 
There is still problems with the volume sensitivity,  but I will adjust to set 
ext mic to zero. Do we need a quirk for the Lenovo W500 then?

Or that's a bug wrt to volume sensitivity and static interferences?

Thanks, 
Shawn.

> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
