From: Martin Langer <martin-langer@gmx.de>
Subject: Re: RME Digi 96 Control
Date: Tue, 8 Apr 2003 23:34:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030408213439.GB510@tuba.home>
References: <200304041310.21272.rv@robertvetter.com> <s5hhe99q739.wl@alsa2.suse.de> <200304081854.41438.rv@robertvetter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200304081854.41438.rv@robertvetter.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Robert Vetter <rv@robertvetter.com>, tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 08, 2003 at 06:59:56PM +0200, Robert Vetter wrote:
> On Tuesday 08 April 2003 18:36, you wrote:
> > i'd love to put this stuff into alsa-tools tree once if the code
> > becomes stable.
> 
> That would be great.
> 
> > a few notes:
> >
> > - so far, i got an error when i start this problem without rme96
> >   card. it seems that the check of the existence of the rme96 driver is
> >   broken.  also, it would be better to check the return value of
> >   snd_ctl_elem_read(), etc.
> 
> This is a bug. I have to fix it.
> 
> > - usual doc files like README, COPYRIGHT?
> 
> ... would be nice, I know. When I find a free minute I'll do it.
> 
> > - auto-toolize?  (i can do it if necessary.)
> 
> What's the easiest way to make it? I have never done it before.
> 

Hi,

if someone needs a dirty hack of this code for his rme32 he can go to 
http://langerland.de/rme32/control.html and download rmedigiXXcontrol. It
should run with both cards rme96+rme32.

I just thought about an option which can handle more identical cards, but is
there really some need for such an option?

BTW: Thanks Takashi for that helpful fullduplex@rme32 discussion at Karlsruhe,
but I still need some time for trying out more complicated ways;-)


martin


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
