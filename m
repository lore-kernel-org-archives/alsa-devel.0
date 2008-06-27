From: "Sean McNamara" <smcnam@gmail.com>
Subject: [PATCH] [alsa-utils] Fix build with library options
	disabled
Date: Fri, 27 Jun 2008 14:57:26 -0700
Message-ID: <74eb1fe20806271457h2ca1f3a2r97fb0b3536c3f68e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_25361_33169278.1214603846869"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 563C4244FB
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jun 2008 23:57:28 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so136420and.80
	for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2008 14:57:27 -0700 (PDT)
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

------=_Part_25361_33169278.1214603846869
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

It's been a perennial problem with alsa-utils that there is no
configure option to disable the seq and amidi apps. These apps depend
on how you configured alsa-lib: If you pass --disable-seq
--disable-instr to the alsa-lib configure, there does not currently
exist a configure-time option to allow alsa-utils to build against
this particular alsa-lib.

Of course, you could hack makefiles and stuff so it doesn't build seq
and amidi, but I thought it would be nice to commit changes to the
configure.in and Makefile.am to upstream, so that we can disable seq
and amidi the "right" way.

The attached patches are diffed against the latest revision of
alsa-utils. With this change, you can:

1. Disable building amidi by passing --disable-midi to the configure
in alsa-utils.
2. Disable building seq by passing --disable-seq to the configure in alsa-utils.

With this change, we can get a "good" build of alsa-utils (albeit,
missing two of the utilities, which is intended) in the following
circumstances:

1. seq and instr are DISABLED in alsa-lib; seq and midi are DISABLED
in alsa-utils
2. seq and instr are ENABLED in alsa-lib; seq and midi are ENABLED in
alsa-utils (the default).
3. seq and instr are ENABLED in alsa-lib; seq and midi are DISABLED in
alsa-utils.

Of course, it does not build cleanly if seq and instr are DISABLED in
alsa-lib, but seq and midi are ENABLED in alsa-utils.

Patches are attached -- please let me know if there any issues, and if
not, could one of the committers please commit them.

Thanks,

Sean

------=_Part_25361_33169278.1214603846869
Content-Type: application/x-bzip2; name=patch-alsa-utils-no-midi.tar.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhzbpvfp0
Content-Disposition: attachment; filename=patch-alsa-utils-no-midi.tar.bz2

QlpoOTFBWSZTWTxDHFAAAnd/xPwwAEBUf//qf+/+Sv/v/2oAEAAAgAhQA36tu5NZtgAEopNkp5Ta
j9KbU9J6mygNHqAA0A0Ghpp6mmgAiakAekNPUGQA0BoHqAaNAGmgMmjQGJENIMSNNMmgNDQaANMQ
AaA0AA40ZMjCMQDCaDAJoNAyZNGTIYQGEkgpjQmIJpmpqNPSNB6mTQDRoHqGhp6jQxNpNsMp2QGB
KEQBENCoDTnvdEwItGABkDwKKKhMGxDNqz4qMDK68vHU3iXowkFkIxIz2WMJPXHWPMRTPONlLhBo
xDgAppkKLCbYVmIqHaXrPfKCJIQHA0gOp0SFAN5jFPUlRhiEFAQbbQ8yeA7sqgi7DAxZJHFyhaX3
5+zKikRn4lplj7LxCVNG6buG6SvvsWnZRh8FGmZxAGsUZhawBJKv4lCbIgheD7FmtzF4sBYb4vSD
SDFwyRKUqii/yX8I0VqCRSIbE9JgqLZ+nzRQzI1cHf6cAww1R6qANdpxvANf45BTDHE4iFxUgw64
xo4hIIM6KreW5KoMb7Bg91AroIXLaTwYh2SuhOKQqB1qdhJLYliiwk5ZNwrJgDFwu3Xuc64zYALp
AUopbFDdN+tiR4EaX8jkLERYR53uYUxVPNRURpTbgDwR5BTFxfJjFFY5JpTQR7sUBPP7S1IGBhJs
KMnDRiCABBDKitltxp24wu9jmfLdOgeixMtoZrb1JJ8oWXEFhTSyKehDKAOYWDDUsCiojI/TzRSi
Bw4lSFsdE1tGJkipuMJGoSUm2opopzl5JZ0tJMRdbMzM1SyDGBVjtjKAxcomSSBROIvomIQxuAx9
mdpdHMf4DCiaesYZfdxSZzavyG2IVrlBcvtcrTcpMjimghgHHEHXMQFi6jA+gds+nsEQXYY9BNmR
JMMUEeZh6YQ5F/PBaMg1Z1omp5CtdiKHkK8Ij9h2nuJDf0u6uQ3kUEETlq3DKOHmoZxBK9FiI9MY
5CL0rirXBpCOgQ8csgxXWws6YU5gO0hjYZoE/vGNKqS30msxTFxhMrtaTCZE7hkFyYnGQrE2TxOe
/wOOGCTt0LZJOJIHAycgjdtI2Fx6LAgMg4AzokGXOQr0kFhLSCQ4mTkMyNQncZ1kq9AFW9eSUQZO
BUjG/ovsde4vbKMUIzYzGD6xsoGEfSTp8wxQVndTKxFwHPpF2EkYUmVaTKk0mREkZwA/4u5IpwoS
B4hjigA=
------=_Part_25361_33169278.1214603846869
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_25361_33169278.1214603846869--
