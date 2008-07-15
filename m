From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Still have choppy audio using 1.0.17
Date: Tue, 15 Jul 2008 08:56:21 -0300
Message-ID: <487C9065.9080800@tet.com.br>
References: <4856C768.1060404@tet.com.br>	<485952C5.30307@tet.com.br>	<485965B0.9020102@tet.com.br>	<485A58A1.6040002@tet.com.br>	<48622AF1.3000304@tet.com.br>	<s5hprq5qz2t.wl%tiwai@suse.de>	<486A7757.4060907@tet.com.br>	<486E1A26.1030802@tet.com.br>	<487B9379.5030200@tet.com.br>
	<487BF452.2090301@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id AA283243D4
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 13:56:26 +0200 (CEST)
In-Reply-To: <487BF452.2090301@cox.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

stan escreveu:
> Gustavo da Silva Serra wrote:
>   
>> I have discovered something else. Choppy audio occurs when 
>> snd_pcm_playback_silence, in pcm_lib.c, will silence the same period 
>> than the capture pointer is pointing at. I am printing this variables 
>> "ofs" in snd_pcm_playback_silence and what is returned from 
>> snd_card_loopback_pointer when the substream is capture.
>>
>> How snd_pcm_playback_silence is supposed to work? Must it silence the 
>> next period from the playback pointer? How is ensured that this 
>> situation (ofs == capture pointer) does not happen with sound cards?
>>
>> Thanks ANY help... any...
>>
>>     
> The way the API docs describe it the silence function 
> fills the play buffer with a set amount of silence when 
> the buffer has fewer than threshold frames to play. 
> So, if your playback is running close to that 
> threshold, it will be continuously injecting chunks of 
> silence into the stream.  That would certainly sound 
> choppy.  From the docs it sounds like the silence is 
> always injected into the existing stream at the current 
> pointer.
>
> Note:  this is just from reading the docs.  I haven't 
> actually used this.

I don't know if the silence function snd_pcm_playback_silence is the 
same from alsa library. It uses the threshold, but it is not clear for 
me how. It seems that this function clears the buffer for the new stream 
arriving, because, from time to time, it silences a whole period.

Thanks for the attention :)
