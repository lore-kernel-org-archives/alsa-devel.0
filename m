From: Peter Stokes <linux@dadeos.co.uk>
Subject: [PATCH 1/2] Arcam AV Control Plugin Updates
Date: Sat, 21 Feb 2009 16:59:52 +0000
Message-ID: <200902211659.52723.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IMDoJaBNdvpID40"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.freeserve.com (smtp3.wanadoo.co.uk [193.252.22.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D1C924584
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:22 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3208.me.freeserve.com (SMTP Server) with ESMTP id E2C36700008C
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:21 +0100 (CET)
Received: from RedDwarf.dadeos.co.uk (unknown [91.109.223.150])
	by mwinf3208.me.freeserve.com (SMTP Server) with ESMTP id 847707000089
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 18:17:21 +0100 (CET)
Received: from tuscan.dadeos.co.uk (Tuscan.dadeos.co.uk [10.0.0.243])
	(authenticated bits=0)
	by RedDwarf.dadeos.co.uk (8.14.3/8.14.2) with ESMTP id n1LHHAJi026983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 17:17:10 GMT
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

--Boundary-00=_IMDoJaBNdvpID40
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

arcam_av: Remove incorrect usage of the static SHM ID variable

Signed-off-by: Peter Stokes <linux@dadeos.co.uk>

--Boundary-00=_IMDoJaBNdvpID40
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="arcam_av_remove_static.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="arcam_av_remove_static.patch"

diff --git a/arcam-av/arcam_av.c b/arcam-av/arcam_av.c
index 81e72e9..0491fc6 100644
--- a/arcam-av/arcam_av.c
+++ b/arcam-av/arcam_av.c
@@ -329,39 +329,34 @@ static void arcam_av_state_query(int fd)
 }
 
 
-static int arcam_av_state_shm_id = -1;
-
 arcam_av_state_t* arcam_av_state_attach(const char* port)
 {
 	arcam_av_state_t* state;
+	struct stat port_stat;
+	key_t ipc_key;
+	int shmid, shmflg;
+	struct shmid_ds shm_stat;
 
-	if (arcam_av_state_shm_id < 0) {
-		struct stat port_stat;
-		key_t ipc_key;
-		int shmflg;
-		struct shmid_ds shm_stat;
-
-		if (stat(port, &port_stat))
-			return NULL;
+	if (stat(port, &port_stat))
+		return NULL;
 
-		ipc_key = ftok(port, 'A');
-		if (ipc_key < 0)
-			return NULL;
+	ipc_key = ftok(port, 'A');
+	if (ipc_key < 0)
+		return NULL;
 
-		shmflg = IPC_CREAT | (port_stat.st_mode & (S_IRWXU | S_IRWXG | S_IRWXO));
-		arcam_av_state_shm_id = shmget(ipc_key, sizeof(arcam_av_state_t), shmflg);
-		if (arcam_av_state_shm_id < 0)
-			return NULL;
+	shmflg = IPC_CREAT | (port_stat.st_mode & (S_IRWXU | S_IRWXG | S_IRWXO));
+	shmid = shmget(ipc_key, sizeof(arcam_av_state_t), shmflg);
+	if (shmid < 0)
+		return NULL;
 
-		if (shmctl(arcam_av_state_shm_id, IPC_STAT, &shm_stat))
-			return NULL;
+	if (shmctl(shmid, IPC_STAT, &shm_stat))
+		return NULL;
 
-		shm_stat.shm_perm.uid = port_stat.st_uid;
-		shm_stat.shm_perm.gid = port_stat.st_gid;
-		shmctl(arcam_av_state_shm_id, IPC_SET, &shm_stat);
-	}
+	shm_stat.shm_perm.uid = port_stat.st_uid;
+	shm_stat.shm_perm.gid = port_stat.st_gid;
+	shmctl(shmid, IPC_SET, &shm_stat);
 
-	state = shmat(arcam_av_state_shm_id, NULL, 0);
+	state = shmat(shmid, NULL, 0);
 
 	return (state == (void*)-1) ? NULL : state;
 }
@@ -369,20 +364,7 @@ arcam_av_state_t* arcam_av_state_attach(const char* port)
 
 int arcam_av_state_detach(arcam_av_state_t* state)
 {
-	struct shmid_ds shm_stat;
-
-	if (shmdt(state))
-		return -1;
-
-	if (shmctl(arcam_av_state_shm_id, IPC_STAT, &shm_stat))
-		return -1;
-
-	if (!shm_stat.shm_nattch) {
-		shmctl(arcam_av_state_shm_id, IPC_RMID, NULL);
-		arcam_av_state_shm_id = -1;
-	}
-
-	return 0;
+	return shmdt(state);
 }
 
 

--Boundary-00=_IMDoJaBNdvpID40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_IMDoJaBNdvpID40--
