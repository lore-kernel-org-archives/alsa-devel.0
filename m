From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: Merging alsa-kernel-1.0.7 into kernel 2.6.9
Date: Fri, 19 Nov 2004 08:25:11 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B002A7F813@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > So, I'm attempting to merge the content of alsa-driver=20
> > 1.0.7 into the kernel source tree, and to build ALSA support
> > as non-modules.
>=20
> If the range of hardware you need to support is cmall enough=20
> it might be easier to start with the ALSA in your kernel
> tarball and forward port any driver fixes you need.

Unfortunately, this probably isn't an option for us. Whilst we're
targetting an embedded style userspace, we don't control the hardware,
and it can end up being basically any arbitrary PC right now. Thus, we
need good support for everything ALSA can give us!

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
