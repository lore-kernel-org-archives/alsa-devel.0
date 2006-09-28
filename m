From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove()
Date: Thu, 28 Sep 2006 13:39:06 +0200 (CEST)
Message-ID: <20060928113906.20550.qmail@web26504.mail.ukl.yahoo.com>
References: <s5h4puspal8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4puspal8.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> schrieb:

> At Wed, 27 Sep 2006 21:27:51 +0200,
> Karsten Wiese wrote:
> > =

> > Hi
> > =

> > This patch helps prevent an oops on 2.6.18-rt3,
> > when my usb usx2y soundcard disconnects.
> > Physically disconnects or "rmmod uhci_hc" both oops 1in7.
> > =

> > With this patch still no oops after > 1000 disconnects.
> > =

> > Please apply/comment.
> > =

> >       thanks,
> >       Karsten
> > =

> > =3D=3D=3D
> > =

> > Reset file->f_op in snd_card_file_remove()
> > =

> > When passing here in response to an usb disconnect,
> > file->f_op has been replaced with a kmalloc()ed version,
> > that would only allow releases.
> > =

> > It will be free()ed later on in snd_card_free().
> > Here it happened sometimes, that the free()ed, not NULLed file->f_op
> > caused an oops in module_put() called by fops_put() still later on.
> > =

> > Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
> =

> snd_card_file_remove() is not a right place to do that, IMO.
> =

you are right, patch is wrong: it causes snd_hwdep's use count corruption.

> Could you check whether this problem still happens on post-2.6.18?
> There are a lot of fixes in this area after 2.6.18.
> =

i'm now running 2.6.18-rt3 + alsa-driver-1.0.13rc1 and problem seams to be =
gone.

      Karsten


	=


	=

		=

___________________________________________________________ =

Der fr=FChe Vogel f=E4ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail=
: http://mail.yahoo.de

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
