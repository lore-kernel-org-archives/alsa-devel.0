From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001005]: [PATCH] pcm_dmix.c:92: error: static declaration of 'shm_sum_discard' follows non-static declaration
Date: Tue, 22 Mar 2005 09:03:59 +0100
Message-ID: <78f5433a222d7cb7ab72093b9e1efbf6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3320728B
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 09:04:00 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1005> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1005
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-22-2005 09:03 CET
Last Modified:              03-22-2005 09:03 CET
======================================================================
Summary:                    [PATCH] pcm_dmix.c:92: error: static declaration of
'shm_sum_discard' follows non-static declaration
Description: 
http://bugs.debian.org/300792

-------- Forwarded Message --------
From: Andreas Jochens <aj@andaco.de>
Reply-To: Andreas Jochens <aj@andaco.de>, 300792@bugs.debian.org
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: [Pkg-alsa-devel] Bug#300792: alsa-lib: FTBFS (ppc64/gcc-4.0):
static declaration of 'shm_sum_discard' follows non-static declaration
Date: Mon, 21 Mar 2005 22:42:00 +0100
Package: alsa-lib
Severity: normal
Tags: patch

When building 'alsa-lib' on ppc64 with gcc-4.0,
I get the following error:

pcm_dmix.c: At top level:
pcm_dmix.c:92: error: static declaration of 'shm_sum_discard' follows
non-static declaration
pcm_dmix.c:84: error: previous implicit declaration of 'shm_sum_discard'
was here
pcm_dmix.c:221:2: warning: #warning Please, recode mix_areas1() routine to
your architecture...
pcm_dmix.c: In function 'mix_areas1':
pcm_dmix.c:247: error: invalid lvalue in assignment
pcm_dmix.c:248: error: invalid lvalue in assignment
pcm_dmix.c:249: error: invalid lvalue in assignment
pcm_dmix.c:253:2: warning: #warning Please, recode mix_areas2() routine to
your architecture...
pcm_dmix.c: In function 'mix_areas2':
pcm_dmix.c:279: error: invalid lvalue in assignment
pcm_dmix.c:280: error: invalid lvalue in assignment
pcm_dmix.c:281: error: invalid lvalue in assignment
make[3]: *** [pcm_dmix.lo] Error 1
make[3]: Leaving directory `/alsa-lib-1.0.8/src/pcm'

With the attached patch 'alsa-lib' can be compiled
on ppc64 using gcc-4.0.

Regards
Andreas Jochens

diff -urN ../tmp-orig/alsa-lib-1.0.8/src/conf.c ./src/conf.c
--- ../tmp-orig/alsa-lib-1.0.8/src/conf.c	2004-10-05 17:33:04.000000000
+0200
+++ ./src/conf.c	2005-03-21 22:30:08.619865849 +0100
@@ -2486,6 +2486,8 @@
 				snd_config_searcha, snd_config_searchva);
 }
 
+static int snd_config_hooks(snd_config_t *config, snd_config_t
*private_data);
+
 /**
  * \brief Searches for a node in a configuration tree and expands hooks.
  * \param config Handle to the root of the configuration (sub)tree to
search.
@@ -2496,7 +2498,6 @@
  */
 int snd_config_search_hooks(snd_config_t *config, const char *key,
snd_config_t **result)
 {
-	static int snd_config_hooks(snd_config_t *config, snd_config_t
*private_data);
 	SND_CONFIG_SEARCH(config, key, result, \
 					err = snd_config_hooks(config, NULL); \
 					if (err < 0) \
@@ -2504,6 +2505,8 @@
 			 );
 }
 
+static int snd_config_hooks(snd_config_t *config, snd_config_t
*private_data);
+
 /**
  * \brief Searches for a node in a configuration tree, expanding aliases
and hooks.
  * \param root Handle to the root configuration node containing alias
@@ -2516,7 +2519,6 @@
  */
 int snd_config_searcha_hooks(snd_config_t *root, snd_config_t *config,
const char *key, snd_config_t **result)
 {
-	static int snd_config_hooks(snd_config_t *config, snd_config_t
*private_data);
 	SND_CONFIG_SEARCHA(root, config, key, result,
 					snd_config_searcha_hooks,
 					err = snd_config_hooks(config, NULL); \
diff -urN ../tmp-orig/alsa-lib-1.0.8/src/pcm/pcm_dmix.c
./src/pcm/pcm_dmix.c
--- ../tmp-orig/alsa-lib-1.0.8/src/pcm/pcm_dmix.c	2005-01-11
18:42:49.000000000 +0100
+++ ./src/pcm/pcm_dmix.c	2005-03-21 22:07:17.000000000 +0100
@@ -53,12 +53,13 @@
  *
  */
 
+static int shm_sum_discard(snd_pcm_direct_t *dmix);
+
 /*
  *  sum ring buffer shared memory area 
  */
 static int shm_sum_create_or_connect(snd_pcm_direct_t *dmix)
 {
-	static int shm_sum_discard(snd_pcm_direct_t *dmix);
 	struct shmid_ds buf;
 	int tmpid, err;
 	size_t size;
@@ -244,9 +245,9 @@
 		} while (*sum != old_sample);
 		if (!--size)
 			return;
-		((char *)src) += src_step;
-		((char *)dst) += dst_step;
-		((char *)sum) += sum_step;
+		src = ((char *)src) + src_step;
+		dst = ((char *)dst) + dst_step;
+		sum = ((char *)sum) + sum_step;
 	}
 }
 
@@ -276,9 +277,9 @@
 		} while (*sum != old_sample);
 		if (!--size)
 			return;
-		((char *)src) += src_step;
-		((char *)dst) += dst_step;
-		((char *)sum) += sum_step;
+		src = ((char *)src) + src_step;
+		dst = ((char *)dst) + dst_step;
+		sum = ((char *)sum) + sum_step;
 	}
 }
 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 09:03 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
