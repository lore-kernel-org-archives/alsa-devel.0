From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib: snd_device_name_hint() function
Date: Wed, 11 Oct 2006 16:28:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610111624210.8848@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0610111323470.8848@tm8103.perex-int.cz>
	<20061011130347.GB3038@palantir8> <s5h7iz7klvb.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610111553430.8848@tm8103.perex-int.cz>
	<s5h3b9vkk8b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6DE8C172
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Oct 2006 16:28:50 +0200 (MEST)
In-Reply-To: <s5h3b9vkk8b.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Martin Habets <errandir_news@mph.eclipse.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Oct 2006, Takashi Iwai wrote:

> At Wed, 11 Oct 2006 15:54:53 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Wed, 11 Oct 2006, Takashi Iwai wrote:
> > 
> > > At Wed, 11 Oct 2006 14:03:48 +0100,
> > > Martin Habets wrote:
> > > > 
> > > > Jaroslav, Takashi,
> > > > 
> > > > I'd rather err on being more vebose here. While it is true displaying
> > > > all of them increases the chance of (mostly newbies) picking the wrong
> > > > device, but it also avoids people claiming they do not have those devices.
> > > 
> > > Please don't jump to conclusion yet.  Whether the default is on or off
> > > is no big deal, indeed.  We could add a global option to make the
> > > default on or not, for example.
> > > 
> > > The problem is that we're seeing two different things.
> > > 
> > > 1. List all devices that are available
> > > 
> > >   The list contains every single device defined in the config space.
> > > You can pick it up and open it but don't know whether it works and
> > > what is for.  It's suitable for tools like aplay that accepts all
> > > configs, but can be confusing for GUI programs.
> > > 
> > > 2. List devices that are predefined
> > > 
> > >   The list contains only devices that are tagged as usable and have
> > > proper descriptions.  It's suitable for GUI programs, but some
> > > user-defined definitions or functions may be missing unless you set it
> > > right.
> > > 
> > > So, both are designed for different purposes.  The current design
> > > doesn't look sufficient for the latter purpose.  For example, below is
> > > the output of aplay -L on my machine.  If this appears on a selection
> > > list of a GUI program, you would have no clue what to choose.
> > 
> > I don't think that most of GUI users will have defined own device names in 
> > ~/.asoundrc. So let's concentrate on the standard device list in alsa-lib.
> 
> But we shouldn't forget this at all.  The question still remains
> whether _that_ API should list the entries without descrpition.
> 
> Let's get things straight:
> 
> - the list-all API is OK to include the entries without descriptions
> - the list-approval API should list only entreis with descriptions
> 
> And, it also makes sense that the former lists detailed system configs
> like hw, plughw, etc, since these can be also used by apps.  But, it
> doesn't for the latter.
> 
> Now you implemented a certain level of list-approval style, but it's
> mixed up in a half way.

I'm sorry, but I don't agree. There is "disable" (aka 'hint 0') line for 
hw and plughw, so the style is clear. You have to disable valid device 
names manually rather than enable them manually.

Of course, the hint function checks if the device names are valid 
(configuration can be parsed).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
