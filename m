From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: Re: PCM Params
Date: Tue, 25 May 2004 13:41:24 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040525124124.40022.qmail@web25104.mail.ukl.yahoo.com>
References: <200405251142.i4PBgLP0010364@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405251142.i4PBgLP0010364@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

 --- Paul Davis <paul@linuxaudiosystems.com> wrote: >
>Hi ,
> >i'm trying to change the fragment size that the
> alsa
> >driver is capturing/playing out. It's currently set
> at
> >32 msecs(256 bytes).
> >They are set in the runtime structure...
> >   runtime->period_max ...etc
> >Could anybody tell me which file these parameters
> are
> >set in the alsa-driver directory?
> 
> you should be using
> snd_pcm_hw_params_set_period_size()


Does this mean that i can change the period size
without recompiling the driver?
Im am not developing an ALSA application myself, just
trying to change the pcm parameters.
snd_pcm_hw_params_set_period_size()...looks like a
function call included in a user written ALSA
application??
Excuse me if this is a stupid questions but,How do I
use this function call in my case to change the driver
period??
Brian.


> 
>  


	
	
		
____________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
