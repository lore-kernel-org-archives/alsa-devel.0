From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ring buffer pointer accuracy.
Date: Mon, 14 Jul 2003 15:51:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F12C37F.4020402@superbug.demon.co.uk>
References: <3F0D86D0.6040905@superbug.demon.co.uk>	<20030711172808.694df05b.pochini@shiny.it> <s5hd6gduqpu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6gduqpu.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 11 Jul 2003 17:28:08 +0200,
> Giuliano Pochini wrote:
> 
>>On Thu, 10 Jul 2003 16:31:28 +0100
>>James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
>>
>>
>>>Hi,
>>>
>>>When an application reads the "avail" or "delay" pcm values: -
>>>1) how accurate are they?
>>>2) does the accuracy depend on the sound card driver being used.
>>
>>Worst case accuracy is about one period AFAIK. It depends on the sound chip
>>because the low level driver reads the DMA pointer (or something) from some
>>hardware register or it can know the DMA pointer when it receives an interrupt
>>at the end of a period.
> 
> 
> yes.  if the accuracy is in period size, at least it should work
> somehow.  e.g. the time-slider of a player might not move so smooth
> but it must not be critical.
> 
> 
> Takashi
> 
> 
I would like some idea of how accurate the snd_pcm_delay() result is 
likely to be. If I am trying to syncronise video to audio, and I notice 
a difference between audio and video, I need to know how accurate I can 
make it.
If some cards only update "delay" once per period, but others update it 
all the time, I would like the application to know about it, so it can 
decide how accurately it can actually get audio and video in sync.
I.e. On some cards it would only correct for sync if it is off by 1 
period or more, but with other audio cards it could be sample accurate.
I have a sb live audio card and it seems to update with sample accuracy.

Cheers
James




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
