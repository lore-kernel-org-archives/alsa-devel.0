From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: A suggestion for better resamplers in alsa.
Date: Tue, 12 Apr 2005 13:24:14 +0100
Message-ID: <425BBDEE.4@superbug.co.uk>
References: <s5h1x9qdcex.wl@alsa2.suse.de> <Pine.HPX.4.33n.0504041709240.17949-100000@studcom.urz.uni-halle.de> <s5hfyy6bjzm.wl@alsa2.suse.de> <4252EDF9.6090608@superbug.co.uk> <Pine.LNX.4.58.0504070946140.1763@pnote.perex-int.cz> <s5hr7hnj8c9.wl@alsa2.suse.de> <4258EEA4.6030405@superbug.co.uk> <Pine.LNX.4.58.0504121410240.3045@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0504121410240.3045@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>I just tried to implement this function. Please, could you test 
>snd_pcm_hw_params_set_rate_resample() function (in current CVS)?
>
>						Jaroslav
>  
>
Why not s/resample/no_resampling/  ?

I.e. There should really be the word "no" in there somewhere because we 
are asking for no resampling to take place.

I assume this is called before one calls snd_pcm_set_rate()  ?

If I get time, I will try to test this tonight.

James




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
