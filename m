From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM Params
Date: Tue, 25 May 2004 07:42:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405251142.i4PBgLP0010364@dhin.linuxaudiosystems.com>
References: <20040525105028.39912.qmail@web25102.mail.ukl.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 25 May 2004 11:50:28 BST."
             <20040525105028.39912.qmail@web25102.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Hi ,
>i'm trying to change the fragment size that the alsa
>driver is capturing/playing out. It's currently set at
>32 msecs(256 bytes).
>They are set in the runtime structure...
>   runtime->period_max ...etc
>Could anybody tell me which file these parameters are
>set in the alsa-driver directory?

you should be using snd_pcm_hw_params_set_period_size()




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
