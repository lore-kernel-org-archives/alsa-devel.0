From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Possible bug in alsa-lib. snd_pcm_hw_params_get_periods_max()
 returning 512 instead of 2.
Date: Fri, 11 Jun 2004 16:07:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C9CA9E.4030207@superbug.demon.co.uk>
References: <Pine.HPX.4.33n.0406111651150.18177-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8F9AE1E5
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2004 17:07:13 +0200 (MEST)
In-Reply-To: <Pine.HPX.4.33n.0406111651150.18177-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> James Courtier-Dutton wrote:
> 
>>I cannot think of any circumstances where doing sample rate conversion
>>(using the "plug:" plugin) would change the amount of periods.
>>Is this a bug in the "plug:" plugin ?
> 
> 
> Works as designed, I guess.  It's the job of the plug plugin to remove
> hardware limitations, just in case an application wants to use 42
> periods.
> 
> 
> Regards,
> Clemens
> 

Ok, well the "design" is not working, because with the "plug:", I still 
can only ever get 2 periods. i.e. If I set period_size to 1024, the 
buffer_size can only be set to 2048, when in fact I wanted to set the 
buffer_size to 8192. i.e. I wanted 8 periods, but "plug:" forced me to 
have 2, just like the hardware can do.

So, I conclude from this that the "plug:front" cannot handle a different 
amount of periods than "front".

I think that "plug:" works fine for sample rate and sample format 
conversions, but seems to fail on the number of periods adaptions.

James


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
