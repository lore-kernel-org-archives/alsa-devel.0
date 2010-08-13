From: John Simpson <john@swajime.com>
Subject: n810 diablo and alsa ?
Date: Fri, 13 Aug 2010 14:14:46 -0500
Message-ID: <AANLkTimX+DVR0y5Qurii9ELxx3g0YGb0RvrBvgi4StB4@mail.gmail.com>
Reply-To: john@swajime.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FFBB1038C8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:14:47 +0200 (CEST)
Received: by eyd9 with SMTP id 9so493227eyd.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 12:14:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there a how-to for installing the alsa-lib correctly on the n810?
(hopefully from a fresh install of Maemo/Diablo?)

I've been hitting brick walls in every direction. :-(

The alsa-lib in the diablo repository seems to be outdated:

 [1|user@tablet|~/src]cat alsa-lib_1.0.14sa-2maemo2.dsc
 Format: 1.0
 Source: alsa-lib
 Version: 1.0.14sa-2maemo2
 Binary: lib32asound2-dev, lib64asound2, lib32asound2, libasound2-dev,
libasound2, libasound2-doc, libasound2-dbg, lib64asound2-dev
 Maintainer: Debian ALSA Maintainers <pkg-alsa-devel@lists.alioth.debian.org>
 Architecture: any
 Standards-Version: 3.7.2
 Build-Depends: debhelper (>= 4.2.32), quilt (>= 0.40), autotools-dev,
doxygen, libc6-dev-powerpc [ppc64], libc6-dev-i386 [amd64],
libc6-dev-ppc64 [powerpc], libc6-dev-s390x [s390], libc6-dev-sparc64
[sparc], lib32gcc1 [amd64 ppc64], libc6-dev (>= 2.5) [armel]
 Vcs-Browser: http://svn.debian.org/wsvn/pkg-alsa/trunk/alsa-lib/
 Uploaders: Jordi Mallach <jordi@debian.org>, Mikael Magnusson
<mikma@users.sourceforge.net>, Elimar Riesebieter <riesebie@lxtec.de>,
Marc-Andre Lureau <marc-andre.lureau@nokia.com>
 Vcs-Svn: svn://svn.debian.org/pkg-alsa/trunk/alsa-lib
