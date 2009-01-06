From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PCM parameters in file plugin
Date: Tue, 06 Jan 2009 12:33:42 +0100
Message-ID: <49634196.1070500@insite.cz>
References: <49627395.1090506@insite.cz> <49632995.9000109@insite.cz>
	<Pine.LNX.4.61.0901061128300.8273@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060702090700070109040607"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id B81AA2438B
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 12:33:42 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0901061128300.8273@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060702090700070109040607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jaroslav Kysela wrote:
> On Tue, 6 Jan 2009, Pavel Hofman wrote:
> 
>> Pavel Hofman napsal(a):
>>> Hello,
>>>
>>> I am working on a file plugin patch to allow adding PCM parameters 
>>> (rate, format) to  the name of the file created (plus the ability to run 
>>> an external command via popen, such as upsampling with sox). I got stuck 
>>> in trying to obtain these parameters in pcm_file.c:_snd_pcm_file_open(). 
>>> Is it actually possible or the information is not available at the time 
>>> of opening the file (and the whole patch is thus nonsense)?
>>>
>>> Thanks a lot for help.
>>>
>> I am now opening the output file in pcm_file.c:snd_pcm_file_write_bytes.
>> Surprisingly it seems to work fine. Could such hack be accepted as a
>> patch to the plugin (if coded properly)? Is there a better place to open 
>> the file?
> 
> The file should be opened in the hw_params callback (all PCM parameters 
> are known in this time). Also, extending filename with PCM parameters 
> should be optional (configurable). But the idea looks nice.
> 
> 						Jaroslav


Hi,

Thanks a lot for your hint. Here is a preliminary version of the patch 
for review (no docs updated, no clean formatting).

The changes are moving the opening of output file to hw_params callback, 
support for replacement codes in the file parameter,  and support for 
piping to external commands when the file parameter starts with |.

This is a working ".asoundrc on steroids" (upsampling to 96kHz using the 
quality algorithm of sox)

pcm.raw {
          type file
          slave {
                  pcm null
          }
          format "raw"
          file "| sox -V -c %c -%b -r %r -s -t raw - -t raw -4 - rate -v 
-s 96000 | aplay -v -t raw -r 96000 -c %c -f S32_LE -Dhw:0"
}

Thanks a lot for comments.

Regards,

Pavel.

--------------060702090700070109040607
Content-Type: text/x-diff;
 name="pcm_file.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_file.c.patch"

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 82823a0..df2ee0e 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -29,6 +29,7 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <ctype.h>
+#include <string.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
@@ -39,6 +40,21 @@ const char *_snd_module_pcm_file = "";
 
 #ifndef DOC_HIDDEN
 
