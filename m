From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: pcm_multi broken in alsa-lib - no duplex mode
	with	jackd
Date: Thu, 8 Mar 2007 21:51:28 +0000
Message-ID: <20070308215128.GA3349@localhost.localdomain>
References: <45F044D2.1060903@mnet-online.de> <s5hslcfmuk0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hslcfmuk0.wl%tiwai@suse.de>
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

On Thu, Mar 08, 2007 at 07:58:23PM +0100, Takashi Iwai wrote:
> At Thu, 08 Mar 2007 18:16:02 +0100,
> Simon Lewis wrote:
> > Many JACK users have successfully used the following patch:
> > 
> > http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch
> 
> Well, the patch is no real fix.  It's likely a workaround for JACK,
> though.  Someone has to take time to track down this bug more deeply.

True, the patch is just a workaround for JACK. However, I would
argue that most users of pcm_multi are probably JACK users.
Surely adding code that breaks something for the majority of users (no
matter how correct that code is in isolation) is not a good thing.

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
