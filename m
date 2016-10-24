From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH v2 2/3] alsaconf: Search included files
 under global configuration directories
Date: Mon, 24 Oct 2016 21:23:46 +0800
Message-ID: <580E0B62.2070200@linux.intel.com>
References: <cover.1476941614.git.mengdong.lin@linux.intel.com>
 <735fd601cf38d08e01feae7044aa10294f7229f1.1476941614.git.mengdong.lin@linux.intel.com>
 <s5hmvhxg2ux.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A8CE266C10
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 15:22:34 +0200 (CEST)
In-Reply-To: <s5hmvhxg2ux.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org



On 10/21/2016 11:04 PM, Takashi Iwai wrote:
> On Thu, 20 Oct 2016 07:48:37 +0200,
> mengdong.lin@linux.intel.com wrote:
>>
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> Users can include file by giving a relative path or just a file name via
>> alsaconf syntax <xxx>. ALSA conf will search the file in top configuration
>> directory and additional configuration directories defined by users via
>> alsaconf syntax <confdir:/xxx>.
>>
>> ALSA conf will search and open an included file in the following order
>> of priority:
>>
>> 1. directly open the file by its name;
>> 2. search for the file name in top config direcotry "usr/share/alsa/";
>> 3. search for the file name in additional configuration directories
>>     specified by users, via alsaconf syntax
>>     <confdir:/relative-path/to/user/share/alsa>;
>
> This would break the existing use case of <confdir:xxx>.
> Currently, "confdir:" simply replaces itself with the default config
> directory.  For example, <confdir:foo/bar> will include the file
> /usr/share/alsa/foo/bar, and it doesn't mean to specify the
> directory.  You can think of "confdir:" as $ALSA_CONF_DIR.
>
> In your use case, you want to enumerate directories.  Then either
> create a new macro (e.g. "searchdir") or check properly whether the
> given path is a directory.

Thanks for pointing out the mistake.
I'll use <searchdir:xxx> and only files with a relative path
will be searched under <usr/share/alsa> and user specified directories 
via syntax <searchdir:xxx>.

