From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Mon, 17 Mar 2003 01:10:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E751277.9080701@cucumelo.org>
References: <3c5cea10bbf24b49ad05e59b269b4d69.peter599@gotnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>   If I may ask, what are the "magic status bits"?  Are they the same as the
>AES bits?  Speaking of which, what's the use of the AES# bits?  I looked on the
>internet but couldn't find what these bits mean.  
>  
>
Sorry if I've made any confusion. What I meant was the IEC958 status 
bits, (AES0-AES3)
one posible reason why it dont works could be that code in the cs46xx 
driver that update the
status bits in not 100% correct.

>
>   On a sidenote, ac3dec never makes the clicking noise; only xine does that.
>But, I noticed that ac3dec always makes a click when I first start playing.
>Could this be a result of the different AES# configuration?
>  
>
What I know about the AES# configuration is that the _bit_ that really 
matters
is the bit that says that the stream is digital data, and not audio.

/Benny




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
