From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Mon, 17 Mar 2003 00:23:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E75075E.7030401@cucumelo.org>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net>
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
>2) A clicking sound (described by another user as "cards in a bike")  For the
>   times I get this sound, it's normally about 4-6 beats-per-second (or so), but
>   if I unmute "IEC958 Input" it nearly doubles (about 8-12 beats-per-second).
>  
>
Sounds like your receiver don't detect the AC3 stream, and inteprets it
like PCM instead. There can be many reasons why this hapen, right now I 
can mention:
- The AC3 is altered in some how, DSP applies gain's, roundings, while 
procesing stream (operation that are audible while playing PCM, and 
probably improbes sound),  then when the data reach the receiver it's 
not detected as AC3 anymore. In the current cs46xx driver there's a 
special treatment for 48khz streams through IEC958, to prevent the DSP 
process the stream in any way.
- The magic status bit's, I'm not sure if the current implementation in 
the cs46xx that
set's the IEC958 is correct. I have not found any way to verify ...


/Benny




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
