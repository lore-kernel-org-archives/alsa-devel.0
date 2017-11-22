From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Emit an error message when dlopen fails.
Date: Wed, 22 Nov 2017 10:09:44 +0900
Message-ID: <6dc8da2a-fabc-7826-3311-dd6a15831782@sakamocchi.jp>
References: <5471e331-1e5b-3bf6-6128-469e39d049cd@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 899582671E7
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 02:09:47 +0100 (CET)
In-Reply-To: <5471e331-1e5b-3bf6-6128-469e39d049cd@free.fr>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cedric Roux <sed@free.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 22 2017 07:12, Cedric Roux wrote:
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>   src/dlmisc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git src/dlmisc.c src/dlmisc.c
> index f154ebd0..9e8e401e 100644
> --- src/dlmisc.c
> +++ src/dlmisc.c
> @@ -81,10 +81,14 @@ void *snd_dlopen(const char *name, int mode)
>   		strcat(filename, "/");
>   		strcat(filename, name);
>   		handle = dlopen(filename, mode);
> +		if (!handle)
> +			SNDERR("snd_dlopen: %s: %s", filename, dlerror());
>   		free(filename);
>   	}
>   	if (!handle)
>   		handle = dlopen(name, mode);
> +	if (!handle)
> +		SNDERR("snd_dlopen: %s: %s", name, dlerror());
>   	return handle;
>   #else
>   	return NULL;

In my opinion, this patch is preferable, however it can always generate 
superfluous error messages when handling hook configuration on 
'alsa.conf'. For example:

$ LD_PRELOAD=./src/.libs/libasound.so.2.0.0 amixer
ALSA lib dlmisc.c:85:(snd_dlopen) snd_dlopen: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
cannot open shared object file: No such file or directory
ALSA lib dlmisc.c:85:(snd_dlopen) snd_dlopen: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
cannot open shared object file: No such file or directory
ALSA lib dlmisc.c:85:(snd_dlopen) snd_dlopen: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
cannot open shared object file: No such file or directory
ALSA lib dlmisc.c:85:(snd_dlopen) snd_dlopen: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
cannot open shared object file: No such file or directory
ALSA lib dlmisc.c:85:(snd_dlopen) snd_dlopen: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
cannot open shared object file: No such file or directory
ALSA lib dlmisc.c:85:(snd_dlopen) snd_dlopen: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
/usr/lib/x86_64-linux-gnu/alsa-lib//./src/.libs/libasound.so.2.0.0: 
cannot open shared object file: No such file or directory
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [on]
...

When any hook configuration includes no lines with 'lib', 'snd_dlopen()' 
gets NULL as its first argument, then 'dlopen()' gets an inexistent path 
as its first argument, like:

(parsing alsa.conf)
snd_config_hooks_call()
   ->snd_dlopen(name = NULL)
     if (name == NULL)
       name = self
     filename = ALSA_PLUGIN_DIR + '/' + name
     dlopen(filename)
     (generate the error messages)

I don't know why alsa-lib is programmed as what it is, so have no idea 
to suggest better solution...

Additionally, your patch includes some issues of patch format:
* Not only your signature but also patch comment is required. The first
   line is interpreted as patch title, and the rest is as comment.
* Patches should be compliant to git-patch format. I encountered failure
   of 'git am' for this patch. Please use 'git format-patch' command to
   generate patches for posting.

When posting patches, please take care of the above.


Regards

Takashi Sakamoto
