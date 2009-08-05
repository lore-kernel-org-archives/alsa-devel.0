From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver - POC for
 creative?
Date: Wed, 05 Aug 2009 13:17:31 -0500
Message-ID: <1249496251.4359.1.camel@localhost.localdomain>
References: <4A5DB59B.2010407@freenet.de> <s5hvdltnfrp.wl%tiwai@suse.de>
	<1247769012.20483.0.camel@localhost.localdomain>
	<4A5F7D6C.9020606@dmx.com>
	<1248017721.30034.2.camel@localhost.localdomain>
	<s5h3a8sll15.wl%tiwai@suse.de>
	<1248050339.11930.2.camel@localhost.localdomain>
	<s5hiqhnc3u8.wl%tiwai@suse.de>
	<1249464674.3459.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 6279B24567
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 20:17:13 +0200 (CEST)
Received: by yxe6 with SMTP id 6so345869yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 11:17:12 -0700 (PDT)
In-Reply-To: <1249464674.3459.0.camel@localhost.localdomain>
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
Cc: Frashman <frashman@freenet.de>, alsa-devel@alsa-project.org, "John L. Utz III" <jutz@dmx.com>
List-Id: alsa-devel@alsa-project.org

Takashi,

The latest snapshot has the same clicking/snapping.  Can you give me
your POC for creative?  I just cannot figure out why their driver works
fine and the alsa ones do not.
XFiDrv_Linux_Public_US_1.00.tar.gz


On Wed, 2009-08-05 at 04:31 -0500, Ted T. Logan wrote:

> I just CANNOT understand this.  I disabled usb and hda-intel, updated
> to latest snapshot.
> 
> with aplay, i get snaps every 1/2 second.  This blows my mind.
> 
> On Mon, 2009-07-20 at 07:37 +0200, Takashi Iwai wrote: 
> 
> > At Sun, 19 Jul 2009 19:38:59 -0500,
> > Ted T. Logan wrote:
> > > 
> > > Thanks.
> > > 
> > > Basically the driver from creative, the old one, works without clicks:
> > > 
> > > XFiDrv_Linux_US-1.18.tar.gz
> > > >From April, 2008
> > 
> > Where is it available?
> > 
> > > and this one works without clicks.
> > > 
> > > XFiDrv_Linux_Public_US_1.00.tar.gz
> > 
> > So, do both versions work on yours?
> > What are the differences between them?
> > 
> > > lspci lists it as:
> > > 03:03.0 Multimedia audio controller: Creative Labs SB X-Fi
> > > 
> > > and in xp, it uses the same x-fi drivers as the others.
> > > 
> > > I have never been able to get any driver you released to work with it.
> > > 
> > > Can you tell me the first driver you had that you recommend I test it with?
> > 
> > GIT is the easiest way.  For example, look at the page below:
> >    http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=history;f=sound/pci/ctxfi;h=91c958a7e171313fe68d728a3b4860287ad40aa7;hb=HEAD
> > 
> > 
> > Takashi
> > 
> > > On Sun, 2009-07-19 at 18:01 +0200, Takashi Iwai wrote:
> > > 
> > >     At Sun, 19 Jul 2009 10:35:21 -0500,
> > >     Ted T. Logan wrote:
> > >     > 
> > >     > Maybe you haven't been following the thread.  I've been trying to debug the
> > >     > problem.  As I mentioned to Takashi, there's not a point where it broke, it
> > >     > never worked with this driver.
> > >     > There have always been clicks.
> > >     > 
> > >     > However, it does not have clicks with the following driver:
> > >     > XFiDrv_Linux_Public_US_1.00.tar.gz
> > >     > 
> > >     > Sending out condescending messages like this after I was responding to the
> > >     > "testers wanted" mailer which said all cards should be supported now is
> > >     > completely unproductive.
> > >     
> > >     Well, the current situation is that I've got no other report but you
> > >     regarding the specific problem.  There is a known issue with openal,
> > >     accordingly, but not all apps.  So, this is very likely a different
> > >     issue.
> > >     
> > >     Actually, it's still the phase to gather all information to know which
> > >     part exactly is problematic.  If you find any other guys that have the
> > >     exact same problem, let me know.  It would make easier to find out a
> > >     problem pattern, either for finding out the culprit or reproducing the
> > >     problem.
> > >     
> > >     Or, you can do trial-and-error by comparing the driver above and the
> > >     current one (maybe the first committed version is easier to compare).
> > >     This can't be done without the real hardware, so it's actually up to
> > >     you how to fix the issue...
> > > 
> > >     Takashi
> > >     
> > >     > 
> > >     > On Thu, 2009-07-16 at 12:20 -0700, John L. Utz III wrote:
> > >     > 
> > >     >     Debug the problem, write code that fixes it and then send in a patch.
> > >     >     That's why this is the alsa *developers* mailing list.
> > >     >     
> > >     >     Ted T. Logan wrote:
> > >     >     > Takashi, please, what must I do to get your xfi driver to stop clicking?
> > >     >     > 
> > >     >     > On Thu, 2009-07-16 at 11:22 +0200, Takashi Iwai wrote:
> > >     >     > 
> > >     >     >> At Wed, 15 Jul 2009 12:55:23 +0200,
> > >     >     >> Frashman wrote:
> > >     >     >>> Hi Takashi,
> > >     >     >>>
> > >     >     >>> first of all, thank you for developing this driver.
> > >     >     >>> I tested it today. It works, so far.
> > >     >     >>>
> > >     >     >>> But two annoying things. As you mentioned, I got problems, if the 
> > >     >     >>> onboard sound modules are loaded. Then i get no sound out auf my xfi.
> > >     >     >> It's likely the collision of PCI device ID.
> > >     >     >> Some X-Fi models support both HD-audio and emu20kx-native modes.  The
> > >     >     >> modes are switched by some magical sequence.
> > >     >     >>
> > >     >     >> Anyway, please run alsa-info.sh with --no-upload option, and attach
> > >     >     >> the generated file.
> > >     >     >>
> > >     >     >>> If I disable the loading of snd-hda-intel modules while booting, then it 
> > >     >     >>> works.
> > >     >     >>>
> > >     >     >>> The second problem is, that SIDE and SURROUND connectors are 
> > >     >     >>> interchanged. I'm absolutly sure, it works fine under windows and the 
> > >     >     >>> connector colors are also correct.
> > >     >     >>>
> > >     >     >>> If I run speaker-test -c8 the SIDE Speakers sounds come out of my REAR 
> > >     >     >>> (SURROUND) Speakers, while nothing is coming out of my rear speakers, if 
> > >     >     >>> i'm using speaker-test -c6
> > >     >     >> So, the side channels (channel 7 & 8) and the rear channels (3 & 4)
> > >     >     >> are swapped when running with 8 channel mode?
> > >     >     >>
> > >     >     >>
> > >     >     >> Takashi
> > >     >     >> _______________________________________________
> > >     >     >> Alsa-devel mailing list
> > >     >     >> Alsa-devel@alsa-project.org
> > >     >     >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >     >     > _______________________________________________
> > >     >     > Alsa-devel mailing list
> > >     >     > Alsa-devel@alsa-project.org
> > >     >     > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >     >     > 
> > >     > 
> > >     > 
> > > 
> > > 