>
>
>> The configuration directories defined by a file will only be used to search
>> the files included by this file.
>>
>> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> diff --git a/src/conf.c b/src/conf.c
>> index a516611..44ef673 100644
>> --- a/src/conf.c
>> +++ b/src/conf.c
>> @@ -456,6 +456,18 @@ struct filedesc {
>>   	snd_input_t *in;
>>   	unsigned int line, column;
>>   	struct filedesc *next;
>> +
>> +	/* list of the include paths (configuration directories),
>> +	 * defined by <confdir:/relative-path/to/top-alsa-conf-dir>,
>> +	 * for searching its included files.
>> +	 */
>> +	struct list_head include_paths;
>> +};
>> +
>> +/* path to search included files */
>> +struct include_path {
>> +	char *dir;
>> +	struct list_head list;
>>   };
>>
>>   #define LOCAL_ERROR			(-0x68000000)
>> @@ -501,6 +513,120 @@ static inline void snd_config_unlock(void) { }
>>
>>   #endif
>>
>> +/**
>> + * \brief Add a diretory to the paths to search included files.
>> + * \param fd File object that owns these paths to search files included by it.
>> + * \param dir Path of the directory to add.
>> + * \return Zero if successful, otherwise a negative error code.
>> + *
>> + * The direcotry should be a subdiretory of top configuration directory
>> + * "/usr/share/alsa/".
>
> Don't use the doxygen comment for static functions.
> They shouldn't be included in the exported documents.
>
>

Okay. I'll change the format.

>> + */
>> +static int add_include_path(struct filedesc *fd, char *dir)
>> +{
>> +	struct include_path *path;
>> +
>> +	path = calloc(1, sizeof(*path));
>> +	if (!path)
>> +		return -ENOMEM;
>> +
>> +	path->dir = calloc(1, PATH_MAX + 1);
>> +	if (!path->dir)
>> +		return -ENOMEM;
>
> Leaking the path object here.
>

Sorry, I'll fix this. New code will have dir allocated by the caller, so 
here we'll just store the string pointer and there will be no calloc and 
free on error here.

>> +	strncpy(path->dir, dir, PATH_MAX);
>
> Isn't the dir the proper NUL-terminated string?  If so, we can simply
> copy like:
> 	path->dir = strdup(dir);
> 	if (!path->dir) {
> 		...
>

Yes.

>> +	list_add_tail(&path->list, &fd->include_paths);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * \brief Free all include paths of a file descriptor.
>> + * \param fd File object that owns these paths to search files included by it.
>> + */
>
> Ditto, no doxygen comments.

Okay.

>
>> +static void free_include_paths(struct filedesc *fd)
>> +{
>> +	struct list_head *pos, *npos, *base;
>> +	struct include_path *path;
>> +
>> +	base = &fd->include_paths;
>> +	list_for_each_safe(pos, npos, base) {
>> +		path = list_entry(pos, struct include_path, list);
>> +		list_del(&path->list);
>> +		if (path->dir)
>> +			free(path->dir);
>> +		free(path);
>> +	}
>> +}
>> +
>> +/**
>> + * \brief Search and open a file, and creates a new input object reading
>> + *        from the file.
>> + * \param inputp The functions puts the pointer to the new input object
>> + *               at the address specified by \p inputp.
>> + * \param file Name of the configuration file.
>> + * \param include_paths Optional, addtional directories to search the file.
>> + * \return Zero if successful, otherwise a negative error code.
>> + *
>> + * This function will search and open the file in the following order
>> + * of priority:
>> + * 1. directly open the file by its name;
>> + * 2. search for the file name in top configuration directory
>> + *     "usr/share/alsa/";
>> + * 3. search for the file name in in additional configuration directories
>> + *     specified by users, via alsaconf syntax
>> + *     <confdir:/relative-path/to/user/share/alsa>;
>> + *     These directories should be subdirectories of /usr/share/alsa.
>> + */
>
> Ditto.

Okay.

>> +static int input_stdio_open(snd_input_t **inputp, const char *file,
>> +			    struct list_head *include_paths)
>> +{
>> +	struct list_head *pos, *npos, *base;
>> +	struct include_path *path;
>> +	char *full_path = NULL;
>> +	int err = 0;
>> +
>> +	err = snd_input_stdio_open(inputp, file, "r");
>> +	if (err == 0)
>> +		goto out;
>> +
>> +	full_path = calloc(1, PATH_MAX + 1);
>> +	if (!full_path)
>> +		return -ENOMEM;
>
> In user-space we have a bigger stack, so you can just use the auto
> variable here instead of heap.  It's more efficient.

Okay, I'll do this. Thanks for the tips :-)

>
>> +
>> +	/* search file in top configuration directory usr/share/alsa */
>> +	strcpy(full_path, ALSA_CONFIG_DIR);
>> +	strcat(full_path, "/");
>> +	strcat(full_path, file);
>
> This may overflow.  Do like
> 	snprintf(full_path, sizeof(full_path), "%s/%s",
> 		ALSA_CONFIG_DIR, file);
>

Yes, there is the risk and snprintf looks nice. I'll fix as you suggested.


>> +	err = snd_input_stdio_open(inputp, full_path, "r");
>> +	if (err == 0)
>> +		goto out;
>> +
>> +	/* search file in user specified include paths. These directories
>> +	 * are subdirectories of /usr/share/alsa.
>> +	 */
>> +	if (include_paths) {
>> +		base = include_paths;
>> +		list_for_each_safe(pos, npos, base) {
>
> No need to use *_safe version here, as we don't remove the list entry.

Okay. And I'll also use snprintf here.

>
>> +			path = list_entry(pos, struct include_path, list);
>> +			if (!path->dir)
>> +				continue;
>> +
>> +			strncpy(full_path, path->dir, PATH_MAX);
>> +			strcat(full_path, "/");
>> +			strcat(full_path, file);
>> +			err = snd_input_stdio_open(inputp, full_path, "r");
>> +			if (err == 0)
>> +			goto out;
>> +		}
>> +	}
>> +
>> +out:
>> +	if (full_path)
>> +		free(full_path);
>> +
>> +	return err;
>> +}
>> +
>>   static int safe_strtoll(const char *str, long long *val)
>>   {
>>   	long long v;
>> @@ -632,7 +758,7 @@ static int get_char_skip_comments(input_t *input)
>>   			int err = get_delimstring(&str, '>', input);
>>   			if (err < 0)
>>   				return err;
>> -			if (!strncmp(str, "confdir:", 8)) {
>> +			if (!strncmp(str, "confdir:", 8)) { /* directory */
>>   				char *tmp = malloc(strlen(ALSA_CONFIG_DIR) + 1 + strlen(str + 8) + 1);
>>   				if (tmp == NULL) {
>>   					free(str);
>> @@ -641,8 +767,14 @@ static int get_char_skip_comments(input_t *input)
>>   				sprintf(tmp, ALSA_CONFIG_DIR "/%s", str + 8);
>>   				free(str);
>>   				str = tmp;
>> +
>> +				err = snd_input_stdio_open(&in, str, "r");
>> +				if (err == 0)
>> +					add_include_path(input->current, str);
>
> See my comment above.
>
>
> thanks,
>
> Takashi

Thank you very much for the review and comments!
I've fixed the issues in the series v4. Please review.

Mengdong


>
>
>> +			} else { /* file, also search in include paths */
>> +				err = input_stdio_open(&in, str,
>> +						&input->current->include_paths);
>>   			}
>> -			err = snd_input_stdio_open(&in, str, "r");
>>   			if (err < 0) {
>>   				SNDERR("Cannot access file %s", str);
>>   				free(str);
>> @@ -658,6 +790,7 @@ static int get_char_skip_comments(input_t *input)
>>   			fd->next = input->current;
>>   			fd->line = 1;
>>   			fd->column = 0;
>> +			INIT_LIST_HEAD(&fd->include_paths);
>>   			input->current = fd;
>>   			continue;
>>   		}
>> @@ -1668,6 +1801,7 @@ static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override)
>>   	fd->line = 1;
>>   	fd->column = 0;
>>   	fd->next = NULL;
>> +	INIT_LIST_HEAD(&fd->include_paths);
>>   	input.current = fd;
>>   	input.unget = 0;
>>   	err = parse_defs(config, &input, 0, override);
>> @@ -1708,9 +1842,12 @@ static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override)
>>   		fd_next = fd->next;
>>   		snd_input_close(fd->in);
>>   		free(fd->name);
>> +		free_include_paths(fd);
>>   		free(fd);
>>   		fd = fd_next;
>>   	}
>> +
>> +	free_include_paths(fd);
>>   	free(fd);
>>   	return err;
>>   }
>> --
>> 2.5.0
>>
>
