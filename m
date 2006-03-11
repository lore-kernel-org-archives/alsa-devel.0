From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: pointer callback in pcm
Date: Sat, 11 Mar 2006 19:18:15 +0000
Message-ID: <1142104695.9496.35.camel@localhost.localdomain>
References: <1141942882.10937.5.camel@localhost.localdomain>
	 <1141952015.13319.90.camel@mindpipe>
	 <1142020261.9246.3.camel@localhost.localdomain>
	 <4412B17F.7080200@superbug.co.uk>
	 <1142076452.9496.8.camel@localhost.localdomain>
	 <4412F001.5020404@superbug.co.uk>
	 <1142098225.9496.25.camel@localhost.localdomain>
	 <44131B40.9080100@superbug.co.uk>
	 <1142104084.9496.34.camel@localhost.localdomain>
	 <441321E9.1050503@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <441321E9.1050503@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-03-11 at 19:15 +0000, James Courtier-Dutton wrote:

> >   
> Ok, that is not what is needed.
> The value returned should be the position of the ADC in the hardware's 
> ring buffer in units of frames.
> Not the cumulative number of samples played.
> E.g. If the buffer is 32768 frames long, the returned value should only 
> have a value from 0 to 32767
> Once it gets to 32767, it should then role over to 0 again.
> 
Yes, that's what I meant :) Sorry if I wasn't clear enough.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
