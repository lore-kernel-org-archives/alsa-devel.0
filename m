From: Mark Hubbard <mark@egghead.free-online.co.uk>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Fri, 14 Nov 2003 15:11:22 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311141511.22130.mark@egghead.free-online.co.uk>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <200311141401.13736.pwk.linuxfan@gmx.de> <s5hhe17jdcu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe17jdcu.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 14 Nov 2003 13:20, Takashi Iwai wrote:
> as a future plan, we'll define dmix as default for el-cheapo
> soundcards, but e.g. not for sb live, which supports such a function
> on hardware.

And what is your definition of an "el-cheapo" soundcard? :)

I object to this future plan as even users of consumer soundcards do not=20
necessarily want everything resampled to 48 KHz in software by default with=
=20
the inherent sound quality degradations.=20

> so far, we leave it as user's own configuration, simply because dmix
> had been under development and not quite stable.

=46rom the user's point of view, it is easier to build on the default setti=
ngs=20
than to deconstruct them in the asoundrc, thus, dmix should remain a=20
non-default pcm.=20

> well, there is still a problem that the ALSA's configuration is not
> stream-wise.  a single definition is used for both playback and
> capture directions.  this should be improved in the future.



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
