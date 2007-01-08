From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: Re: question about implicit decl in pcm_direct.c
Date: Mon, 08 Jan 2007 16:35:27 +0100
Message-ID: <45A264BF.3@purplelabs.com>
References: <45A25811.7040603@purplelabs.com> <s5hy7odv8qr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7odv8qr.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 08 Jan 2007 15:41:21 +0100,
> Benoit Fouet wrote:
>   
>> when compiling, i got:
>>
>> pcm_direct.c:898: warning: implicit declaration of function
>> `snd_pcm_hw_params_set_format_first'
>> I don't know how to fix it properly, so i ask if someone knows :)
>>     
>
> The patch below should fix.  Give it a try.
>   
it fixes (at least the compilation warning ;) )

>> there is also another warning about a comparison between int and
>> unsigned int that i "fixed" like in the attached patch.
>>     
> Well, this is a kind of GCC bug (not 100% but partially).
> I guess the latest version of gcc won't complain about it.
>
>   
ok, i can't try latest gcc's version, though.

Thanks,
Ben

> Takashi
>
> diff -r 8803655da809 src/pcm/pcm_direct.c
> --- a/src/pcm/pcm_direct.c	Mon Jan 08 15:07:02 2007 +0100
> +++ b/src/pcm/pcm_direct.c	Mon Jan 08 15:46:46 2007 +0100
> @@ -895,7 +895,7 @@ int snd_pcm_direct_initialize_slave(snd_
>  		}
>  		if (ret < 0 && dmix->type != SND_PCM_TYPE_DMIX) {
>  			/* TODO: try to choose a good format */
> -			ret = snd_pcm_hw_params_set_format_first(spcm, hw_params, &format);
> +			ret = INTERNAL(snd_pcm_hw_params_set_format_first)(spcm, hw_params, &format);
>  		}
>  		if (ret < 0) {
>  			SNDERR("requested or auto-format is not available");
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
