From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFCv3][PATCH 35/39] axfer: add an option for
	formatted filename
Date: Mon,  2 Oct 2017 09:19:36 +0900
Message-ID: <20171002001940.17218-36-o-takashi@sakamocchi.jp>
References: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 29CEE26702B
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 02:19:56 +0200 (CEST)
In-Reply-To: <20171002001940.17218-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

In aplay, an option for formatted file name is supported. The format text
is mainly processed by strftime(3) function, however '%v' is available as
an additional format for file number.

This commit adds support for the option. However, this feature has issue
that strftime(3) generates string with characters out of portable filename
characters such as '/' (). This feature is unsafe for users, for instance:

$ strace ./axfer transfer -C -D hw:0,0 --use-strftime /tmp/test-%D.wav
...
open("/tmp/test-09/18/17.wav", O_RDWR|O_CREAT|O_TRUNC|O_NONBLOCK, 0644) = -1 ENOENT (No such file or directory)
...

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 axfer/options.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 axfer/options.h |  1 +
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/axfer/options.c b/axfer/options.c
index d595d857..6665f893 100644
--- a/axfer/options.c
+++ b/axfer/options.c
@@ -24,6 +24,7 @@ enum no_short_opts {
 	OPT_DISABLE_FORMAT,
 	OPT_DISABLE_SOFTVOL,
 	OPT_SCHED_TYPE,
+	OPT_USE_STRFTIME,
 	/* Obsoleted. */
 	OPT_MAX_FILE_TIME,
 };
@@ -403,6 +404,7 @@ int context_options_init(struct context_options *opts, int argc,
 		{"samples",		1, 0, 's'},
 		/* For containers. */
 		{"file-type",		1, 0, 't'},
+		{"use-strftime",	0, 0, OPT_USE_STRFTIME},
 		/* For mapper. */
 		{"separate-channels",	0, 0, 'I'},
 		/* For transfer backend. */
@@ -465,6 +467,8 @@ int context_options_init(struct context_options *opts, int argc,
 			opts->duration_frames = parse_l(optarg, &err);
 		else if (c == 't')
 			cntr_format_literal = optarg;
+		else if (c == OPT_USE_STRFTIME)
+			opts->use_strftime = true;
 		else if (c == 'I')
 			opts->multiple_cntrs = true;
 		else if (c == 'D')
@@ -536,9 +540,81 @@ int context_options_init(struct context_options *opts, int argc,
 			      vu_mode_literal);
 }
 
+/*
+ * A variant of strftime(3) that supports additional format specifiers in the
+ * format string:
+ *  '%v': file number.
+ *
+ *  TODO: some format string gets unportable characters such as '/'.
+ */
+static int generate_path_with_strftime(struct context_options *opts,
+				       const char *template,
+				       unsigned int index, const char *suffix,
+				       const struct tm *now)
+{
+	char *format;
+	unsigned int len;
+	char *pos;
+	char *name;
+	unsigned int width;
+	unsigned int i;
+	int err = 0;
+
+	/* This might be enough to process formatted strings. */
+	format = malloc(4096);
+	if (format == NULL)
+		return -ENOMEM;
+
+	len = strftime(format, 4096, template, now);
+	if (len == 0) {
+		fprintf(stderr, "Invalid format string for strftime(3): %s\n",
+			template);
+		err = -EINVAL;
+		goto end;
+	}
+	format[len] = '\0';
+
+	width = (unsigned int)log10(index) + 1;
+
+	/* Estimate required length for formatted result. */
+	len = 0;
+	for (pos = format; *pos != '\0'; ++pos) {
+		++len;
+		/* '%v' is unique format for numbering. */
+		if (*pos == '%' && *(pos + 1) == 'v')
+			len += width;
+	}
+	len += strlen(suffix);
+
+	name = malloc(len + 1);
+	if (name == NULL) {
+		err = -ENOMEM;
+		goto end;
+	}
+
+	i = 0;
+	for (pos = format; *pos != '\0' && i < len; ++pos) {
+		if (*pos == '%' && *(pos + 1) == 'v') {
+			i += snprintf(name + i, len - i, "%u", index);
+			/* Consume 2 characters in the format string. */
+			++pos;
+		} else {
+			name[i] = *pos;
+			++i;
+		}
+	}
+	strcpy(name + i, suffix);
+	name[len] = '\0';
+
+	opts->paths[index] = name;
+end:
+	free(format);
+	return err;
+}
+
 static int generate_path_with_suffix(struct context_options *opts,
 				     const char *template, unsigned int index,
-				     const char *suffix)
+				     const char *suffix, const struct tm *now)
 {
 	static const char *const single_format = "%s%s";
 	static const char *const multiple_format = "%s-%i%s";
@@ -565,7 +641,8 @@ static int generate_path_with_suffix(struct context_options *opts,
 
 static int generate_path_without_suffix(struct context_options *opts,
 				        const char *template,
-					unsigned int index, const char *suffix)
+					unsigned int index, const char *suffix,
+					const struct tm *now)
 {
 	static const char *const single_format = "%s";
 	static const char *const multiple_format = "%s-%i";
@@ -593,8 +670,17 @@ static int generate_path(struct context_options *opts, char *template,
 			 unsigned int index, const char *suffix)
 {
 	int (*generator)(struct context_options *opts, const char *template,
-			 unsigned int index, const char *suffix);
+			 unsigned int index, const char *suffix,
+			 const struct tm *now);
 	char *pos;
+	time_t now_time;
+	struct tm now_tm;
+
+	now_time = time(NULL);
+	if ((int)now_time < 0)
+		return -errno;
+	if (localtime_r(&now_time, &now_tm) == NULL)
+		return -errno;
 
 	if (strlen(suffix) > 0) {
 		pos = template + strlen(template) - strlen(suffix);
@@ -604,12 +690,14 @@ static int generate_path(struct context_options *opts, char *template,
 	}
 
 	/* Select handlers. */
-	if (strlen(suffix) > 0)
+	if (opts->use_strftime)
+		generator = generate_path_with_strftime;
+	else if (strlen(suffix) > 0)
 		generator = generate_path_with_suffix;
 	else
 		generator = generate_path_without_suffix;
 
-	return generator(opts, template, index, suffix);
+	return generator(opts, template, index, suffix, &now_tm);
 }
 
 static int create_paths(struct context_options *opts, unsigned int path_count)
diff --git a/axfer/options.h b/axfer/options.h
index 188668b0..2092796e 100644
--- a/axfer/options.h
+++ b/axfer/options.h
@@ -32,6 +32,7 @@ struct context_options {
 	char **paths;
 	unsigned int path_count;
 	enum container_format cntr_format;
+	bool use_strftime;
 
 	/* For mapper. */
 	bool multiple_cntrs;
-- 
2.11.0
