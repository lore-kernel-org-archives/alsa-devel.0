From: Konstantin Kletschke <lists@ku-gbr.de>
Subject: Re: A: VIA Technologies Inc. VT1720/24
Date: Mon, 29 Jan 2007 16:30:12 +0100
Message-ID: <20070129153011.GA2831@synertronixx3>
References: <45AFE785.6020307@informatik.uni-oldenburg.de>
	<45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de>
	<s5hac08cvct.wl%tiwai@suse.de>
	<20070125101319.GA3340@titan.lahn.de>
	<s5hd553bbfs.wl%tiwai@suse.de>
	<20070126202950.GA5721@titan.lahn.de>
	<s5hbqkhq4i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hbqkhq4i6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I am here *wink* :-)

Am 2007-01-29 15:41 +0100 schrieb Takashi Iwai:

> But the patch for Prodigy 7.1 Hifi is still pending since another
> deveopment by Konstantin is ongoing, too.  Could you both of you
> cooperate to make more solid support for that hardware?

Well, I strongly recommend. As I asked before, I am still wondering
how the initial patch works on Philipps Computer. 

While the wm8776 is implementend as a SPI device in aureon.c (and used
this way in the Prodigy 7.1 Hifi driver in aureon.c here) I use it in
i2c mode with success. What still missing is spi read/write stuff for
the wm8766 I am currently working on. Also there is a cs8415a in i2c
mode connected, whereas aureon.c expects it in SPI mode currently. 

Due to that essential differences I started a (quite good working!)
skeleton based on a Hercules fortissmo4 approach I discovered in
bugtrack.alsa-project.org. There I went into a prodigy hifi thread 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2384
and put in my prodigy_hifi.c (which envolved meanwhile) for discussion.

> Of course, I can take one of your patches as a prototype, and make
> it

I really wonder how/if Philipps stuff works. It gives a working card,
but (as I expected) the main volume mixers are not working. All
essential chips known to be connected in SPI mode need to be
initialized to speak i2c on this board.

> merged to the standard tree as a start up.  Anyway, I'd like hear the
> opinions from both of you at first.

May be Philps patch needs only slight work, my approach of a
completely additional file prodigy_hifi.c might be most probably work
of greenhorn in hacking alsa device drivers, so I am here for
discussion. At the moment I am trying to get hands onto the wm8766
chip, which needs proper SPI functions. I can nowhere adopt existing
ones as far as I can see.

Kind Regards, Konstantin Kletschke

PS.: Takashi, the mail you are replying to, has this gone to this ml
or to you directly?


-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
