From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot usb unplugging
Date: Fri, 15 Apr 2005 17:45:44 +0200 (CEST)
Message-ID: <20050415154544.40500.qmail@web26508.mail.ukl.yahoo.com>
References: <s5hr7hccbel.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7hccbel.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Clemens Ladisch <clemens@ladisch.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> schrieb:=20
> At Fri, 15 Apr 2005 17:14:40 +0200 (CEST),
> karsten wiese wrote:
> >=20
> >=20
> > --- Takashi Iwai <tiwai@suse.de> wrote:
> > > At Fri, 15 Apr 2005 16:28:54 +0200 (CEST),
> > > karsten wiese wrote:
> > > >=20
> > > >=20
> > > > --- Takashi Iwai <tiwai@suse.de> wrote:
> > > > > At Fri, 15 Apr 2005 15:59:25 +0200 (CEST),
> > > > > karsten wiese wrote:
> > > > > >=20
> > > > > >=20
> > > > > > --- Lee Revell <rlrevell@joe-job.com> wrote:
> > > > > > > On Thu, 2005-04-14 at 20:59 +0200, karsten
> wiese
> > > > > wrote:
> > > > > > > > Hi Clemens & Takashi
> > > > > > > >=20
> > > > > > > > Please commit the patch.
> > > > > > >=20
> > > > > > > Is the ALSA in kernel 2.6.11 affected?  If
> so,
> > > this
> > > > > >=20
> > > > > > Think so, yes. The keyboard dead effect +
> described
> > > > > oops
> > > > > > has been around for quiet a long time.
> > > > > > (There is a lkml mail from yesterday about an
> > > > > usb-cellphone
> > > > > > setup,
> > > > > > where the same oops + dead keyboard happens
> also:
> > > > > >
> > > > >
> > > >
> > >
> >
>
http://marc.theaimsgroup.com/?i=3D<20050414230621.49663f75.vsu%20()%20alt=
linux%20!%20ru>
> > > > > > )
> > > > > > There is also an alsa-bug with snd-usb-audio in
> the
> > > > > > bugbase.
> > > > > > Clemens seams not to be convinced about this
> > > aproach
> > > > > yet.
> > > > > > maybe 'cause the comment of
> snd_card_free_in_thread
> > > > > > explicitly states that its the one to be called
> for
> > > > > > hotplug:
> > > > > > /**
> > > > > >  *  snd_card_free_in_thread - call
> snd_card_free()
> > > in
> > > > > > thread
> > > > > >  *  @card: soundcard structure
> > > > > >  *
> > > > > >  *  This function schedules the call of
> > > snd_card_free()
> > > > > > function in a
> > > > > >  *  work queue.  When all devices are released
> > > > > (non-busy),
> > > > > > the work
> > > > > >  *  is woken up and calls snd_card_free().
> > > > > >  *
> > > > > >  *  When a card can be disconnected at any time
> by
> > > > > hotplug
> > > > > > service,
> > > > > >  *  this function should be used in disconnect
> (or
> > > > > detach)
> > > > > > callback
> > > > > >  *  instead of calling snd_card_free()
> directly.
> > > > > >  * =20
> > > > > >  *  Returns - zero otherwise a negative error
> code
> > > if
> > > > > the
> > > > > > start of thread failed.
> > > > > >  */
> > > > > >=20
> > > > > > Also I remember , that snd_card_free didn't
> work ok
> > > > > when i
> > > > > > used it in the first implementations of
> > > usx2y-module
> > > > > some 2
> > > > > > years ago.
> > > > > > but that was on kernel 2.4.something.......
> > > > > > maybe above comment is from kernel 2.4 also and
> the
> > > > > hotplug
> > > > > > system has changed ? anybody?
> > > > >=20
> > > > > Might be.  To be sure, check whether the release
> fops
> > > is
> > > > > called
> > > > > properly before you calling snd_card_free().
> > > >=20
> > > > You mean snd_card_disconnect()?
> > > > That's called with the same argument and before
> > > > snd_card_free().
> > >=20
> > > No, I mean snd_card_free(), which you changed from
> > > snd_card_free_in_thread().  Someone has to release
> the
> > > files
> > > (i.e. call release fops eventually) before clean up
> > > everything via
> > > snd_card_free().
> > >=20
> > Erm, you mean the close (for
> > snd_pcm_ops_t,snd_rawmidi_ops_t) and release (for
> > snd_hwdep_ops_t) callbacks then?
>=20
> I meant the "file operations".  Anyway, the callback of
> PCM or rawmidi
> will be called from the release callback of fops,
> though...
>=20
> >  They should all be called
> > before snd_card_free()?
>=20
> Yes.
>=20
> > in other words:
> > <snip>
> > int snd_card_free_in_thread(snd_card_t * card)
> > {
> > 	if (card->files =3D=3D NULL) {
> > 		snd_card_free(card);
> > 		return 0;
> > 	}
> > </snip>
> > the "(card->files =3D=3D NULL)" MUST be true before
> > snd_card_free() can be called safely?
>=20
> Yes, exactly.
> Otherwise, snd_card_free() removes the device entry, and
> the remainig
> files will have no way to release themselves after that.

Just found that snd_card_free() also waits for all files
being released:
<snip>
int snd_card_free(snd_card_t * card)
{
	struct snd_shutdown_f_ops *s_f_ops;

	if (card =3D=3D NULL)
		return -EINVAL;
	write_lock(&snd_card_rwlock);
	snd_cards[card->number] =3D NULL;
	write_unlock(&snd_card_rwlock);

#ifdef CONFIG_PM
	wake_up(&card->power_sleep);
#ifdef CONFIG_SND_GENERIC_PM
	if (card->pm_dev) {
		snd_generic_device_unregister(card->pm_dev);
		card->pm_dev =3D NULL;
	}
#endif
#endif

	/* wait, until all devices are ready for the free
operation */
	wait_event(card->shutdown_sleep, card->files =3D=3D NULL);
</snip>

(-: You apply my patch now?
It really works here better than before.
If you still doubt my patch is correct:
Please line out a testcase, where a bug might happen, that
would not happen without the patch.
So far I tested jackd and "arecord | aplay" ok with
unplugging the usb cable, switching of usx2y and "rmmod
uhci_hcd". several times. no oops. without the patch the
oops came every 3rd test or so.

Karsten


=09

=09
	=09
___________________________________________________________=20
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anme=
lden: http://mail.yahoo.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
