From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: [PATCH] fix cmi8788 config (was: Re: [alsa-cvslog]
	alsa-lib: cmi8788: add alsa-lib config)
Date: Wed, 22 Aug 2007 13:08:18 +0200
Message-ID: <m2absjbzdp.fsf@vador.mandriva.com>
References: <ALOGGER1187770486.24@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from office.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 86A16103866
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 13:08:19 +0200 (CEST)
Received: from vador.mandriva.com (anakin.mandriva.com [192.168.100.54])
	by office.mandriva.com (Postfix) with ESMTP id 66AAF7F63
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 13:18:46 +0200 (CEST)
Received: from vador.mandriva.com (vador.mandriva.com [127.0.0.1])
	by vador.mandriva.com (Postfix) with ESMTP id B11FD1BD5A
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 13:08:18 +0200 (CEST)
In-Reply-To: <ALOGGER1187770486.24@alsa-project.org> (Clemens Ladisch's
	message of "Wed\, 22 Aug 2007 10\:14\:46 +0200 \(CEST\)")
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

--=-=-=

Clemens Ladisch <clemens@ladisch.de> writes:

> changeset:   2314:3bf9c6dec8c8
> tag:         tip
> user:        cladisch
> date:        Wed Aug 22 09:42:13 2007 +0200
> files:       src/conf/cards/CMI8788.conf
> description:
> cmi8788: add alsa-lib config
> 
> Add a .conf file to enable dmix/dsnoop and softvol for CMI8788.
> 
> Using dmix helps mask the bug that all audio is forced to 48 kHz. :-)

as usual, here's the missing bit:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=alsa.diff

--- ./src/conf/cards/Makefile.am.tv	2007-08-22 13:05:12.000000000 +0200
+++ ./src/conf/cards/Makefile.am	2007-08-22 13:05:26.000000000 +0200
@@ -16,6 +16,7 @@ cfg_files = aliases.conf \
 	CMI8338-SWIEC.conf \
 	CMI8738-MC6.conf \
 	CMI8738-MC8.conf \
+	CMI8788.conf \
 	CS46xx.conf \
 	EMU10K1.conf \
 	EMU10K1X.conf \

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
