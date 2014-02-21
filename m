From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] route: Select slave chmap based on ttable
	information
Date: Fri, 21 Feb 2014 16:24:21 +0100
Message-ID: <1392996262-27970-3-git-send-email-david.henningsson@canonical.com>
References: <1392996262-27970-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D4AC82658F7
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 16:24:26 +0100 (CET)
In-Reply-To: <1392996262-27970-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

It means we need to initialize this order:

 1) Read the ttable to figure out which channels are present
 2) Open slave pcm and find a matching chmap
 3) Determine size of ttable (this can now depend on the chmap)
 4) Read ttable coefficients
 5) At prepare time, select the matching chmap

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm_route.c | 300 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 257 insertions(+), 43 deletions(-)

diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index ffc283f..355da1e 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -103,6 +103,7 @@ typedef struct {
 	snd_pcm_format_t sformat;
 	int schannels;
 	snd_pcm_route_params_t params;
+	snd_pcm_chmap_t *chmap;
 } snd_pcm_route_t;
 
 #endif /* DOC_HIDDEN */
@@ -518,6 +519,7 @@ static int snd_pcm_route_close(snd_pcm_t *pcm)
 		}
 		free(params->dsts);
 	}
+	free(route->chmap);
 	return snd_pcm_generic_close(pcm);
 }
 
@@ -789,21 +791,168 @@ static void snd_pcm_route_dump(snd_pcm_t *pcm, snd_output_t *out)
 	snd_pcm_dump(route->plug.gen.slave, out);
 }
 
