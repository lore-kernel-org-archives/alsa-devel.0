From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: TRAM on Audigy
Date: Mon, 07 Jul 2003 11:22:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F0949FC.30408@superbug.demon.co.uk>
References: <200307070719.JAA06549@www1.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307070719.JAA06549@www1.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

p z oooo wrote:
> Hi,
> 
> I wanted to add support for TRAM on Audigy to emu10k1 driver.
> I look (tryed) at OSS driver and found that TRAM is not working 
> too. :-(
> 
> Then I use trial and error method and found how to setup TRAM on 
> Audigy. I know how to read from and write to TRAM in EMU10k2 DSP 
> program but not more.
> Is there any documentation on using TRAM on Audigy, or am I only one 
> (except Creative and Creative NDA signer) who know how to use TRAM on 
> Audigy ???
> 
> I need more info on how is TRAM working on SB Live:
> TANKMEMADDRREG_CLEAR - Clear tank memory
> TANKMEMADDRREG_ALIGN - Align read or write relative to tank access
> TANKMEMADDRREG_WRITE - Write to tank memory
> TANKMEMADDRREG_READ - Read from tank memory
> 
> Please help
> 
> Peter Zubaj
> 
> PS: If no one knows more, I will make patch against current CVS and 
> send it to this list. (mayby AC3 passthrough using TRAM will work 
> too :-))
> 
> 
I heard that one will not have to do TRAM AC3, one can just select a 
different interpolator (A special NULL interpolor). I have not tested my 
self, but I saw emails about it about 1 year ago.
I think that it is just old SB Live cards that need the TRAM method.
Cheers
James




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
