From: Maik Broemme <mbroemme@plusserver.de>
Subject: [PATCH] dmix share one socket to more than one user
Date: Sun, 7 Dec 2003 05:22:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031207042229.GB26017@bart.intergenia.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

today i got some problems with the dmix pcm plugin, i start one
mpg123 as root and later i want to start as normal user alsaplayer
to test something. I got permission denied error, because the socket
is only writable from the user who has created it. I have made a
little patch which implements a new config entry for the socket
permissions. For example:

pcm.softmix {
        type dmix
        ipc_key 1024
        ipc_perm 666
...
}

If you are interested in i could do this for all pcm plugins which
creates a socket, also i could implement another entry like
ipc_group = "audio"; no problem i think with getgrgid(); Another
thing which is changed now; the default file permissions if no
ipc_perm entry in the config file exists, is 0644, i think there
is no need to have 755 for the socket :)

--Maik

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-lib-1.0.0rc2-dmix-ipc-perm.patch"

diff -Nur alsa-lib-1.0.0rc2/src/pcm/pcm_direct.c alsa-lib-1.0.0rc2-dmix-ipc-perm/src/pcm/pcm_direct.c
--- alsa-lib-1.0.0rc2/src/pcm/pcm_direct.c	2003-10-17 15:53:06.000000000 +0200
+++ alsa-lib-1.0.0rc2-dmix-ipc-perm/src/pcm/pcm_direct.c	2003-12-07 02:58:36.000000000 +0100
@@ -157,7 +157,7 @@
 	return 0;
 }
 
-static int make_local_socket(const char *filename, int server)
+static int make_local_socket(const char *filename, int server, mode_t ipc_perm)
 {
 	size_t l = strlen(filename);
 	size_t size = offsetof(struct sockaddr_un, sun_path) + l;
@@ -181,6 +181,12 @@
 			int result = -errno;
 			SYSERR("bind failed");
 			return result;
+		} else {
+			if (chmod(filename, ipc_perm) < 0) {
+				int result = -errno;
+				SYSERR("chmod failed");
+				return result;
+			}
 		}
 	} else {
 		if (connect(sock, (struct sockaddr *) addr, size) < 0) {
@@ -297,7 +303,7 @@
 	if (ret < 0)
 		return ret;
 	
-	ret = make_local_socket(dmix->shmptr->socket_name, 1);
+	ret = make_local_socket(dmix->shmptr->socket_name, 1, dmix->ipc_perm);
 	if (ret < 0)
 		return ret;
 	dmix->server_fd = ret;
@@ -349,7 +355,7 @@
 	int ret;
 	unsigned char buf;
 
-	ret = make_local_socket(dmix->shmptr->socket_name, 0);
+	ret = make_local_socket(dmix->shmptr->socket_name, 0, dmix->ipc_perm);
 	if (ret < 0)
 		return ret;
 	dmix->comm_fd = ret;
diff -Nur alsa-lib-1.0.0rc2/src/pcm/pcm_direct.h alsa-lib-1.0.0rc2-dmix-ipc-perm/src/pcm/pcm_direct.h
--- alsa-lib-1.0.0rc2/src/pcm/pcm_direct.h	2003-09-17 19:09:45.000000000 +0200
+++ alsa-lib-1.0.0rc2-dmix-ipc-perm/src/pcm/pcm_direct.h	2003-12-07 02:52:52.000000000 +0100
@@ -79,6 +79,7 @@
 struct snd_pcm_direct {
 	snd_pcm_type_t type;		/* type (dmix, dsnoop, dshare) */
 	key_t ipc_key;			/* IPC key for semaphore and memory */
+	mode_t ipc_perm;		/* IPC socket permissions */
 	int semid;			/* IPC global semaphore identification */
 	int shmid;			/* IPC global shared memory identification */
 	snd_pcm_direct_share_t *shmptr;	/* pointer to shared memory area */
diff -Nur alsa-lib-1.0.0rc2/src/pcm/pcm_dmix.c alsa-lib-1.0.0rc2-dmix-ipc-perm/src/pcm/pcm_dmix.c
--- alsa-lib-1.0.0rc2/src/pcm/pcm_dmix.c	2003-10-23 16:42:47.000000000 +0200
+++ alsa-lib-1.0.0rc2-dmix-ipc-perm/src/pcm/pcm_dmix.c	2003-12-07 04:58:36.000000000 +0100
@@ -743,7 +743,8 @@
  *          changed in future.
  */
 int snd_pcm_dmix_open(snd_pcm_t **pcmp, const char *name,
-		      key_t ipc_key, struct slave_params *params,
+		      key_t ipc_key, mode_t ipc_perm,
+		      struct slave_params *params,
 		      snd_config_t *bindings,
 		      snd_config_t *root, snd_config_t *sconf,
 		      snd_pcm_stream_t stream, int mode)
@@ -771,6 +772,7 @@
 		goto _err;
 	
 	dmix->ipc_key = ipc_key;
+	dmix->ipc_perm = ipc_perm;
 	dmix->semid = -1;
 	dmix->shmid = -1;
 
@@ -1056,6 +1058,7 @@
 	struct slave_params params;
 	int bsize, psize, ipc_key_add_uid = 0;
 	key_t ipc_key = 0;
+	mode_t ipc_perm = 0644;
 	int err;
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -1074,6 +1077,21 @@
 			ipc_key = key;
 			continue;
 		}
+		if (strcmp(id, "ipc_perm") == 0) {
+			char *perm;
+			char *endp;
+			err = snd_config_get_ascii(n, &perm);
+			if (err < 0) {
+				SNDERR("The field ipc_perm must be a valid file permission");
+				return err;
+			}
+			if (isdigit(*perm) == 0) {
+				SNDERR("The field ipc_perm must be a valid file permission");
+				return -EINVAL;
+			}
+			ipc_perm = strtol(perm, &endp, 8);
+			continue;
+		}
 		if (strcmp(id, "ipc_key_add_uid") == 0) {
 			char *tmp;
 			err = snd_config_get_ascii(n, &tmp);
@@ -1135,7 +1153,7 @@
 	params.period_size = psize;
 	params.buffer_size = bsize;
 
-	err = snd_pcm_dmix_open(pcmp, name, ipc_key, &params, bindings, root, sconf, stream, mode);
+	err = snd_pcm_dmix_open(pcmp, name, ipc_key, ipc_perm, &params, bindings, root, sconf, stream, mode);
 	if (err < 0)
 		snd_config_delete(sconf);
 	return err;

--8t9RHnE3ZwKMSgU+--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