-static int safe_chmapchannel(const char *id, long *channel)
+static int safe_chmapchannel(const char *id, snd_pcm_chmap_t *chmap,
+			     long *channel, int channel_size)
 {
-	int err;
 	int ch;
-	err = safe_strtol(id, channel);
-	if (err >= 0)
-		return err;
+	if (safe_strtol(id, channel) >= 0)
+		return 1;
 
 	ch = (int) snd_pcm_chmap_from_string(id);
 	if (ch == -1)
 		return -EINVAL;
 
-	/* For now, assume standard channel mapping */
-	*channel = ch - SND_CHMAP_FL;
+	if (chmap) {
+		int i, r = 0;
+		/* Start with highest channel to simplify implementation of
+		   determine ttable size */
+		for (i = chmap->channels - 1; i >= 0; i--) {
+			if ((int) chmap->pos[i] != ch)
+				continue;
+			if (r >= channel_size)
+				continue;
+			channel[r++] = i;
+		}
+		return r;
+	}
+	else {
+		/* Assume ALSA standard channel mapping */
+		*channel = ch - SND_CHMAP_FL;
+		return 1;
+	}
+}
+
+#define MAX_CHMAP_CHANNELS 256
+
+static int determine_chmap(snd_config_t *tt, snd_pcm_chmap_t **tt_chmap)
+{
+	snd_config_iterator_t i, inext;
+	snd_pcm_chmap_t *chmap;
+
+	assert(tt && tt_chmap);
+	chmap = malloc(sizeof(snd_pcm_chmap_t) +
+		       MAX_CHMAP_CHANNELS * sizeof(unsigned int));
+
+	chmap->channels = 0;
+	snd_config_for_each(i, inext, tt) {
+		const char *id;
+		snd_config_iterator_t j, jnext;
+		snd_config_t *in = snd_config_iterator_entry(i);
+
+		if (!snd_config_get_id(in, &id) < 0)
+			continue;
+		if (snd_config_get_type(in) != SND_CONFIG_TYPE_COMPOUND)
+			goto err;
+		snd_config_for_each(j, jnext, in) {
+			int ch, k, found;
+			long schannel;
+			snd_config_t *jnode = snd_config_iterator_entry(j);
+			if (snd_config_get_id(jnode, &id) < 0)
+				continue;
+			if (safe_strtol(id, &schannel) >= 0)
+				continue;
+			ch = (int) snd_pcm_chmap_from_string(id);
+			if (ch == -1)
+				goto err;
+
+			found = 0;
+			for (k = 0; k < (int) chmap->channels; k++)
+				if (ch == (int) chmap->pos[k]) {
+					found = 1;
+					break;
+				}
+			if (found)
+				continue;
+
+			if (chmap->channels >= MAX_CHMAP_CHANNELS) {
+				SNDERR("Too many channels in ttable chmap");
+				goto err;
+			}
+			chmap->pos[chmap->channels++] = ch;
+		}
+	}
+
+
+	*tt_chmap = chmap;
 	return 0;
+
+err:
+	*tt_chmap = NULL;
+	free(chmap);
+	return -EINVAL;
+}
+
+static int find_matching_chmap(snd_pcm_t *spcm, snd_pcm_chmap_t *tt_chmap,
+			       snd_pcm_chmap_t **found_chmap, int *schannels)
+{
+	snd_pcm_chmap_query_t** chmaps = snd_pcm_query_chmaps(spcm);
+	int i;
+
+	*found_chmap = NULL;
+
+	if (chmaps == NULL)
+		return 0; /* chmap API not supported for this slave */
+
+	for (i = 0; chmaps[i]; i++) {
+		unsigned int j, k;
+		int match = 1;
+		snd_pcm_chmap_t *c = &chmaps[i]->map;
+		if (*schannels >= 0 && (int) c->channels != *schannels)
+			continue;
+
+		for (j = 0; j < tt_chmap->channels; j++) {
+			int found = 0;
+			unsigned int ch = tt_chmap->pos[j];
+			for (k = 0; k < c->channels; k++)
+				if (c->pos[k] == ch) {
+					found = 1;
+					break;
+				}
+			if (!found) {
+				match = 0;
+				break;
+			}
+		}
+
+		if (match) {
+			int size = sizeof(snd_pcm_chmap_t) + c->channels * sizeof(unsigned int);
+			*found_chmap = malloc(size);
+			memcpy(*found_chmap, c, size);
+			*schannels = c->channels;
+			break;
+		}
+	}
+
+	snd_pcm_free_chmaps(chmaps);
+
+	if (*found_chmap == NULL) {
+		SNDERR("Found no matching channel map");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int route_chmap_init(snd_pcm_t *pcm)
+{
+	int set_map = 0;
+	snd_pcm_chmap_t *current;
+	snd_pcm_route_t *route = pcm->private_data;
+	if (!route->chmap)
+		return 0;
+	if (snd_pcm_state(pcm) != SND_PCM_STATE_PREPARED)
+		return 0;
+
+	current = snd_pcm_get_chmap(route->plug.gen.slave);
+	if (!current)
+		return -ENOSYS;
+	if (current->channels != route->chmap->channels)
+		set_map = 1;
+	else set_map = memcmp(current->pos, route->chmap->pos, current->channels);
+	free(current);
+	if (!set_map)
+		return 0;
+
+	return snd_pcm_set_chmap(route->plug.gen.slave, route->chmap);
 }
 
 
@@ -939,6 +1088,7 @@ int snd_pcm_route_open(snd_pcm_t **pcmp, const char *name,
 	route->plug.undo_write = snd_pcm_plugin_undo_write_generic;
 	route->plug.gen.slave = slave;
 	route->plug.gen.close_slave = close_slave;
+	route->plug.init = route_chmap_init;
 
 	err = snd_pcm_new(&pcm, SND_PCM_TYPE_ROUTE, name, slave->stream, slave->mode);
 	if (err < 0) {
@@ -963,16 +1113,10 @@ int snd_pcm_route_open(snd_pcm_t **pcmp, const char *name,
 	return 0;
 }
 
-/**
- * \brief Determine route matrix sizes
- * \param tt Configuration root describing route matrix
- * \param tt_csize Returned client size in elements
- * \param tt_ssize Returned slave size in elements
- * \retval zero on success otherwise a negative error code
- */
-int snd_pcm_route_determine_ttable(snd_config_t *tt,
-				   unsigned int *tt_csize,
-				   unsigned int *tt_ssize)
+static int _snd_pcm_route_determine_ttable(snd_config_t *tt,
+					   unsigned int *tt_csize,
+					   unsigned int *tt_ssize,
+					   snd_pcm_chmap_t *chmap)
 {
 	snd_config_iterator_t i, inext;
 	long csize = 0, ssize = 0;
@@ -1001,7 +1145,7 @@ int snd_pcm_route_determine_ttable(snd_config_t *tt,
 			const char *id;
 			if (snd_config_get_id(jnode, &id) < 0)
 				continue;
-			err = safe_chmapchannel(id, &schannel);
+			err = safe_chmapchannel(id, chmap, &schannel, 1);
 			if (err < 0) {
 				SNDERR("Invalid slave channel: %s", id);
 				return -EINVAL;
@@ -1020,6 +1164,20 @@ int snd_pcm_route_determine_ttable(snd_config_t *tt,
 }
 
 /**
+ * \brief Determine route matrix sizes
+ * \param tt Configuration root describing route matrix
+ * \param tt_csize Returned client size in elements
+ * \param tt_ssize Returned slave size in elements
+ * \retval zero on success otherwise a negative error code
+ */
+int snd_pcm_route_determine_ttable(snd_config_t *tt,
+				   unsigned int *tt_csize,
+				   unsigned int *tt_ssize)
+{
+	return _snd_pcm_route_determine_ttable(tt, tt_csize, tt_ssize, NULL);
+}
+
+/**
  * \brief Load route matrix
  * \param tt Configuration root describing route matrix
  * \param ttable Returned route matrix
@@ -1030,10 +1188,10 @@ int snd_pcm_route_determine_ttable(snd_config_t *tt,
  * \param schannels Slave channels
  * \retval zero on success otherwise a negative error code
  */
-int snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *ttable,
-			      unsigned int tt_csize, unsigned int tt_ssize,
-			      unsigned int *tt_cused, unsigned int *tt_sused,
-			      int schannels)
+static int _snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *ttable,
+				      unsigned int tt_csize, unsigned int tt_ssize,
+				      unsigned int *tt_cused, unsigned int *tt_sused,
+				      int schannels, snd_pcm_chmap_t *chmap)
 {
 	int cused = -1;
 	int sused = -1;
@@ -1060,17 +1218,18 @@ int snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *tt
 		snd_config_for_each(j, jnext, in) {
 			snd_config_t *jnode = snd_config_iterator_entry(j);
 			double value;
-			long schannel;
+			int ss;
+			long *scha = alloca(tt_ssize * sizeof(long));
 			const char *id;
 			if (snd_config_get_id(jnode, &id) < 0)
 				continue;
-			err = safe_chmapchannel(id, &schannel);
-			if (err < 0 || 
-			    schannel < 0 || (unsigned int) schannel > tt_ssize || 
-			    (schannels > 0 && schannel >= schannels)) {
+
+			ss = safe_chmapchannel(id, chmap, scha, tt_ssize);
+			if (ss < 0) {
 				SNDERR("Invalid slave channel: %s", id);
 				return -EINVAL;
 			}
+
 			err = snd_config_get_real(jnode, &value);
 			if (err < 0) {
 				long v;
@@ -1081,9 +1240,18 @@ int snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *tt
 				}
 				value = v;
 			}
-			ttable[cchannel * tt_ssize + schannel] = value;
-			if (schannel > sused)
-				sused = schannel;
+
+			for (k = 0; (int) k < ss; k++) {
+				long schannel = scha[k];
+				if (schannel < 0 || (unsigned int) schannel > tt_ssize ||
+				    (schannels > 0 && schannel >= schannels)) {
+					SNDERR("Invalid slave channel: %s", id);
+					return -EINVAL;
+				}
+				ttable[cchannel * tt_ssize + schannel] = value;
+				if (schannel > sused)
+					sused = schannel;
+			}
 		}
 		if (cchannel > cused)
 			cused = cchannel;
@@ -1093,6 +1261,26 @@ int snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *tt
 	return 0;
 }
 
+/**
+ * \brief Load route matrix
+ * \param tt Configuration root describing route matrix
+ * \param ttable Returned route matrix
+ * \param tt_csize Client size in elements
+ * \param tt_ssize Slave size in elements
+ * \param tt_cused Used client elements
+ * \param tt_sused Used slave elements
+ * \param schannels Slave channels
+ * \retval zero on success otherwise a negative error code
+ */
+int snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *ttable,
+			      unsigned int tt_csize, unsigned int tt_ssize,
+			      unsigned int *tt_cused, unsigned int *tt_sused,
+			      int schannels)
+{
+	return _snd_pcm_route_load_ttable(tt, ttable, tt_csize, tt_ssize,
+					  tt_cused, tt_sused, schannels, NULL);
+}
+
 /*! \page pcm_plugins
 
 \section pcm_plugins_route Plugin: Route & Volume
@@ -1100,6 +1288,9 @@ int snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *tt
 This plugin converts channels and applies volume during the conversion.
 The format and rate must match for both of them.
 
+SCHANNEL can be a channel name instead of a number (e g FL, LFE).
+If so, a matching channel map will be selected for the slave.
+
 \code
 pcm.name {
         type route              # Route & Volume conversion PCM
@@ -1150,6 +1341,7 @@ int _snd_pcm_route_open(snd_pcm_t **pcmp, const char *name,
 	int err;
 	snd_pcm_t *spcm;
 	snd_config_t *slave = NULL, *sconf;
+	snd_pcm_chmap_t *tt_chmap, *chmap;
 	snd_pcm_format_t sformat = SND_PCM_FORMAT_UNKNOWN;
 	int schannels = -1;
 	snd_config_t *tt = NULL;
@@ -1198,37 +1390,59 @@ int _snd_pcm_route_open(snd_pcm_t **pcmp, const char *name,
 		return -EINVAL;
 	}
 
-	err = snd_pcm_route_determine_ttable(tt, &csize, &ssize);
+	err = determine_chmap(tt, &tt_chmap);
 	if (err < 0) {
-		snd_config_delete(sconf);
+		free(ttable);
 		return err;
 	}
-	ttable = malloc(csize * ssize * sizeof(snd_pcm_route_ttable_entry_t));
-	if (ttable == NULL) {
-		snd_config_delete(sconf);
-		return -ENOMEM;
-	}
-	err = snd_pcm_route_load_ttable(tt, ttable, csize, ssize,
-					&cused, &sused, schannels);
+
+	err = snd_pcm_open_slave(&spcm, root, sconf, stream, mode, conf);
+	snd_config_delete(sconf);
 	if (err < 0) {
+		free(tt_chmap);
 		free(ttable);
-		snd_config_delete(sconf);
 		return err;
 	}
 
-	err = snd_pcm_open_slave(&spcm, root, sconf, stream, mode, conf);
-	snd_config_delete(sconf);
+	if (tt_chmap) {
+		err = find_matching_chmap(spcm, tt_chmap, &chmap, &schannels);
+		free(tt_chmap);
+		if (err < 0)
+			return err;
+	}
+
+	err = _snd_pcm_route_determine_ttable(tt, &csize, &ssize, chmap);
 	if (err < 0) {
+		free(chmap);
+		snd_pcm_close(spcm);
+		return err;
+	}
+	ttable = malloc(csize * ssize * sizeof(snd_pcm_route_ttable_entry_t));
+	if (ttable == NULL) {
+		free(chmap);
+		snd_pcm_close(spcm);
+		return -ENOMEM;
+	}
+	err = _snd_pcm_route_load_ttable(tt, ttable, csize, ssize,
+					&cused, &sused, schannels, chmap);
+	if (err < 0) {
+		free(chmap);
 		free(ttable);
+		snd_pcm_close(spcm);
 		return err;
 	}
+
 	err = snd_pcm_route_open(pcmp, name, sformat, schannels,
 				 ttable, ssize,
 				 cused, sused,
 				 spcm, 1);
 	free(ttable);
-	if (err < 0)
+	if (err < 0) {
+		free(chmap);
 		snd_pcm_close(spcm);
+	}
+	((snd_pcm_route_t*) (*pcmp)->private_data)->chmap = chmap;
+
 	return err;
 }
 #ifndef DOC_HIDDEN
-- 
1.9.0
