From: Daniel Jacobowitz <drow@false.org>
Subject: Re: Surround sound and volume control question
Date: Mon, 9 Oct 2006 09:45:39 -0400
Message-ID: <20061009134539.GA13343@nevyn.them.org>
References: <20061008222726.GA23855@nevyn.them.org>
	<s5hiritr4nm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hiritr4nm.wl%tiwai@suse.de>
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

On Mon, Oct 09, 2006 at 03:37:49PM +0200, Takashi Iwai wrote:
> At Sun, 8 Oct 2006 18:27:26 -0400,
> Daniel Jacobowitz wrote:
> > 
> > How is volume control supposed to work for surround sound codecs?  Is there
> > typically a register which affects every channel, or do you have to adjust
> > them separately?  I've been staring at the datasheets and prodding the
> > registers for mine (ICE1724, on a Shuttle SN25P).  There's three pieces:
> > the vt1720, the vt1617a, and a wm8728.  The vt1617a has ac97 volume control
> > registers, but the "master" volume doesn't affect the center/lfe or rear
> > surround channels.  I am guessing that the wm8728 is just for the last two
> > channels (I've got jacks for 7.1 but the vt1617a only does 5.1).
> 
> That's the standard behavior of AC97 codec.  The "master" doesn't
> influence on surrounds.  Some ac97 codec chips have an extended mode
> that behaves differently, though.

I assume this one doesn't.  But could you tell me one supported card
which does, so that I can compare?  Thanks.

> alsactl save & restore should work for softvol.
> The softvol mixer element doesn't exist only at the very fresh state.

I see, I just tried it and alsactl will create a user control just
fine.  That's great.

I will give the softvol solution a try, and post the patches if it
works.

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
