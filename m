From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Wed, 22 Jul 2009 12:53:49 -0500
Message-ID: <1248285229.4822.1.camel@localhost.localdomain>
References: <4A5DB59B.2010407@freenet.de> <s5hvdltnfrp.wl%tiwai@suse.de>
	<1247769012.20483.0.camel@localhost.localdomain>
	<4A5F7D6C.9020606@dmx.com>
	<1248017721.30034.2.camel@localhost.localdomain>
	<s5h3a8sll15.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.210.177])
	by alsa0.perex.cz (Postfix) with ESMTP id BAB2F24481
	for <Alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 19:54:03 +0200 (CEST)
Received: by yxe7 with SMTP id 7so565366yxe.16
	for <Alsa-devel@alsa-project.org>; Wed, 22 Jul 2009 10:54:02 -0700 (PDT)
In-Reply-To: <s5h3a8sll15.wl%tiwai@suse.de>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Fwiw, I reinstalled my kernel to get the old alsa modules back
Linux home 2.6.29.5-191.fc11.i586 #1 SMP Tue Jun 16 23:11:39 EDT 2009
i686 i686 i386 GNU/Linux

and reinstalled this driver:
XFiDrv_Linux_Public_US_1.00

and I am able to use my xfi again without clicks.  Unfortunately, this
driver seems to be no longer developed and has some other issues such as
with skype and pulseaudio.  I'd REALLY prefer to use your driver but I'm
not quite sure what to do.



On Sun, 2009-07-19 at 18:01 +0200, Takashi Iwai wrote:

> At Sun, 19 Jul 2009 10:35:21 -0500,
> Ted T. Logan wrote:
> > 
> > Maybe you haven't been following the thread.  I've been trying to debug the
> > problem.  As I mentioned to Takashi, there's not a point where it broke, it
> > never worked with this driver.
> > There have always been clicks.
> > 
> > However, it does not have clicks with the following driver:
> > XFiDrv_Linux_Public_US_1.00.tar.gz
> > 
> > Sending out condescending messages like this after I was responding to the
> > "testers wanted" mailer which said all cards should be supported now is
> > completely unproductive.
> 
> Well, the current situation is that I've got no other report but you
> regarding the specific problem.  There is a known issue with openal,
> accordingly, but not all apps.  So, this is very likely a different
> issue.
> 
> Actually, it's still the phase to gather all information to know which
> part exactly is problematic.  If you find any other guys that have the
> exact same problem, let me know.  It would make easier to find out a
> problem pattern, either for finding out the culprit or reproducing the
> problem.
> 
> Or, you can do trial-and-error by comparing the driver above and the
> current one (maybe the first committed version is easier to compare).
> This can't be done without the real hardware, so it's actually up to
> you how to fix the issue...
> 
> 
> Takashi
> 
> > 
> > On Thu, 2009-07-16 at 12:20 -0700, John L. Utz III wrote:
> > 
> >     Debug the problem, write code that fixes it and then send in a patch.
> >     That's why this is the alsa *developers* mailing list.
> >     
> >     Ted T. Logan wrote:
> >     > Takashi, please, what must I do to get your xfi driver to stop clicking?
> >     > 
> >     > On Thu, 2009-07-16 at 11:22 +0200, Takashi Iwai wrote:
> >     > 
> >     >> At Wed, 15 Jul 2009 12:55:23 +0200,
> >     >> Frashman wrote:
> >     >>> Hi Takashi,
> >     >>>
> >     >>> first of all, thank you for developing this driver.
> >     >>> I tested it today. It works, so far.
> >     >>>
> >     >>> But two annoying things. As you mentioned, I got problems, if the 
> >     >>> onboard sound modules are loaded. Then i get no sound out auf my xfi.
> >     >> It's likely the collision of PCI device ID.
> >     >> Some X-Fi models support both HD-audio and emu20kx-native modes.  The
> >     >> modes are switched by some magical sequence.
> >     >>
> >     >> Anyway, please run alsa-info.sh with --no-upload option, and attach
> >     >> the generated file.
> >     >>
> >     >>> If I disable the loading of snd-hda-intel modules while booting, then it 
> >     >>> works.
> >     >>>
> >     >>> The second problem is, that SIDE and SURROUND connectors are 
> >     >>> interchanged. I'm absolutly sure, it works fine under windows and the 
> >     >>> connector colors are also correct.
> >     >>>
> >     >>> If I run speaker-test -c8 the SIDE Speakers sounds come out of my REAR 
> >     >>> (SURROUND) Speakers, while nothing is coming out of my rear speakers, if 
> >     >>> i'm using speaker-test -c6
> >     >> So, the side channels (channel 7 & 8) and the rear channels (3 & 4)
> >     >> are swapped when running with 8 channel mode?
> >     >>
> >     >>
> >     >> Takashi
> >     >> _______________________________________________
> >     >> Alsa-devel mailing list
> >     >> Alsa-devel@alsa-project.org
> >     >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >     > _______________________________________________
> >     > Alsa-devel mailing list
> >     > Alsa-devel@alsa-project.org
> >     > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >     > 
> > 
> > 
