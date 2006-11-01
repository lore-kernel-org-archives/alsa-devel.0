From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: [PATCH 0/6] Alsa support for Maemo SDK (n770)
Date: Wed, 1 Nov 2006 13:06:00 -0400
Message-ID: <a0580c510611010906s50f666c7sd770b2786f2b880d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.192])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 96D052CE
	for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2006 18:06:01 +0100 (MET)
Received: by nz-out-0102.google.com with SMTP id i28so1710298nzi
	for <alsa-devel@alsa-project.org>; Wed, 01 Nov 2006 09:06:00 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, mikko.a.leppanen@nokia.com
List-Id: alsa-devel@alsa-project.org

Hello all,

   This patch series will add alsa support for Maemo SDK (nokia 770).
This is an alsa plugin and the patch series is against
alsa-plugins-1.0.13rc2 source code.

   The plugin adds alsa support by communicating with n770's audio system.

   To add ALSA support, an EXT PCM I/O plugin and EXT CTL plugin were
written. The code is based on SDK documentation from the alsa-project
site.

   There are basically three .c files:
dsp-protocol.c: Protocol to communicate with n770 audio system.
alsa-dsp.c: An External PCM I/O plugin
dsp-ctl.c: An External Control plugin

   Here is the total diffstat:
 Makefile.am          |    2
 configure.in         |   10
 doc/README-maemo     |  183 +++++++
 maemo/Makefile.am    |   15
 maemo/alsa-dsp.c     |  772 +++++++++++++++++++++++++++++++
 maemo/constants.h    |  199 ++++++++
 maemo/debug.h        |   52 ++
 maemo/dsp-ctl.c      |  641 ++++++++++++++++++++++++++
 maemo/dsp-protocol.c | 1246 +++++++++++++++++++++++++++++++++++++++++++++++++++
 maemo/dsp-protocol.h |   88 +++
 maemo/list.h         |  244 +++++++++
 maemo/reporting.h    |  241 +++++++++
 maemo/types.h        |  126 +++++
 13 files changed, 3818 insertions(+), 1 deletion(-)

-- 
Eduardo Bezerra Valentin

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
