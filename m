From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Tascam US-224/428 MMC: Work in progress...
Date: Wed, 28 Jul 2004 17:23:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407281723.39162.annabellesgarden@yahoo.de>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93> <s5h1xix5ygj.wl@alsa2.suse.de> <14675.195.245.190.93.1090939828.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <14675.195.245.190.93.1090939828.squirrel@195.245.190.93>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, ardour-dev <ardour-dev@lists.ardour.org>
List-Id: alsa-devel@alsa-project.org

Am Dienstag 27 Juli 2004 16:50 schrieb Rui Nuno Capela:
> Hi Takashi,
>
> >> That's me again, now with another iteration of a modified us428control.
> >> MMC support has been improved and transport LEDs is getting almost
> >> functional. Tascam control protocol sysex decoding is also complete
> >> (LEDs control mainly).
> >>
> >> As before, I'm only testing this on my US-224. US-428 owners should test
> >> and report is everything is to their taste. Work is in progress...
> >
> > Could you submit a patch instead of the whole tarball?
> > It'll make easier to review the changes you made.
>
> Sure. Here it goes. It even includes some last-minute updates since the
> last tarball. It's almost final :)
>
> Please note that the patch is being based on alsa-tools cvs tree, as of
> 2004-07-24.

works fine here during a first test with us428 @ latest ardour 0.9beta18.4:
Transport buttons and lights do as expected except the green PLAY light 
doesn't burn if I start playback from within ardour.
Position scrolling with wheel acts peculiar: first as expected, then after 
having stoped wheeling the cursor sort of repeats its last movement.
Didn't dig, so don't know who is to blame.

Fine stuff, thanks Rui!
Karsten

P.S.: patch is CVS ready from my point of view, functionality wise.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
