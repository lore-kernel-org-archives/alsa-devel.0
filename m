From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] fix resamplers.
Date: Wed, 21 Jul 2004 19:06:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40FEB0BF.7000306@superbug.demon.co.uk>
References: <40FE8863.50009@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40FE8863.50009@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> The current pcm_rate.c tends to insert zero samples in the stream.
> 
> E.g. Downsampling from 48000 -> 16000
> Starts with a block of 2048, and has to create 682 samples.
> The current code sometimes only produces 681 samples, leaving the last 
> one zero.
> 
> The attached patch fixes this problem.
> 
> James
> 
> 

I have done more testing, and it does not quite fix everything.

James



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
