From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] conf.c: fix string allocation bugs
Date: Wed, 23 Apr 2003 08:25:12 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304230822070.816-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


This fixes the documented string allocation bugs in conf.c.


Index: alsa-lib/src/conf.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf.c,v
retrieving revision 1.66
diff -u -r1.66 conf.c
--- alsa-lib/src/conf.c	23 Jul 2002 19:51:17 -0000	1.66
+++ alsa-lib/src/conf.c	23 Apr 2003 06:21:44 -0000
@@ -1497,16 +1497,17 @@
  * \param config Handle to the configuration node.
  * \param id The new node id.
  * \return Zero if successful, otherwise a negative error code.
- * \bug \p id must not be a pointer to the node's current id.
  */
 int snd_config_set_id(snd_config_t *config, const char *id)
 {
+	char *new_id;
 	assert(config && id);
+	new_id = strdup(id);
+	if (!new_id)
+		return -ENOMEM;
 	if (config->id)
 		free(config->id);
-	config->id = strdup(id);
-	if (!config->id)
-		return -ENOMEM;
+	config->id = new_id;
 	return 0;
 }

@@ -1981,23 +1982,23 @@
  *
  * This function deletes the old string in the node and stores a copy of
  * the passed string in the node.
- *
- * \bug \p value must not be a pointer to the node's current value.
  */
 int snd_config_set_string(snd_config_t *config, const char *value)
 {
+	char *new_string;
 	assert(config);
 	if (config->type != SND_CONFIG_TYPE_STRING)
 		return -EINVAL;
-	if (config->u.string)
-		free(config->u.string);
 	if (value) {
-		config->u.string = strdup(value);
-		if (!config->u.string)
+		new_string = strdup(value);
+		if (!new_string)
 			return -ENOMEM;
 	} else {
-		config->u.string = NULL;
+		new_string = NULL;
 	}
+	if (config->u.string)
+		free(config->u.string);
+	config->u.string = new_string;
 	return 0;
 }

@@ -2026,8 +2027,6 @@
  * \return Zero if successful, otherwise a negative error code.
  *
  * The node must have a simple type, and the new value must have the same type.
- *
- * \bug For string nodes, changing the length of the string doesn't work.
  */
 int snd_config_set_ascii(snd_config_t *config, const char *ascii)
 {
@@ -2062,10 +2061,12 @@
 		}
 	case SND_CONFIG_TYPE_STRING:
 		{
-			char *ptr = realloc(config->u.string, strlen(ascii) + 1);
+			char *ptr = strdup(ascii);
 			if (ptr == NULL)
 				return -ENOMEM;
-			strcpy(config->u.string, ascii);
+			if (config->u.string)
+				free(config->u.string);
+			config->u.string = ptr;
 		}
 		break;
 	default:




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
