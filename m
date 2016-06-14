From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/10] ctl: deprecate APIs to add an
 element set with a single element
Date: Tue, 14 Jun 2016 20:25:16 +0900
Message-ID: <575FE99C.2090103@sakamocchi.jp>
References: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
 <1465719371-27721-7-git-send-email-o-takashi@sakamocchi.jp>
 <s5heg815k1q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id BED742614D6
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 13:25:19 +0200 (CEST)
In-Reply-To: <s5heg815k1q.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 13 2016 21:51, Takashi Iwai wrote:
> On Sun, 12 Jun 2016 10:16:07 +0200,
> Takashi Sakamoto wrote:
>>
>> When comparing old APIs (to add a single element) with new APIs (to add
>> an element set), the latter has an benefit to get full identical
>> information for a first element in the element set. Furthermore, in
>> previous commit, the old APIs become simple wrappers to the new APIs.
>> Therefore, there's few intentions to use the old APIs.
>>
>> This commit deprecates the old APIs to encourage the usage of new APIs.
>
> In general, it's a bad idea to deprecate an API that has been actually
> used, and even a worse idea to give a link warning.  We've done
> deprecation for some API functions in the past, and it wasn't a really
> smart move.  But it was still justified that they were really unused
> API functions.  In this case, however, it's commonly used API.  That's
> a big difference.
>
> I know several system libraries like Gtk+ often deprecating API
> functions.  But it's more annoying than useful for developers and
> users.  Unless you are masochistic, the likely first reaction after
> seeing such a warning is: "upstream sucks again".

I just added the link_warning() by immitating these old APIs such as 
snd_pcm_hwsync(). In short, I assumed that it's a fashion of this 
userspace library to use compiler/linker functionalities even if it's 
against usual ways to maintain APIs in userspace libraries.

(I'm not so strange developer, just foreigner to this project without 
enough documentations.)

For the deprecation, I basically agree with you. But there might be 
exaggeration about usage of these APIs. They're rarely used, I think. If 
you know actual application programs to use them, please inform them to 
me. But I know discussions about the population of these APIs are not a 
good direction in this case.

My main intention of this patchset is to add the new APIs. These APIs 
are completely upper compatible to the old APIs, and have benefits I 
described. In fact, deleting public APIs is not preferable, but 
deprecating them and still maintaining sometimes has advantages to 
motivate users to start using the new ones. For this purpose, I think it 
better to add 'deprecated' comment into documentations of old APIs.


Thanks

Takashi Sakamoto

> thanks,
>
> Takashi
>
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>   include/control.h     | 17 ++++++++++++-----
>>   src/control/control.c | 20 ++++++++++++++++++++
>>   2 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/control.h b/include/control.h
>> index d6069ff..e21a58a 100644
>> --- a/include/control.h
>> +++ b/include/control.h
>> @@ -443,14 +443,21 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
>>   int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
>>   			       unsigned int element_count,
>>   			       unsigned int member_count);
>> -
>> -int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long imin, long imax, long istep);
>> -int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, long long imin, long long imax, long long istep);
>> -int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count);
>> -int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id, unsigned int count, unsigned int items, const char *const names[]);
>>   int snd_ctl_elem_add_iec958(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id);
>>   int snd_ctl_elem_remove(snd_ctl_t *ctl, snd_ctl_elem_id_t *id);
>>
>> +int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>> +		unsigned int count, long imin, long imax,
>> +		long istep) __attribute__((deprecated));
>> +int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>> +		unsigned int count, long long imin, long long imax,
>> +		long long istep) __attribute__((deprecated));
>> +int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>> +		unsigned int count) __attribute__((deprecated));
>> +int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>> +		unsigned int count, unsigned int items,
>> +		const char *const names[]) __attribute__((deprecated));
>> +
>>   size_t snd_ctl_elem_value_sizeof(void);
>>   /** \hideinitializer
>>    * \brief allocate an invalid #snd_ctl_elem_value_t using standard alloca
>> diff --git a/src/control/control.c b/src/control/control.c
>> index fbc5e18..6893012 100644
>> --- a/src/control/control.c
>> +++ b/src/control/control.c
>> @@ -677,6 +677,8 @@ int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_id_t *id,
>>    *
>>    * This function is a wrapper function to snd_ctl_elem_add_integer_set() for
>>    * single control element.
>> + *
>> + * \deprecated Since 1.1.2. Use snd_ctl_elem_add_integer_set(), instead.
>>    */
>>   int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>   			     unsigned int member_count,
>> @@ -690,12 +692,17 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>   	return snd_ctl_elem_add_integer_set(ctl, local_id, 1, member_count,
>>   					    min, max, step);
>>   }
>> +link_warning(snd_ctl_elem_add_integer,
>> +	     "Warning: snd_ctl_elem_add_integer is deprecated, "
>> +	     "Use snd_ctl_elem_add_integer_set, instead.");
>>
>>   /**
>>    * \brief Create and add an user-defined control element of integer64 type.
>>    *
>>    * This function is a wrapper function to snd_ctl_elem_add_integer64_set() for
>>    * single control element.
>> + *
>> + * \deprecated Since 1.1.2. Use snd_ctl_elem_add_integer64_set(), instead.
>>    */
>>   int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>   			       unsigned int member_count,
>> @@ -709,12 +716,17 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>   	return snd_ctl_elem_add_integer64_set(ctl, local_id, 1, member_count,
>>   					      min, max, step);
>>   }
>> +link_warning(snd_ctl_elem_add_integer64,
>> +	     "Warning: snd_ctl_elem_add_integer64 is deprecated, "
>> +	     "Use snd_ctl_elem_add_integer64_set, instead.");
>>
>>   /**
>>    * \brief Create and add an user-defined control element of boolean type.
>>    *
>>    * This function is a wrapper function to snd_ctl_elem_add_boolean_set() for
>>    * single control element.
>> + *
>> + * \deprecated Since 1.1.2. Use snd_ctl_elem_add_boolean_set(), instead.
>>    */
>>   int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>   			     unsigned int member_count)
>> @@ -726,6 +738,9 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>
>>   	return snd_ctl_elem_add_boolean_set(ctl, local_id, 1, member_count);
>>   }
>> +link_warning(snd_ctl_elem_add_boolean,
>> +	     "Warning: snd_ctl_elem_add_boolean is deprecated, "
>> +	     "Use snd_ctl_elem_add_boolean_set, instead.");
>>
>>   /**
>>    * \brief Create and add a user-defined control element of enumerated type.
>> @@ -734,6 +749,8 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>    * single control element.
>>    *
>>    * This function is added in version 1.0.25.
>> + *
>> + * \deprecated Since 1.1.2. Use snd_ctl_elem_add_enumerated_set(), instead.
>>    */
>>   int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>   				unsigned int member_count, unsigned int items,
>> @@ -747,6 +764,9 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
>>   	return snd_ctl_elem_add_enumerated_set(ctl, local_id, 1, member_count,
>>   					       items, labels);
>>   }
>> +link_warning(snd_ctl_elem_add_enumerated,
>> +	     "Warning: snd_ctl_elem_add_enumerated is deprecated, "
>> +	     "Use snd_ctl_elem_add_enumerated_set, instead.");
>>
>>   /**
>>    * \brief Create and add a user-defined control element of IEC958 type.
>> --
>> 2.7.4
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
