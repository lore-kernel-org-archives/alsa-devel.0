From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Mon, 10 Mar 2003 16:34:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030310153412.GB26166@ulima.unil.ch>
References: <20030308144119.GB29709@ulima.unil.ch> <3E6A2856.1040602@cucumelo.org> <20030308175244.GA32168@ulima.unil.ch> <s5hu1eb471j.wl@alsa2.suse.de> <20030310144608.GB14537@ulima.unil.ch> <s5hsmtv46kv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hsmtv46kv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 10, 2003 at 03:52:32PM +0100, Takashi Iwai wrote:

> ah, now got the point.
>=20
> surround51 pcm is for ANALOG 5.1 output.  and it's NOT supported on
> cs46xx yet.

Well, I don't need any analog 5.1, all I want is the SPDIF...

> the easiest way to check is to use ac3dec in alsa-utils.
> run with -C option for AC3-passthru mode.

Great, I should do it tonight at home :-)

Thank you very much, I did try with ac3play without success, let's see
if it would play better with ac3play...

And do you know what I should do to play files with mplayer?

And why I can't use a plugin with VDR
http://prdownloads.sourceforge.net/sourceforge/bitstreamout/
I get:

Mar  8 15:31:16 localhost vdr[6790]: S/P-DIF: Period size not available: =
Invalid argument
Mar  8 15:31:16 localhost vdr[6790]: S/P-DIF: unable to establish BitStre=
amOut for none audio PCM
Mar  8 15:31:16 localhost vdr[6790]: INSTREAM: can't open spdif interface

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
