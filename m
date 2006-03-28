From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: audigy2 zs pcmcia: distorted sound output
Date: Tue, 28 Mar 2006 20:58:08 +0100
Message-ID: <44299550.5060300@superbug.co.uk>
References: <1143575306.26243.9.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1143575306.26243.9.camel@cmn3.stanford.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fernando Lopez-Lezcano wrote:
> Hi all, I'm again trying out an audigy2 zs pcmcia notebook soundcard
> that I had shelved a while back. It used to completely hang my machine
> when inserting it. It no longer does that which is good news! 
> 
> Regretfully I can only get very distorted sound out of it, no matter
> what volume level I use on all controls. Any recent fixes in the alsa
> tree for this? I'm running alsa 1.0.10 and a realtime preempt 2.6.15
> based kernel.
> 
> There are changes in the headphone output sound when I move the CD fader
> in alsamixer, weird. 
> 
> Anyone out there with experience with this card?
> Thanks.
> -- Fernando
> 

That was fixed on 21/12/2005 in the alsa cvs.
I.e. >= alsa-driver-1.0.11rc2.tar.bz2

So, 1.0.10 is not good.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
