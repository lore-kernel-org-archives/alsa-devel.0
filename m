From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] ALSA-Configuration.txt: snd-hda-intel: document model=basic
Date: Sat, 4 Mar 2006 16:00:57 +0100
Message-ID: <20060304150057.GZ9295@stusta.de>
References: <87wtfhx7rm.fsf@nurf.casa> <s5hzmkcsv38.wl%tiwai@suse.de> <87slq3x3w1.fsf@nurf.casa> <s5hu0ajrbxv.wl%tiwai@suse.de> <87fym3w7m3.fsf@nurf.casa> <s5h3bi2a26o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E6F151B0
	for <alsa-devel@alsa-project.org>; Sat,  4 Mar 2006 16:00:57 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5h3bi2a26o.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Otavio Salvador <otavio@debian.org>, linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 01, 2006 at 11:29:03AM +0100, Takashi Iwai wrote:
> At Tue, 28 Feb 2006 17:28:36 -0300,
> Otavio Salvador wrote:
> > 
> > Takashi Iwai <tiwai@suse.de> writes:
> > 
> > > At Tue, 28 Feb 2006 05:51:26 -0300,
> > > Otavio Salvador wrote:
> > >> 
> > >> > This kind of problem is likely due to a broken BIOS.  The current code
> > >> > parses the default pin configuration set up via BIOS while the older
> > >> > version used  the fixed pin assignment (depending on the codec chip,
> > >> > though).
> > >> > In most cases, it can be recovered by specifying a proper model module
> > >> > option.  See ALSA-Configuration.txt for details.
> > >> 
> > >> I wasn't able to do it.
> > >
> > > Didn't it worked?  Which module parameter did you use?
> > 
> > I tried model=hp, model=fujistsu and priority_fix={1,2}. Neither did
> > it work.
> 
> Try model=basic.  It's the old default.
> (seems that it's missing in the documentation...)

What about the patch below for 2.6.16?

> Takashi

cu
Adrian


<--  snip  -->


Document the model=basic option in the snd-hda-intel driver.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/Documentation/sound/alsa/ALSA-Configuration.txt.old	2006-03-04 15:52:50.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/Documentation/sound/alsa/ALSA-Configuration.txt	2006-03-04 15:57:10.000000000 +0100
@@ -705,6 +705,7 @@
 			$CONFIG_SND_DEBUG=y
 
 	ALC260
+	  basic		base mode
 	  hp		HP machines
 	  fujitsu	Fujitsu S7020
 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