+#define RATE_KEY "%r"
+#define CHANNELS_KEY "%c"
+#define BWIDTH_KEY "%b"
+#define FORMAT_KEY "%f"
+#define DECIMAL_INT_LEN 7
+
+static const char* keys[] = {
+	RATE_KEY,
+	CHANNELS_KEY,
+	BWIDTH_KEY,
+	FORMAT_KEY,
+};
+
+#define NUM_OF(x) (sizeof (x) / sizeof *(x))
+
 typedef enum _snd_pcm_file_format {
 	SND_PCM_FILE_FORMAT_RAW,
 	SND_PCM_FILE_FORMAT_WAV
@@ -57,6 +73,9 @@ struct wav_fmt {
 typedef struct {
 	snd_pcm_generic_t gen;
 	char *fname;
+	char *final_fname;
+	int trunc;
+	int perm;
 	int fd;
 	char *ifname;
 	int ifd;
@@ -84,6 +103,198 @@ typedef struct {
 #define TO_LE16(x)	bswap_16(x)
 #endif
 
+/* old_string MUST contain key! */
+int snd_pcm_file_replace_key(char *old_string, char *key, char *value, char **newstring_p)
+{
+	int str_index, newstr_index, key_index, end, new_len, old_len, cpy_len, first_key_index;
+	char *c, *first_c, *newstring;
+	int keys_count;
+
+	first_c = c = (char *) strstr(old_string, key);
+	new_len        = strlen(value);
+	old_len        = strlen(key);
+	end            = strlen(old_string)   - old_len;
+	first_key_index = key_index = c - old_string;
+
+	/* first run - finding nb of keys for calculating allocation size */
+	str_index = 0;
+	keys_count = 0;
+	while(str_index <= end && c != NULL)
+	{
+		keys_count ++;
+		str_index    = key_index + old_len;
+		/* Check for another pattern match */
+		if((c = (char *) strstr(old_string+str_index, key)) != NULL)
+			key_index = c - old_string;
+	}
+	/* now we can allocate exactly the right size */
+	newstring = malloc(strlen(old_string) + keys_count*(new_len - old_len) + 1);
+	if (!newstring)
+		return -ENOMEM;		
+	/* second run - actually replacing */
+	str_index = 0;
+	newstr_index = 0;
+	key_index = first_key_index;
+	c = first_c;
+	while(str_index <= end && c != NULL)
+	{
+		/* Copy characters from the left of matched pattern occurence */
+		cpy_len = key_index-str_index;
+		strncpy(newstring+newstr_index, old_string+str_index, cpy_len);
+		newstr_index += cpy_len;
+		str_index    += cpy_len;
+
+		/* Copy replacement characters instead of matched pattern */
+		strcpy(newstring+newstr_index, value);
+		newstr_index += new_len;
+		str_index    += old_len;
+
+		/* Check for another pattern match */
+		if((c = (char *) strstr(old_string+str_index, key)) != NULL)
+			key_index = c - old_string;
+	}
+	/* Copy remaining characters from the right of last matched pattern */
+	strcpy(newstring+newstr_index, old_string+str_index);
+	*(newstring_p) = newstring;
+	return 0;
+} 
+
+int snd_pcm_file_replace_fname(snd_pcm_file_t *file, char ** new_fname_p) 
+{
+	char* value;
+	char* old_fname = NULL;
+	int err;
+	char* fname = file->fname;
+	snd_pcm_t *pcm = file->gen.slave;
+
+	value = malloc(DECIMAL_INT_LEN);
+	if (! value) {
+		return -ENOMEM;
+	}
+	/* we want to keep fname, const */
+	old_fname = *(new_fname_p) = fname;
+
+	if (strstr(old_fname, RATE_KEY)) {
+		sprintf(value, "%d", pcm->rate);
+		err = snd_pcm_file_replace_key(old_fname, RATE_KEY, value, new_fname_p);
+		/* fname must not be freed */
+		if (old_fname != fname)
+			free(old_fname);
+		old_fname = *(new_fname_p);
+		if (err < 0)
+			return err;
+	}
+	if (strstr(old_fname, CHANNELS_KEY)) {
+		sprintf(value, "%d", pcm->channels);
+		err = snd_pcm_file_replace_key(old_fname, CHANNELS_KEY, value, new_fname_p);
+		if (old_fname != fname)
+			free(old_fname);
+		old_fname = *(new_fname_p);
+		if (err < 0)
+			return err;
+	}
+	if (strstr(old_fname, BWIDTH_KEY)) {
+		sprintf(value, "%d", pcm->frame_bits / (8 * pcm->channels));
+		err = snd_pcm_file_replace_key(old_fname, BWIDTH_KEY, value, new_fname_p);
+		if (old_fname != fname)
+			free(old_fname);
+		old_fname = *(new_fname_p);
+		if (err < 0)
+			return err;
+	}
+	if (strstr(old_fname, FORMAT_KEY)) {
+		sprintf(value, "%d", pcm->format);
+		err = snd_pcm_file_replace_key(old_fname, FORMAT_KEY, value, new_fname_p);
+		if (old_fname != fname)
+			free(old_fname);
+		old_fname = *(new_fname_p);
+		if (err < 0)
+			return err;
+	}
+	
+	free(value);
+	return 0;
+
+}
+
+int snd_pcm_file_has_keys(char* string)
+{
+	int i, n;
+
+	n = NUM_OF(keys);
+	for (i = 0; i < n; ++i) {
+		if (strstr(string, keys[i]) != NULL)
+			return 1;
+	}
+	/* none found */
+	return 0;
+}
+
+int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
+{
+	int err, fd;
+
+	/* fname can contain keys, generating final_fname */
+	if (snd_pcm_file_has_keys(file->fname)) {
+		err = snd_pcm_file_replace_fname(file, &(file->final_fname));
+		if (err < 0)
+			return err;
+		/*printf("DEBUG - original fname: %s, final fname: %s\n", file->fname, file->final_fname);*/
+	}
+	else {
+		/* no changes */
+		file->final_fname = malloc(strlen(file->fname) + 1);
+		if (! file->final_fname)
+			return -ENOMEM;
+		strcpy(file->final_fname, file->fname);
+	}
+
+	if (file->final_fname[0] == '|') {
+		/* pipe mode */
+		FILE * pipe;
+		/* clearing */
+		file->final_fname[0] = ' ';
+		pipe = popen(file->final_fname, "w");
+		if (! pipe) {
+			SYSERR("running %s for writing failed", file->final_fname);
+			return -errno;
+		}
+		fd = fileno(pipe);
+	}
+	else {
+		if (file->trunc)
+			fd = open(file->final_fname, O_WRONLY|O_CREAT|O_TRUNC, file->perm);
+		else {
+			fd = open(file->final_fname, O_WRONLY|O_CREAT|O_EXCL, file->perm);
+			if (fd < 0) {
+				char *tmpfname = NULL;
+				int idx, len;
+				len = strlen(file->final_fname) + 6;
+				tmpfname = malloc(len);
+				if (!tmpfname)
+					return -ENOMEM;
+				for (idx = 1; idx < 10000; idx++) {
+					snprintf(tmpfname, len,
+							"%s.%04d",file->final_fname, idx);
+					fd = open(tmpfname, O_WRONLY|O_CREAT|O_EXCL, file->perm);
+					if (fd >= 0) {
+						free(file->final_fname);
+						file->final_fname = tmpfname;
+						break;
+					}
+				}
+				if (fd < 0) {
+					SYSERR("open %s for writing failed", file->final_fname);
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
@@ -152,6 +363,8 @@ static void fixup_wav_header(snd_pcm_t *pcm)
 }
 #endif /* DOC_HIDDEN */
 
+
+
 static void snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
 {
 	snd_pcm_file_t *file = pcm->private_data;
@@ -442,6 +655,13 @@ static int snd_pcm_file_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
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
 
@@ -452,6 +672,9 @@ static void snd_pcm_file_dump(snd_pcm_t *pcm, snd_output_t *out)
 		snd_output_printf(out, "File PCM (file=%s)\n", file->fname);
 	else
 		snd_output_printf(out, "File PCM (fd=%d)\n", file->fd);
+	if (file->final_fname)
+		snd_output_printf(out, "Final file PCM (file=%s)\n", file->final_fname);
+
 	if (pcm->setup) {
 		snd_output_printf(out, "Its setup is:\n");
 		snd_pcm_dump_setup(pcm, out);
@@ -533,7 +756,6 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	snd_pcm_file_t *file;
 	snd_pcm_file_format_t format;
 	struct timespec timespec;
-	char *tmpname = NULL;
 	int err;
 
 	assert(pcmp);
@@ -546,58 +768,26 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
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
 
+	/* opening output fname is delayed until writing, when PCM params are known */
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
@@ -608,7 +798,6 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	if (err < 0) {
 		free(file->fname);
 		free(file);
-		free(tmpname);
 		return err;
 	}
 	pcm->ops = &snd_pcm_file_ops;
@@ -625,8 +814,6 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
-
-	free(tmpname);
 	return 0;
 }
 

--------------060702090700070109040607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060702090700070109040607--
