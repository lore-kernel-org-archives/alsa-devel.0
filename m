From: allan@allanwirth.com
Subject: [PATCH - my module 1/1] Fix a memory access violation
	resulting from improper error propogation.
Date: Thu, 31 Jan 2013 13:55:33 -0500
Message-ID: <1359658533-23170-1-git-send-email-allan@allanwirth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Allan Wirth <allan@allanwirth.com>
List-Id: alsa-devel@alsa-project.org

From: Allan Wirth <allan@allanwirth.com>

Fixes an issue where a variable is used undeclared, which can cause seg
faults on some systems if the configuration file is not formatted
properly.

Signed-off-by: Allan Wirth <allan@allanwirth.com>

diff --git a/src/conf.c b/src/conf.c
index ecaa339..4ba5863 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -3530,7 +3530,7 @@ int snd_config_hook_load(snd_config_t *root, snd_config_t *config, snd_config_t
 				if (err < 0)
 					goto _err;
 			}
-		} else if (config_file_open(root, fi[idx].name) < 0)
+		} else if ((err = config_file_open(root, fi[idx].name)) < 0)
 			goto _err;
 	}
 	*dst = NULL;
-- 
1.7.10.4
