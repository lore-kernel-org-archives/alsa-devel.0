From: Miha Tomsic <miha.tomsic@guest.arnes.si>
Subject: Re: Problem with alsamixer, amixer
Date: 10 Oct 2002 17:34:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034264077.525.251.camel@josef>
References: <1034262491.1337.230.camel@josef>
	<s5hzntmcof8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzntmcof8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

	Hello Takashi!

On =E8et, 2002-10-10 at 17:18, Takashi Iwai wrote:
> can you change each one switch or volume value by the follwoing way?
> - call "alsactl -f foo store"
> - modify the file "foo"
> - call "alsactl -f foo restore"
> if it works, then the problem is alsamixer or alsa-lib.
> the latest alsamixer can handle playback and capture separately, so
> this problem should have been fixed.

Yes, this works too. Only the simple controls (or simple mixer elements)
don't work correctly.

And I forgot to mention that I am using alsa-*-0.9.0rc3.

Should I get the CVS version? Is the new CVS compatible with rc3? I am
not following the discussions too closely, but will it break rc3 native
ALSA apps? I've seen that there are patches for jack to make it work
with new CVS alsa.

Is rc4 comming any time soon?

Thanks and take care,

	Miha...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
