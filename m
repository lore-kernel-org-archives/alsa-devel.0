From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: digital fx support for cs4205
Date: Sat, 15 Feb 2003 16:04:13 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302151602490.1282-100000@pnote.perex-int.cz>
References: <20030212113747.GB4745@valsheda.taprogge.wh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030212113747.GB4745@valsheda.taprogge.wh>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jens Taprogge <ln@idg.rwth-aachen.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Feb 2003, Jens Taprogge wrote:

> I sent this a while ago. Since I did not get any replies yet I am
> resending it.

It would be better to create mixer controls. It's bad to enable some cool 
feature without having possibility to disable it.

						Jaroslav

> On Sat, Feb 01, 2003 at 02:21:34AM +0100, Jens Taprogge wrote:
> > I read through the specs for the cs4205 and created a small patch to
> > enable the digital fx engine (bass, treble, 3d) for pcm output.
> > 
> > It would be possible to first digitize analog input (cd, speaker, etc.)
> > and run it through the fx engine as well. That would requiere changes to
> > mixer code though. (Would hva to use extra mixers that are not available
> > through the ac97 interface.)
> > 
> > Jens
> > 
> > ps: I am not subscribed to the list.
> > -- 

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
