From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: trigger problems.
Date: Sat, 17 Jul 2004 23:37:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40F9AA18.7030905@superbug.demon.co.uk>
References: <40F52C9D.60704@superbug.demon.co.uk> <s5h7jt6afbe.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jt6afbe.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> 
> We can do it with linked substreams.
> For example, see ice1724 driver (snc_ice1724_pcm_trigger).
> 
> Basically, the trigger callback checks each substream belonging to the
> called substream via snd_pcm_group_for_each().  If it's one of yours,
> stamp it via snd_pcm_trigger_done(), so that the trigger callback to
> this substream will be skipped.
> 
> BTW, both two cases above can coexist.
> ice1724 drivers has two PCM devices, one for multi-channel up to 8 and
> another for three indepdent 2ch-stereo streams.
> 
> 
> Takashi
> 
> 

Thanks for the info. I implemented it, so that there is only one trigger 
register access for all 3 substreams, but even that did not help. I 
still have multiple interrrupts. I suppose it was worth a try.

I will have to think of something else.

Thanks

James


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
