From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] alsa-lib: Add htimestamp operation in
	plugin file
Date: Wed, 30 Nov 2016 00:15:57 +0900
Message-ID: <f3796efe-5870-2f87-77b5-6f932b4b5bac@sakamocchi.jp>
References: <1480073797-17667-1-git-send-email-sutar.mounesh@gmail.com>
 <s5hmvgj5s6n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 77E20266A7A
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 16:16:02 +0100 (CET)
In-Reply-To: <s5hmvgj5s6n.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, sutar.mounesh@gmail.com
Cc: alsa-devel@alsa-project.org, mounesh_sutar@mentor.com, Andreas Pape <apape@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 29 2016 04:18, Takashi Iwai wrote:
> On Fri, 25 Nov 2016 12:36:37 +0100,
> sutar.mounesh@gmail.com wrote:
>>
>> From: Andreas Pape <apape@de.adit-jv.com>
>>
>> PCM operation htimestamp is not implemented in plugin file.
>> Calling snd_pcm_htimestamp() on a plugin file crashes. This scenario
>> is considered now.
>>
>> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
>> Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>
>
> Applied, thanks.
>
>
> Takashi
>
>> ---
>>
>> --- a/src/pcm/pcm_file.c	2013-07-08 14:31:36.000000000 +0200
>> +++ b/src/pcm/pcm_file.c	2015-05-04 16:26:10.413615403 +0200
>> @@ -698,6 +698,7 @@
>>  	.readi = snd_pcm_file_readi,
>>  	.readn = snd_pcm_file_readn,
>>  	.avail_update = snd_pcm_generic_avail_update,
>> +	.htimestamp = snd_pcm_generic_htimestamp,
>>  	.mmap_commit = snd_pcm_file_mmap_commit,
>>  	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
>>  	.poll_descriptors = snd_pcm_generic_poll_descriptors,

I oppose this application, because designated initialization is already 
applied to the .htimestamp member.

...
         .poll_descriptors = snd_pcm_generic_poll_descriptors,
         .poll_revents = snd_pcm_generic_poll_revents,
         .htimestamp = snd_pcm_generic_htimestamp,
};

Please see below commit:
pcm:file: add the missing htimestamp callback
http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=68ae0c72a53704d416fe77d4c612d1f88d791e02

This mistake causes below warning with -Woverride-init option.
pcm_file.c:714:16: warning: initialized field overwritten [-Woverride-init]
   .htimestamp = snd_pcm_generic_real_htimestamp,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I guess mentor/ADIT developers works for former snapshot, then missed to 
rebase to current mainline of alsa-lib. I suggest them to di 
re-evaluation with current mainline without this patch.


Regards

Takashi Sakamoto
