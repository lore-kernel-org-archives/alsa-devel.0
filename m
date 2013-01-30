From: =?iso-8859-1?Q?J=E9r=F4me_Forissier?= <jerome@taodyne.com>
Subject: Re: [PATCH 0/2] Fix thread safety issues
Date: Wed, 30 Jan 2013 19:13:54 +0100
Message-ID: <DBCAE20C-2070-4D0C-A7C0-E62D85846AD4@taodyne.com>
References: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
 <s5hfw1i64k0.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 767842650E5
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 19:13:58 +0100 (CET)
Received: by mail-wi0-f176.google.com with SMTP id hm14so2897340wib.9
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 10:13:58 -0800 (PST)
In-Reply-To: <s5hfw1i64k0.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 30 janv. 2013, at 17:03, Takashi Iwai wrote:

> At Wed, 30 Jan 2013 16:22:15 +0100,
> Jerome Forissier wrote:
>> 
>> This is a set of two patches to fix thread safety issues I found when running
>> a video application over ALSA. The application uses LibVLC to play several
>> videos simultaneously. LibVLC calls snd_pcm_open() and snd_device_name_hint()
>> from multiple threads, without locking--which is allowed according to
>> http://www.alsa-project.org/main/index.php/SMP_Design.
> 
> The fix for snd_pcm_direct_parse_open_conf() looks good.  I'm going to
> apply this now.

Good, thank you :)

> snd_device_name_hint() should use snd_config_update_r() and pass the
> local config space to others instead of snd_config.


I tried following this path, but there is a problem: try_config() calls snd_lib_error_set_handler() so I fail to see how we can make this code reentrant.
In fact, the random errors I've seen when running my multi-threaded test were probably just a side-effect of fiddling with the global error handler from multiple threads. Probably harmless, but still it makes snd_device_name_hint() not thread-safe, strictly speaking.

Any suggestion? Should I consider moving snd_lib_error to thread-local storage?

Thanks.

-- 
Jerome
