From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: USB fix (debian bug#100041)
Date: Wed, 12 Mar 2003 13:49:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303121348380.1434-100000@pnote.perex-int.cz>
References: <s5h3cls21r2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cls21r2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Pedro Lopez-Cabanillas <plcl@telefonica.net>, Jordi Mallach <jordi@debian.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Mar 2003, Takashi Iwai wrote:

> At Wed, 12 Mar 2003 10:54:26 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Wed, 12 Mar 2003, Clemens Ladisch wrote:
> > 
> > > > I know that using ALSA rawmidi API, there is a function to prevent this, doing
> > > > something like this:
> > > > 		snd_rawmidi_params_set_no_active_sensing(handle_out, params, 1);
> > > > But, how to do something like that for OSS programs? (without fixing the OSS
> > > > program itself, of course)
> > > 
> > > Neither OSS nor ALSA sequencer ports can change parameters of the
> > > underlying rawmidi port. Maybe there should be a module parameter for
> > > this.
> > 
> > Yes, if this behaviour causes troubles, we can specify the reset behaviour 
> > via a module parameter.
> > 
> > Perhaps, the best solution is to implement a control element which will
> > define the "reset" byte sequence when the rawmidi device is closed. Then
> > users might configure things themselves.
> 
> yes.  we can use IFACE_RAWMIDI for this control.
> in which layer the implementation should come?  in the rawmidi
> commonly?

Yes, it belongs to the midlevel code - alsa-kernel/code/rawmidi.c.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
