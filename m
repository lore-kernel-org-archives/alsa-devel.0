From: Konstantin Stepaniuk <s.k.v@mail.ru>
Subject: exit() -> _exit() in pcm_direct.c
Date: Wed, 30 Jul 2003 20:21:37 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307302021.37432.s.k.v@mail.ru>
References: <E19d8Au-00060s-00@sc8-sf-list2.sourceforge.net>
Reply-To: s.k.v@mail.ru
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RC/J/rVxo+bRVlG"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19d8Au-00060s-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_RC/J/rVxo+bRVlG
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

My program call snd_pcm_open() with "plug:dmix" in thread.
Function snd_pcm_direct_server_create() hangs on waitpid() if exit() is used, 
and server_job process keeps alive after program exit.
This trivial patch chages exit() to _exit() in file pcm_direct.c. In this case 
all works ok for me.

Best regards, Konstantin Stepaniuk.

--Boundary-00=_RC/J/rVxo+bRVlG
Content-Type: text/x-diff;
  charset="koi8-r";
  name="pcm_direct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pcm_direct.patch"

--- pcm_direct.c.orig	2003-07-30 20:01:34.000000000 +0400
+++ pcm_direct.c	2003-07-30 20:02:06.000000000 +0400
@@ -284,7 +284,7 @@
 	snd_pcm_direct_shm_discard(dmix);
 	snd_pcm_direct_semaphore_discard(dmix);
 	server_printf("DIRECT SERVER EXIT\n");
-	exit(EXIT_SUCCESS);
+	_exit(EXIT_SUCCESS);
 }
 
 int snd_pcm_direct_server_create(snd_pcm_direct_t *dmix)
@@ -316,7 +316,7 @@
 		ret = fork();
 		if (ret == 0)
 			server_job(dmix);
-		exit(EXIT_SUCCESS);
+		_exit(EXIT_SUCCESS);
 	} else {
 		waitpid(ret, NULL, 0);
 	}

--Boundary-00=_RC/J/rVxo+bRVlG--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
