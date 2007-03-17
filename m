From: Andreas Happe <andy@starseeders.net>
Subject: Re: [i8x0] docking station audio-out ceased to work
Date: Sat, 17 Mar 2007 13:03:49 +0100
Message-ID: <1174133029.3644.4.camel@localhost>
References: <1173864879.3425.4.camel@localhost>
	<s5hd53a62t8.wl%tiwai@suse.de> <1173975739.3467.1.camel@localhost>
	<s5habydwfnj.wl%tiwai@suse.de>
Reply-To: andreashappe@snikt.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5habydwfnj.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-03-16 at 13:12 +0100, Takashi Iwai wrote:
> At Thu, 15 Mar 2007 17:22:19 +0100,
> Andreas Happe wrote:
> > Well it worked for me (tm) as long as I didn't change normal and docking
> > station line-out while running. I will test older kernels, maybe there
> > are some clues in the debug output (as i boot windows from time to times
> > it could also be that the windows driver did setup some registers, we'll
> > see).
> 
> Oh, I didn't know that it worked one.  OK, that's a good news.
> Let me know if you find anything.

I tried some earlier kernel, but haven't gotten any positive results
yet. The task is made harder as I didn't use the docking station in the
last weeks. Has anything changed with alsa-lib?

The docking station out was working, albeit way to loud. Changing the
Intel ICH6 SigmaTel STAC9750,51 IEC958 Playback AC97-SPSA tristate
control from full to anything other muted the output.

cheers,
Andreas


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
