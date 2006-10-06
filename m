From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 0/5] ASoC codecs
Date: Fri, 06 Oct 2006 16:47:30 +0100
Message-ID: <1160149650.16898.36.camel@localhost.localdomain>
References: <1159805715.2382.108.camel@localhost.localdomain>
	<s5hy7rwht29.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7rwht29.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-10-04 at 19:47 +0200, Takashi Iwai wrote:
> At Mon, 02 Oct 2006 17:15:15 +0100,
> Liam Girdwood wrote:
> > 
> > This patch series will add initial ASoC codec support for the WM8731,
> > WM8750 and WM9712 codecs. It also adds support for AC97 codecs through a
> > generic AC97 codec driver (this connects any ASoC AC97 controller driver
> > to the std alsa ac97 codec driver). These codec drivers were chosen as
> > they are all working well and have good machine support (Zaurus).
> > 
> > The ak4535, uda1380, wm8753 and wm9713 ASoC codec drivers are all beta
> > quality atm and will hopefully be submitted soon, after some further
> > testing.
> 
> I got undefined soc_ac97_ops when I compile with your patches.
> A missing piece?
> 

It's shouldn't have been built (unless AC97 support was selected). I've
fixed this up in the codecs Kconfig and Makefile now (see new patch
5/5).

Liam


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
