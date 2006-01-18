From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Moving snd-bt87x and btaudio to drivers/media
Date: Wed, 18 Jan 2006 15:51:21 -0200
Message-ID: <1137606681.28917.31.camel@localhost>
References: <1137590968.32449.46.camel@localhost>
	 <s5h8xtdtsej.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xtdtsej.wl%tiwai@suse.de>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>, alsa devel <alsa-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Johannes Stezenbach <js@linuxtv.org>, Linux and Kernel Video <video4linux-list@redhat.com>, Manu Abraham <abraham.manu@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Qua, 2006-01-18 =E0s 17:25 +0100, Takashi Iwai escreveu:
> At Wed, 18 Jan 2006 11:29:28 -0200,
> Mauro Carvalho Chehab wrote:
> >=20

> Which directory do you suppose exactly?  drivers/media/tv (or
> something like that), or existing one like drivers/media/video?
	Better is to be at the same dir as other bttv modules. Currently, it
wil be under drivers/media/video. It seems to me that drivers/media
should be better organized, since lots of shared code between dvb and
v4l are emerging. IMHO, it seems to be a good idea to create a newer dir
to handle chipsets like:
 /drivers/media/chips/
	and include bttv, cx88, em28xx, saa7134 and others as separate dirs
under /chips. This way, it would be easier to detect code duplications
and similarities.
>=20
> I personally have no big objection to move snd-bt87x location.
> although the external alsa-driver tarball would require a tune.
> It was there simply because the driver is basically independent from
> other layers but sound.
	True.
>   From the functionality viewpoint, it's better
> to gather all modules, of course.
>=20
> One point I'm conerned is, however, the order of objects in the
> built-in kernel.  Recently we had a problem of initializations of
> saa7134-alsa and sound core stuff.  We should be careful about that.
	I've waited to the end of 2.6.16 window to start these discussions to
give us some time to fix compilation order and to realign all necessary
stuff. I think we will have some time until 2.6.17 to prioritize sound
core loading as Linus suggested. There's no rush for such changes.
>=20
> Also, more intutive Kconfig would be nice to have.  For example, it'd
> be better to use a choice type for saa7134-alsa and -oss drivers.
> Also, to my eyes, it's better to select CONFIG_SND from saa7134-alsa
> instead of depending on it.
	Agreed. I have already a patch for it to use choice type. I'll work on
it to select CONFIG_SND and CONFIG_SND_PCM.
>=20
>=20
> Takashi
Cheers,=20
Mauro.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=3D=
121642
