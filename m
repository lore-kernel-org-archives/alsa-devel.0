From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: RE: More issues with hdsp and 1.0.7 and 1.0.8 drivers
Date: Fri, 14 Jan 2005 14:32:10 -0500
Message-ID: <20050114193044.NHXT13012.gx4.fuse.net@64BitBadass>
References: <s5h3bx48fe7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bx48fe7.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> At Thu, 13 Jan 2005 22:16:56 -0500,
> Ivica Ico Bukvic wrote:
> >
> > 1.0.8 driver install completely from scratch using sources has the
> following
> > problem:
> >
> > 1) hdsp card gets detected and everything goes fine until the firmware
> needs
> > to be loaded.
> > 2) at that point if I run hdsploader I get the following undocumented
> error:
> 
> You need no longer to call hdsploader.  The hdsp driver uses hotplug
> firmware loader if available.  So, installating firmware files to the
> proper directory would suffice.  (Note that the directory is different
> from the path for hdsploader.)
> 
> Did you install alsa-firmware 1.0.8, too?

I tried to and made no difference. For more info please see my other
e-mails. If the hotplug is supposed to do that, it certainly fails on my
system as I have to either explicitly tell it to do it or if the snd-hdsp is
being probed for the first time, I added the hdsploader to the "install"
clause so that it is triggered with modprobing of the snd-hdsp module...

Of course, this only works on the 1.0.7 driver as 1.0.8 fails with the
aforementioned error. Just to make things as clear as possible, when using
1.0.8 driver if I do not do anything, the firmware never gets loaded and the
red HOST light never turns off on the multiface suggesting that nothing got
to the card.

Best wishes,

Ico 

-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.300 / Virus Database: 265.6.11 - Release Date: 1/12/2005
 



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
