From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: A suggestion for better resamplers in alsa.
Date: Sun, 10 Apr 2005 10:15:16 +0100
Message-ID: <4258EEA4.6030405@superbug.co.uk>
References: <s5h1x9qdcex.wl@alsa2.suse.de>	<Pine.HPX.4.33n.0504041709240.17949-100000@studcom.urz.uni-halle.de>	<s5hfyy6bjzm.wl@alsa2.suse.de>	<4252EDF9.6090608@superbug.co.uk>	<Pine.LNX.4.58.0504070946140.1763@pnote.perex-int.cz> <s5hr7hnj8c9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7hnj8c9.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>
>>I like this idea. This setup belongs to:
>>
>>snd_pcm_hw_params_set_rate_noresample()
> 
> 
> This feature would be nice especially also for the sound servers which
> do resampling by themselves.
> 

Ok, so how do we actually implement it. We need to be able to detect the
presence or absence of this function by the application at run time.
We can't exactly have an application call this function against an older
version of the lib that does not contain it.
I will look into adding the function anyway, and we can worry about the
runtime detection problem later.

James


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
