From: Joerg Mayer <jmayer@loplof.de>
Subject: Re: Alsa 0.9 and 2.4 kernel
Date: Mon, 16 Sep 2002 16:46:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020916164642.A19700@thot.informatik.uni-kl.de>
References: <20020916142553.Y19700@thot.informatik.uni-kl.de> <s5hy9a2ro7w.wl@alsa2.suse.de>
Reply-To: Joerg Mayer <jmayer@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy9a2ro7w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Joerg Mayer <jmayer@loplof.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 16, 2002 at 04:41:39PM +0200, Takashi Iwai wrote:
> > Are there any plans to send alsa 0.9 (or 1.0 or whatever) to Marcelo =
for
> > inclusion into the official 2.4 tree?
>=20
> i don't believe that alsa will be intergated into 2.4 line.
> this will bring too much diffs - the whole bunch of oss tree is
> moved, if we keep the consistent structure with 2.5.

I agree that oss must not be touched in 2.4, but I see no reason to
not include it (as an alternative to oss) in the official tree, especiall=
y
as the distribution vendors are adopting it already.

> all the current alsa-kernel codes are based on 2.5, and we provide
> additional wrappers for 2.4.  is there any problem in this regard?

I obviously wrote a different question than I intended to ask :-/
I was wondering about module names, nothing else.

> btw, there is an unofficial patch set for 2.4 to include the alsa.
> 	ftp://ftp.suse.com/pub/projects/alsa/2.4-patches=09

Thanks!

  Ciao
         J=F6rg
--
Joerg Mayer                                          <jmayer@loplof.de>
I found out that "pro" means "instead of" (as in proconsul). Now I know
what proactive means.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
