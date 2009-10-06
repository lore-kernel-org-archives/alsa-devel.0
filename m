From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/3] ascenario: Fix usage of new typedefed
	snd_scenario_t
Date: Tue,  6 Oct 2009 17:54:30 +0200
Message-ID: <1254844471-12987-3-git-send-email-stefan@datenfreihafen.org>
References: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id DE95A243F0
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 17:54:48 +0200 (CEST)
In-Reply-To: <20091006151232.GF3181@dodger.lab.datenfreihafen.org>
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
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Stefan Schmidt <stefan@slimlogic.co.uk>

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 src/ascenario.c |   56 +++++++++++++++++++++++++++---------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/src/ascenario.c b/src/ascenario.c
index cbd0630..157207a 100644
--- a/src/ascenario.c
+++ b/src/ascenario.c
@@ -80,7 +80,7 @@ struct scenario_info {
 
 /* Describe a snd card and all its scenarios.
  */
-struct snd_scenario {
+struct _snd_scenario_t {
 	char *card_name;
 	int current_scenario;
 	int num_scenarios; /* number of supported scenarios */
@@ -109,14 +109,14 @@ static void scn_stdout(const char *fmt,...)
 	va_end(va);
 }
 
-static inline void set_value(struct snd_scenario *scn,
+static inline void set_value(snd_scenario_t *scn,
 	struct control_settings *control, int count, unsigned short val)
 {
 	int offset = scn->current_scenario * control->count;
 	control->value[offset + count] = val;
 }
 
-static inline unsigned short get_value(struct snd_scenario *scn,
+static inline unsigned short get_value(snd_scenario_t *scn,
 	struct control_settings *control, int count)
 {
 	int offset = scn->current_scenario * control->count;
@@ -223,7 +223,7 @@ static int add_control(snd_ctl_t *handle, snd_ctl_elem_id_t *id,
 	return 0;
 }
 
-static int parse_controls(struct snd_scenario *scn, FILE *f)
+static int parse_controls(snd_scenario_t *scn, FILE *f)
 {
 	struct control_settings *control;
 	char buf[MAX_BUF], name[MAX_NAME];
@@ -408,7 +408,7 @@ static int get_enum (char *buf)
 	return 0; /* TODO */
 }
 
-static void seq_list_append(struct snd_scenario *scn,
+static void seq_list_append(snd_scenario_t *scn,
 			struct sequence_element *curr, int position)
 {
 	struct sequence_element *last, *tmp;
@@ -441,7 +441,7 @@ static void seq_list_append(struct snd_scenario *scn,
 	}
 }
 
-static int parse_sequences(struct snd_scenario *scn, FILE *f, int position)
+static int parse_sequences(snd_scenario_t *scn, FILE *f, int position)
 {
 	char buf[MAX_BUF], *tbuf, *control_value;
 	int control_len, i;
@@ -517,7 +517,7 @@ static int parse_sequences(struct snd_scenario *scn, FILE *f, int position)
 }
 
 /* load scenario i */
-static int read_scenario_file(struct snd_scenario *scn)
+static int read_scenario_file(snd_scenario_t *scn)
 {
 	int fd, ret;
 	FILE *f;
@@ -546,7 +546,7 @@ close:
 	return ret;
 }
 
-static int read_sequence_file(struct snd_scenario *scn, int position)
+static int read_sequence_file(snd_scenario_t *scn, int position)
 {
 	int fd, ret;
 	FILE *f;
@@ -580,7 +580,7 @@ close:
 	return ret;
 }
 
-static int parse_scenario(struct snd_scenario *scn, FILE *f, int line_)
+static int parse_scenario(snd_scenario_t *scn, FILE *f, int line_)
 {
 	struct scenario_info *info;
 	int line = line_ - 1, id = 0, file = 0;
@@ -721,7 +721,7 @@ err:
 	return -EINVAL;
 }
 
-static int read_master_file(struct snd_scenario *scn, FILE *f)
+static int read_master_file(snd_scenario_t *scn, FILE *f)
 {
 	int line = 0, ret = 0, i;
 	char buf[MAX_BUF], *tbuf;
@@ -769,7 +769,7 @@ err:
 }
 
 /* load scenario i */
-static int import_master_config(struct snd_scenario *scn)
+static int import_master_config(snd_scenario_t *scn)
 {
 	int fd, ret;
 	FILE *f;
@@ -801,7 +801,7 @@ close:
  *
  * Parse sound card and store control data in memory db.
  */
-static int parse_card_controls(struct snd_scenario *scn)
+static int parse_card_controls(snd_scenario_t *scn)
 {
 	struct control_settings *control;
 	snd_ctl_t *handle;
@@ -886,7 +886,7 @@ close:
  *
  * Read and parse scenario_info files the store in memory.
  */
-static int import_scenario_files(struct snd_scenario *scn)
+static int import_scenario_files(snd_scenario_t *scn)
 {
 	int ret;
 
@@ -933,7 +933,7 @@ static int import_scenario_files(struct snd_scenario *scn)
 }
 
 /* free all resorces */
-static void free_scn(struct snd_scenario *scn)
+static void free_scn(snd_scenario_t *scn)
 {
 	/* TODO: valgrind to make sure. */
 	int i;
@@ -977,19 +977,19 @@ static void free_scn(struct snd_scenario *scn)
 /*
  * Init sound card scenario db.
  */
-struct snd_scenario *snd_scenario_open(const char *card_name)
+snd_scenario_t *snd_scenario_open(const char *card_name)
 {
-	struct snd_scenario *scn;
+	snd_scenario_t *scn;
 	int err;
 
 	/* TODO: locking and
 	 * check if card_name scn is already loaded,
 	 * if so reuse to conserve ram. */
 
-	scn = malloc(sizeof(struct snd_scenario));
+	scn = malloc(sizeof(snd_scenario_t));
 	if (scn == NULL)
 		return NULL;
-	bzero(scn, sizeof(struct snd_scenario));
+	bzero(scn, sizeof(snd_scenario_t));
 	scn->card_name = strdup(card_name);
 	if (scn->card_name == NULL) {
 		free(scn);
@@ -1016,7 +1016,7 @@ struct snd_scenario *snd_scenario_open(const char *card_name)
 /*
  * Reload and reparse scenario db.
  */
-int snd_scenario_reload(struct snd_scenario *scn)
+int snd_scenario_reload(snd_scenario_t *scn)
 {
 	free_scn(scn);
 
@@ -1034,13 +1034,13 @@ int snd_scenario_reload(struct snd_scenario *scn)
 	return 0;
 }
 
-void snd_scenario_close(struct snd_scenario *scn)
+void snd_scenario_close(snd_scenario_t *scn)
 {
 	free_scn(scn);
 }
 
 static int set_control(snd_ctl_t *handle, snd_ctl_elem_id_t *id,
-	struct snd_scenario *scn)
+	snd_scenario_t *scn)
 {
 	struct control_settings *setting;
 	int ret, count, i, idnum;
@@ -1122,7 +1122,7 @@ set_val:
 	return 0;
 }
 
-static void exec_sequence(struct sequence_element *seq, struct snd_scenario
+static void exec_sequence(struct sequence_element *seq, snd_scenario_t
 			*scn, snd_ctl_elem_list_t *list, snd_ctl_t *handle)
 {
 	int count = snd_ctl_elem_list_get_count(list);
@@ -1151,7 +1151,7 @@ static void exec_sequence(struct sequence_element *seq, struct snd_scenario
 	}
 }
 
-int snd_scenario_set_scn(struct snd_scenario *scn, const char *name)
+int snd_scenario_set_scn(snd_scenario_t *scn, const char *name)
 {
 	snd_ctl_card_info_t *info;
 	snd_ctl_elem_list_t *list;
@@ -1311,7 +1311,7 @@ close:
 	return ret;
 }
 
-const char *snd_scenario_get_scn(struct snd_scenario *scn)
+const char *snd_scenario_get_scn(snd_scenario_t *scn)
 {
 	if (scn->current_scenario > 0 && scn->current_scenario < MAX_SCN)
 		return scn->scenario[scn->current_scenario].name;
@@ -1319,7 +1319,7 @@ const char *snd_scenario_get_scn(struct snd_scenario *scn)
 		return NULL;
 }
 
-int snd_scenario_set_integer(struct snd_scenario *scn, int type, int value)
+int snd_scenario_set_integer(snd_scenario_t *scn, int type, int value)
 {
 	switch (type) {
 	case SND_SCN_INT_QOS:
@@ -1330,7 +1330,7 @@ int snd_scenario_set_integer(struct snd_scenario *scn, int type, int value)
 	}
 }
 
-int snd_scenario_get_integer(struct snd_scenario *scn, int type, int *value)
+int snd_scenario_get_integer(snd_scenario_t *scn, int type, int *value)
 {
 	if (value == NULL)
 		return -EINVAL;
@@ -1343,14 +1343,14 @@ int snd_scenario_get_integer(struct snd_scenario *scn, int type, int *value)
 	}
 }
 
-int snd_scenario_get_control_id(struct snd_scenario *scn, int type,
+int snd_scenario_get_control_id(snd_scenario_t *scn, int type,
 				snd_ctl_elem_id_t *id)
 {
 	/* not yet implemented */
 	return -EINVAL;
 }
 
-int snd_scenario_list(struct snd_scenario *scn, const char **list[])
+int snd_scenario_list(snd_scenario_t *scn, const char **list[])
 {
 	if (scn == NULL || list == NULL)
 		return -EINVAL;
-- 
1.6.4.3
