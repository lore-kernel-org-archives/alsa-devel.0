From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: [PATCH] PCM parameters in file plugin
Date: Thu, 29 Jan 2009 00:00:08 +0100
Message-ID: <4980E378.7050506@insite.cz>
References: <49627395.1090506@insite.cz>	<49632995.9000109@insite.cz>	<Pine.LNX.4.61.0901061128300.8273@tm8103.perex-int.cz>	<49634196.1070500@insite.cz>	<4974FCC1.70907@insite.cz>
	<s5hk58fv3nl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020100020107030803010802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id A5D921037E3
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 00:00:14 +0100 (CET)
In-Reply-To: <s5hk58fv3nl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020100020107030803010802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Mon, 19 Jan 2009 23:20:49 +0100,
> Pavel Hofman wrote:
>> @@ -84,6 +106,211 @@ typedef struct {
>>  #define TO_LE16(x)	bswap_16(x)
>>  #endif
>>  
>> +/* old_string MUST contain the key! */
>> +int snd_pcm_file_replace_key(char *old_string, char *key, char *value,
>> +		char **newstring_p)
> 
> Make this static.
> 
>> +{
>> +	int str_index, newstr_index, key_index, end, new_len, old_len, cpy_len,
>> +	    first_key_index;
>> +	char *c, *first_c, *newstring;
>> +	int keys_count;
>> +
>> +	first_c = c = (char *) strstr(old_string, key);
> 
> I guess this parser doesn't handle '%%' properly like printf()?
> 
>> +int snd_pcm_file_replace_fname(snd_pcm_file_t *file, char **new_fname_p)
> 
> Make it static.
> 
>> +int snd_pcm_file_has_keys(char *string)
> 
> Ditto.
> 
>> +int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
> 
> Ditto.
> 
>> +	if (file->final_fname[0] == '|') {
>> +		/* pipe mode */
>> +		FILE *pipe;
>> +		/* clearing */
>> +		file->final_fname[0] = ' ';
>> +		pipe = popen(file->final_fname, "w");
> 
> Pass "file->final_fname + 1", and you don't have to replace the pipe
> with a space.
> 
> 
> thanks,
> 
> Takashi

Hi Takashi,

Thanks a lot for your comments.

Please find enclosed a reworked patch which reflects your requests 
including the %% functionality.

Thanks,

Pavel.

--------------020100020107030803010802
Content-Type: text/x-patch;
 name="pcm_file.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_file.c.patch"

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 82823a0..8e0f2dc 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -29,6 +29,7 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <ctype.h>
+#include <string.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
@@ -39,6 +40,16 @@ const char *_snd_module_pcm_file = "";
 
 #ifndef DOC_HIDDEN
 
+/* keys to be replaced by real values in the filename */
+#define LEADING_KEY	'%'	/* i.e. %r, %c, %b ... */
+#define RATE_KEY	'r'
+#define CHANNELS_KEY	'c'
+#define BWIDTH_KEY	'b'
+#define FORMAT_KEY	'f'
+
+/* maximum length of a value */
+#define VALUE_MAXLEN	10
+
 typedef enum _snd_pcm_file_format {
 	SND_PCM_FILE_FORMAT_RAW,
 	SND_PCM_FILE_FORMAT_WAV
@@ -57,6 +68,9 @@ struct wav_fmt {
 typedef struct {
 	snd_pcm_generic_t gen;
 	char *fname;
+	char *final_fname;
+	int trunc;
+	int perm;
 	int fd;
 	char *ifname;
 	int ifd;
@@ -84,6 +98,183 @@ typedef struct {
 #define TO_LE16(x)	bswap_16(x)
 #endif
 
+static int snd_pcm_file_replace_key(char format, const void *value_p,
+		char **string_p, char **index_ch_p, int *len_p)
+{
+	char *value_str, *string, *index_ch;
+	int index, len;
+	/* input pointer values */
+	len = *(len_p);
+	string = *(string_p);
+	index_ch = *(index_ch_p);
+
+	/* converting general-type value to its string representation */
+	value_str = malloc(VALUE_MAXLEN + 1);
+	if (!value_str)
+		return -ENOMEM;
+	switch (format) {
+	case 'd':
+		snprintf(value_str, VALUE_MAXLEN, "%d",	*((int *) value_p));
+		break;
+	case 's':
+		snprintf(value_str, VALUE_MAXLEN, "%s",	(char *) value_p);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* reallocation to accommodate the value */
+	index = index_ch - string;
+	len += VALUE_MAXLEN;
+	string = realloc(string, len + 1);
+	if (!string) {
+		free(value_str);
+		return -ENOMEM;
+	}
+	index_ch = string + index;
+	/* concatenating the new value */
+	strcpy(index_ch, value_str);
+	index_ch += strlen(value_str);
+	free(value_str);
+	/* return values */
+	*(len_p) = len;
+	*(string_p) = string;
+	*(index_ch_p) = index_ch;
+	return 0;
+}
+
+static int snd_pcm_file_replace_fname(snd_pcm_file_t *file, char **new_fname_p)
+{
+	char *fname = file->fname;
+	char *new_fname = NULL;
+	char *old_last_ch, *old_index_ch, *new_index_ch;
+	int old_len, new_len, width, err;
+
+	snd_pcm_t *pcm = file->gen.slave;
+
+	/* we want to keep fname, const */
+	old_len = new_len = strlen(fname);
+	old_last_ch = fname + old_len;
+	new_fname = malloc(new_len + 1);
+	if (!new_fname)
+		return -ENOMEM;
+
+	old_index_ch = fname;	/* first character of the old name */
+	new_index_ch = new_fname;	/* first char of the new name */
+
+	while (old_index_ch <= old_last_ch) {
+		/* char by char */
+		if (*(old_index_ch) != '%') {
+			/* plain copying */
+			*(new_index_ch++) = *(old_index_ch++);
+			continue;
+		}
+		/* is %, skipping and checking next letter */
+		switch (*(++old_index_ch)) {
+		case RATE_KEY:
+			err = snd_pcm_file_replace_key('d', &(pcm->rate),
+					&new_fname, &new_index_ch, &new_len);
+			if (err < 0)
+				return err;
+			break;
+
+		case CHANNELS_KEY:
+			err = snd_pcm_file_replace_key('d', &(pcm->channels),
+					&new_fname, &new_index_ch, &new_len);
+			if (err < 0)
+				return err;
+			break;
+
+		case BWIDTH_KEY:
+			width = pcm->frame_bits/(8 * pcm->channels);
+			err = snd_pcm_file_replace_key('d', &width, &new_fname,
+					&new_index_ch, &new_len);
+			if (err < 0)
+				return err;
+			break;
+
+		case FORMAT_KEY:
+			err = snd_pcm_file_replace_key('s',
+					snd_pcm_format_name(pcm->format),
+					&new_fname, &new_index_ch, &new_len);
+			if (err < 0)
+				return err;
+			break;
+
+		default:
+			*(new_index_ch++) = *(old_index_ch);
+		}
+		/* next old letter */
+		old_index_ch++;
+	}
+	*(new_index_ch) = '\0';
+	*(new_fname_p) = new_fname;
+	return 0;
+
+}
+
+static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
+{
+	int err, fd;
+
+	/* fname can contain keys, generating final_fname */
+	err = snd_pcm_file_replace_fname(file, &(file->final_fname));
+	if (err < 0)
+		return err;
+	/*printf("DEBUG - original fname: %s, final fname: %s\n",
+	  file->fname, file->final_fname);*/
+
+	if (file->final_fname[0] == '|') {
+		/* pipe mode */
+		FILE *pipe;
+		/* clearing */
+		pipe = popen(file->final_fname + 1, "w");
+		if (!pipe) {
+			SYSERR("running %s for writing failed",
+					file->final_fname);
+			return -errno;
+		}
+		fd = fileno(pipe);
+	} else {
+		if (file->trunc)
+			fd = open(file->final_fname, O_WRONLY|O_CREAT|O_TRUNC,
+					file->perm);
+		else {
+			fd = open(file->final_fname, O_WRONLY|O_CREAT|O_EXCL,
+					file->perm);
+			if (fd < 0) {
+				char *tmpfname = NULL;
+				int idx, len;
+				len = strlen(file->final_fname) + 6;
+				tmpfname = malloc(len);
+				if (!tmpfname)
+					return -ENOMEM;
+				for (idx = 1; idx < 10000; idx++) {
+					snprintf(tmpfname, len,
+						"%s.%04d", file->final_fname,
+						idx);
+					fd = open(tmpfname,
+							O_WRONLY|O_CREAT|O_EXCL,
+							file->perm);
+					if (fd >= 0) {
+						free(file->final_fname);
+						file->final_fname = tmpfname;
+						break;
+					}
+				}
+				if (fd < 0) {
+					SYSERR("open %s for writing failed",
+							file->final_fname);
+					free(tmpfname);
+					return -errno;
+				}
+			}
+		}
+	}
+	file->fd = fd;
+	return 0;
+}
+
 static void setup_wav_header(snd_pcm_t *pcm, struct wav_fmt *fmt)
 {
 	fmt->fmt = TO_LE16(0x01);
@@ -152,6 +343,8 @@ static void fixup_wav_header(snd_pcm_t *pcm)
 }
 #endif /* DOC_HIDDEN */
 
+
+
 static void snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
 {
 	snd_pcm_file_t *file = pcm->private_data;
@@ -442,6 +635,13 @@ static int snd_pcm_file_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 		a->first = slave->sample_bits * channel;
 		a->step = slave->frame_bits;
 	}
+	if (file->fd < 0) {
+		err = snd_pcm_file_open_output_file(file);
+		if (err < 0) {
+			SYSERR("failed opening output file %s", file->fname);
+			return err;
+		}
+	}
 	return 0;
 }
 
@@ -452,6 +652,10 @@ static void snd_pcm_file_dump(snd_pcm_t *pcm, snd_output_t *out)
 		snd_output_printf(out, "File PCM (file=%s)\n", file->fname);
 	else
 		snd_output_printf(out, "File PCM (fd=%d)\n", file->fd);
+	if (file->final_fname)
+		snd_output_printf(out, "Final file PCM (file=%s)\n",
+				file->final_fname);
+
 	if (pcm->setup) {
 		snd_output_printf(out, "Its setup is:\n");
 		snd_pcm_dump_setup(pcm, out);
@@ -533,7 +737,6 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	snd_pcm_file_t *file;
 	snd_pcm_file_format_t format;
 	struct timespec timespec;
-	char *tmpname = NULL;
 	int err;
 
 	assert(pcmp);
@@ -546,58 +749,27 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 		SNDERR("file format %s is unknown", fmt);
 		return -EINVAL;
 	}
-	if (fname) {
-		if (trunc)
-			fd = open(fname, O_WRONLY|O_CREAT|O_TRUNC, perm);
-		else {
-			fd = open(fname, O_WRONLY|O_CREAT|O_EXCL, perm);
-			if (fd < 0) {
-				int idx, len;
-				len = strlen(fname) + 6;
-				tmpname = malloc(len);
-				if (!tmpname)
-					return -ENOMEM;
-				for (idx = 1; idx < 10000; idx++) {
-					snprintf(tmpname, len,
-						 "%s.%04d", fname, idx);
-					fd = open(tmpname, O_WRONLY|O_CREAT|O_EXCL, perm);
-					if (fd >= 0) {
-						fname = tmpname;
-						break;
-					}
-				}
-			}
-		}
-		if (fd < 0) {
-			SYSERR("open %s for writing failed", fname);
-			free(tmpname);
-			return -errno;
-		}
-	}
 	file = calloc(1, sizeof(snd_pcm_file_t));
 	if (!file) {
-		if (fname)
-			close(fd);
-		free(tmpname);
 		return -ENOMEM;
 	}
 
+	/* opening output fname is delayed until writing,
+	 when PCM params are known */
+	if (fname)
+		file->fname = strdup(fname);
+	file->trunc = trunc;
+	file->perm = perm;
+
 	if (ifname) {
 		ifd = open(ifname, O_RDONLY);	/* TODO: mind blocking mode */
 		if (ifd < 0) {
 			SYSERR("open %s for reading failed", ifname);
-			if (fname)
-				close(fd);
 			free(file);
-			free(tmpname);
 			return -errno;
 		}
-	}
-
-	if (fname)
-		file->fname = strdup(fname);
-	if (ifname)
 		file->ifname = strdup(ifname);
+	}
 	file->fd = fd;
 	file->ifd = ifd;
 	file->format = format;
@@ -608,7 +780,6 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	if (err < 0) {
 		free(file->fname);
 		free(file);
-		free(tmpname);
 		return err;
 	}
 	pcm->ops = &snd_pcm_file_ops;
@@ -625,8 +796,6 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
-
-	free(tmpname);
 	return 0;
 }
 
@@ -634,8 +803,9 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 
 \section pcm_plugins_file Plugin: File
 
-This plugin stores contents of a PCM stream to file, and optionally
-uses an existing file as an input data source (i.e., "virtual mic")
+This plugin stores contents of a PCM stream to file or pipes the stream
+to a command, and optionally uses an existing file as an input data source
+(i.e., "virtual mic")
 
 \code
 pcm.name {
@@ -647,7 +817,17 @@ pcm.name {
                 # or
                 pcm { }         # Slave PCM definition
         }
-	file STR		# Output filename
+	file STR		# Output filename (or shell command the stream
+				# will be piped to if STR starts with the pipe
+				# char).
+				# STR can contain format keys, replaced by
+				# real values corresponding to the stream:
+				# %r	rate (replaced with: 48000)
+				# %c	channels (replaced with: 2)
+				# %b	bytes per sample (replaced with: 2)
+				# %f	sample format string
+				#			(replaced with: S16_LE)
+				# %%	replaced with %
 	or
 	file INT		# Output file descriptor number
 	infile STR		# Input filename - only raw format

--------------020100020107030803010802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020100020107030803010802--
