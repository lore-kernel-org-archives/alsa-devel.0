From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: ALSA HG repos
Date: Mon, 24 Apr 2006 14:07:04 +0200
Message-ID: <d9def9db0604240507p39b330craffc988e2179b762@mail.gmail.com>
References: <Pine.LNX.4.61.0604201437500.10174@tm8103.perex-int.cz>
	 <s5hwtdkbdap.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0604241121320.10174@tm8103.perex-int.cz>
	 <s5h8xpv443x.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0604241316310.9305@tm8103.perex-int.cz>
	 <s5h4q0j43n2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q0j43n2.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nice that you guys change over to hg!
We've been using hg for quite a few months now on linuxtv.org it's
quite comfortable and works very well.

Markus

On 4/24/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 24 Apr 2006 13:18:52 +0200 (CEST),
> Jaroslav Kysela wrote:
> >
> > On Mon, 24 Apr 2006, Takashi Iwai wrote:
> >
> > > > # cat stable-list
> > > > +4000                             # use alsa-kernel HG changeset 40=
00
> > > > +patches/4001.patch               # fixed HG changeset 4001 for sta=
ble tree
> > > > +kpatches/some-pnp-fix.patch      # not ALSA patch - pnp fix
> > > >
> > > > Comments?
> > >
> > > If we use such things, then better to stick with quilt.
> >
> > It will be overhead. I'd like to retreive most of patches directly from=
 HG
> > and do the on-the-fly conversion for GIT commits. I'm already working o=
n
> > this, so we can do some tests and decide later if it's the way to go.
>
> But why you keep the patch files instead of applying it to a tree?
> Just keeping two trees is more intuitive.
>
> In theory, the patch can be automatically applied to stable tree at
> each commit to devel tree if it includes a proper Patch-level tag.
> When the patch conflicts on stable tree, the system can notify the
> message to the committer and commit ML so that he (or someone else)
> can apply the corrected patch manually to the stable tree and
> occasionally sync/correct the devel tree, too.
>
>
> Takashi
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


--
Markus Rechberger


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
