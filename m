From: mark@undertone.org
Subject: Re: testers for SB Extigy wanted
Date: Fri, 11 Oct 2002 13:00:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021011180023.GA32632@undertone.org>
References: <s5hlm55ciee.wl@alsa2.suse.de> <20021011141312.GA31835@undertone.org> <s5hbs61cazj.wl@alsa2.suse.de> <20021011143659.GA31907@undertone.org> <s5h8z15c8uq.wl@alsa2.suse.de> <20021011153411.GA32132@undertone.org> <s5h7kgpc6bi.wl@alsa2.suse.de> <s5h65w9c55m.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65w9c55m.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 11, 2002 at 06:27:17PM +0200, Takashi Iwai wrote:
> At Fri, 11 Oct 2002 18:02:09 +0200,
> I wrote:
> > 
> > hmm, could you run "alsactl store" and show the generated
> > /etc/asound.state (only for the second card is enough)?
> > at least we can see whether the controls are parsed properly.
> 
> also, please check the kernel message after running the commands
> above.  do any messages like "cannot get min/max..." appear?
> 
> please update the cvs tree before trying again.
> i changed the code so that more PCM formats become available.

Updated the tree, recompiled, same message:

atrophy:/usr/local/src/alsa# alsactl store
alsactl: get_control:194: Cannot read control '2,0,0,Digital In Playback Source,0': Invalid argument


No logs in any syslog facilities are generated.

-mark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
