From: Szekeres =?iso-8859-2?Q?Istv=E1n?= <szekeres@iii.hu>
Subject: Re: USB headset problem
Date: Mon, 17 Oct 2005 14:40:12 +0200
Message-ID: <20051017124011.GA16144@pulsussoft.hu>
References: <20051014091716.GA30524@pulsussoft.hu> <Pine.HPX.4.33n.0510141250040.23443-100000@studcom.urz.uni-halle.de> <20051014202153.GA1428@pulsussoft.hu> <20051014220539.GA1818@pulsussoft.hu> <s5hll0szbdp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hll0szbdp.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > On Fri, Oct 14, 2005 at 10:21:53PM +0200, Szekeres Istv=E1n wrote:
> > > Indeed. The microphone is really working. Now the only problem is t=
hat I
> > > tried it under skype (that's why I bought the headset), and under s=
kype it
> > > is not working at all (strace revealed that skype is writing 0s to =
the sound
> > > device) - so I'm afraid this problem is out of the scope of this ma=
iling
> > > list.
> >=20
> > Ok, after some experimenting the results are the following:
> >=20
> > - Using latest git version of the kernel -> skype is not working
> > - Using 2.6.12.5 -> skype is working
> > - Other apps are working in both versions.
> >=20
> > How can I investigate why does not skype working in case of the git v=
ersion?
>=20
> It's important to know whether it's a problem of usb-audio or the OSS
> emulation.
>=20
> First, you can try aoss wrapper for the user-space OSS emulation.

I already tried aoss, the result is a big fat SIGSEGV.

Best regards,
Szekeres Istvan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
