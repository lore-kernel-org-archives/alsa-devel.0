From: Christian Esken <c.esken@cityweb.de>
Subject: More Questions about control names.
Date: Tue, 15 Jul 2003 00:43:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307150043.26390.c.esken@cityweb.de>
References: <1057195497.6307.55.camel@deimos> <s5hy8zferf8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8zferf8.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 03 July 2003 14:16, Takashi Iwai wrote:
> At 02 Jul 2003 21:24:57 -0400,
>
> Manuel Jander wrote:
> > Hello,
> >
> > I wrote support for the Hardware Equalizer (10 band stereo = 20
> > controls) for the Aureal Vortex cards. For testing purposes i used the
> > controls as "MIXER" type controls, so they are visible from any mixer.
> > The question: How should they be named ? Is the type "MIXER" acceptable
> > ? In my opinion it is at least pretty convenient.
>
> MXIER should be fine.
>
> the name is still an open question, but it's not strict at all.

I think this is true for all control names, isn't it. At least I have not 
found a naming scheme (just tell me if I have missed the corresponding docs). 
I actually would prefer if it would be more strict. Or to have a method to 
know what the function of the control is.
I find it very hard to write a generic mixer application without knowing the 
function of the control. If I knew the functions, I could do better grouping 
in kmix. Currenty the controls/sliders are just sorted by ID, which sometimes 
is not-so-userfriendly.

Chris


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
