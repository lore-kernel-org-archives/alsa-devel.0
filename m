From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: period crossing page boundary
Date: Thu, 20 Mar 2003 10:04:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030320100439.pochini@shiny.it>
References: <Pine.LNX.4.44.0303192113420.1351-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303192113420.1351-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


>> They are different:
>>
>> [aplay <no options> track.wav]
>> Mar 19 19:21:23 localhost kernel: pcm_hw_params (bufsize=88200 periods=3
>> persize=22052)
>>
>> bufsize==88200 != 3*22052 == 66156
>
> Note that there is no guarantee that the periods == integer value.
> If your hardware doesn't allow to set period_size and buffer_size
> independently (if buffer_size must be multiple of period_size) then put
> this code to the open callback:
>
>         if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
>                 return err;
>
> See alsa-kernel/pci/via82xx.c for an example.
>
> In other cases, runtime->buffer_size MUST BE USED.


Ok, but how do I build the sg list when bufsize!=sz*periods ? Take
the example above: have I to build 4 periods and let the last one
smaller than 22052 ?


Bye.



-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
