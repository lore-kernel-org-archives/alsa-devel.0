From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ICH4 audio driver, SPDIF issues. I need your help!
Date: Sun, 03 Aug 2003 10:02:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F2CCF9F.2020208@superbug.demon.co.uk>
References: <20030803023430.56043.qmail@web15002.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030803023430.56043.qmail@web15002.mail.bjs.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pony wang <zjupony2001@yahoo.com.cn>
Cc: alsa-cvslog@lists.sourceforge.net, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

pony wang wrote:
> -------- What I want to do?
> 
> I want to play a wave file (22050Hz, 2-ch) via SPDIF channel.
> 
>  
> 
> -------- What’s my problem?
> 
> I think the ICH4 audio controller can’t convert PCM data of 22050Hz to 
> 48KHz.
> 
> And the Codec can’t either (codec generally accept 3 sample rates: 32K, 
> 44.1K, 48K).
> 
>  
> 
> -------- What’s my question?
> 
> * Is there any way to convert PCM data on audio controller side to 48K 
> before being put to AC-Link?
> 
> * The VIA 8235 audio Controller seems have the capability to convert PCM 
> data to 48KHz before sending to AC-Link, but ICH4 seems hasn’t, isn’t it?
> 
> * How can I play PCM data like 22050Hz via SPDIF Channel? Shall I 
> convert it to 48KHz before I send it to audio controller?
> 
>  
> 
> -------- What I have tried?
> 
> *My hardware: ICH4 (Audio Controller) + ALC650 (Codec) + Jazz Audio Decoder.
> 
> *I tried to carry 22050Hz PCM data on slot 3&4 with PO Channel, with the 
> VRA bit (Codec register 2A[0]) on. And I told Codec to get SPDIF data on 
> slot3&4 too (Codec register 2A[5:4], SPSA). I try to play PCM data via 
> PO and SPDIF simultaneously. But only the PO channel works, the SPDIF 
> only accept 48KHz, 44.1KHz and 32KHz data. So I can't hear anything in 
> SPDIF channel for 22050 PCM data.
> 
>  
> 
> Thank you for your help! I'm expecting to your reply!
> 
>  
> 
> Sincerely,
> 
> Pony
> 
Resample the 22050Hz PCM to 48000Hz before sending it to the sound 
device. For example: The audio application xine (xine.sf.net) can do 
this. Just set the "force rate" config item to 480000.
Alsa's resamplers might be also be able to do this translation, if the 
low level hardware driver is telling the upper layers the correct 
information.

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
