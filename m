From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: provide a device name list for applications
Date: Tue, 10 Oct 2006 20:23:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610102021110.9410@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0610101530410.9410@tm8103.perex-int.cz>
	<s5hodskm8t7.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610101948490.9410@tm8103.perex-int.cz>
	<s5h3b9wm4d6.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610102008420.9410@tm8103.perex-int.cz>
	<s5hvemskp71.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2ABCF163
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Oct 2006 20:23:28 +0200 (MEST)
In-Reply-To: <s5hvemskp71.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Oct 2006, Takashi Iwai wrote:

> At Tue, 10 Oct 2006 20:14:06 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Tue, 10 Oct 2006, Takashi Iwai wrote:
> > 
> > > At Tue, 10 Oct 2006 19:59:09 +0200 (CEST),
> > > Jaroslav Kysela wrote:
> > > > 
> > > > On Tue, 10 Oct 2006, Takashi Iwai wrote:
> > > > 
> > > > > At Tue, 10 Oct 2006 15:45:54 +0200 (CEST),
> > > > > Jaroslav Kysela wrote:
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > 	here is my proposal to provide (a long waited feature) a device 
> > > > > > name list for applications (especially for GUI). The work is not finished, 
> > > > > > but the patch bellow gives already useful hints like (for PCM devices):
> > > > > > 
> > > > > > hw:CARD=Intel,DEV=0
> > > > > > hw:CARD=Intel,DEV=1
> > > > > > hw:CARD=Intel,DEV=2
> > > > > > hw:CARD=Intel,DEV=6
> > > > > > plughw:CARD=Intel,DEV=0
> > > > > > plughw:CARD=Intel,DEV=1
> > > > > > plughw:CARD=Intel,DEV=2
> > > > > > plughw:CARD=Intel,DEV=6
> > > > > > plug
> > > > > > shm
> > > > > > tee
> > > > > > file
> > > > > > null
> > > > > 
> > > > > Hm...  I don't think it's a good idea to pass the device like
> > > > > "hw:xxx"  to applications.  The hw access doesn't work for most of
> > > > > apps except for a special one like JACK.  Even plughw isn't enough,
> > > > > e.g. for SPDIF access.
> > > > > 
> > > > > In other words, it's rather harmful to pass all available configs.
> > > > > The apps need only limited configs that they can use safely,
> > > > > preferably with a certain description text for each.
> > > > > 
> > > > > I think we'd need some flags to indicate "this config is OK for
> > > > > enumeration".  For example, add 'export' option in each exported
> > > > > config definition together with 'description "xxxx"' 
> > > > > (or 'export "xxxx"' indicates that it's exported with a description
> > > > > xxxx).  For the hardware devices, we can retrieve the information from
> > > > > the driver.  For a virtual device, the description should be given
> > > > > manually.
> > > > 
> > > > Yes, the policies should be discussed. I already proposed to have 
> > > > a "disable hint" tag in the configuration files, so we can avoid
> > > > to put specific definitions to the hint list.
> > > > 
> > > > But the major idea is to provide list of all device definitions including 
> > > > user specific ones by default.
> > > 
> > > Well, my opinion is that providing "all" devices is wrong.  Instead, 
> > > only approved devices should be listed.
> > > 
> > > For example, what would be a merit to list "hw:x", "plughw:x" and
> > > "default:x" (this can be renamed) at the same time?  When multiple
> > > items appear on a list, user shall choose wrong ones in a pretty high
> > > probability according to Murphy's law.
> > 
> > I am not against to disable the hw: and plughw: listing, but my opinion is 
> > if user adds an extra configuration to ~/.asoundrc, it might be expected 
> > to use (and see) this configuration.
> 
> The user configs can appear when a proper (export) tag and description
> are set.  The non-tagged configs can be still used by passing the
> config name explicitly.

Sure, but it can apply to my proposal as well (users can disable listing 
explicitly). I see the benefit that users will see their PCM definitions 
without any change in ~/.asoundrc.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
