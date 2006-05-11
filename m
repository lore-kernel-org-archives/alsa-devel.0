From: Lee Revell <rlrevell@joe-job.com>
Subject: SOLVED - was Re: [Alsa-user] VxPocket and hotplug - need help
 getting it working
Date: Wed, 10 May 2006 20:21:57 -0400
Message-ID: <1147306918.6535.53.camel@mindpipe>
References: <20060314110256.GA26047@stud.ntnu.no>
	 <20060314145233.GA14443@stud.ntnu.no> <1142357467.13256.135.camel@mindpipe>
	 <s5hbqw8kjq7.wl%tiwai@suse.de> <20060315140313.GA16222@stud.ntnu.no>
	 <s5hbqw7iyjh.wl%tiwai@suse.de>  <20060317083348.GC32182@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060317083348.GC32182@stud.ntnu.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Asbj=F8rn_S=E6b=F8?= <asbjs@stud.ntnu.no>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Resending due to lack of response...

On Fri, 2006-03-17 at 09:33 +0100, Asbj=F8rn S=E6b=F8 wrote:
> On Wed, Mar 15, 2006 at 03:16:02PM +0100, Takashi Iwai wrote:
> > At Wed, 15 Mar 2006 15:03:13 +0100,
> > [...]
>=20
> > > OK, I have installed DeMuDi 1.3.0rc1, which has kernel 2.6.14, and =
alsa=20
> > > version 1.0.10.
> >=20
> > Still way too old to debug...
>=20
> What is too old, the kernel, alsa or both?

We got this working at LAC.  Did not have time to methodically debug it
(we ended up changing several kernel config options) but I think the
critical one was to enable CONFIG_ISAPNP.

Is it an ALSA bug that the driver compiled but failed silently if this
was missing?

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
