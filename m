From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Fixes ac3 passthru non-audio bit setting
 for AC97 codecs.
Date: Thu, 14 Aug 2003 18:44:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F3BCA62.6090701@superbug.demon.co.uk>
References: <3F3BA7B3.3010901@superbug.demon.co.uk> <s5h8ypwfcmb.wl@alsa2.suse.de> <20030814164913.GA31684@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030814164913.GA31684@magma.unil.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@magma.unil.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Gregoire Favre wrote:
> On Thu, Aug 14, 2003 at 06:05:48PM +0200, Takashi Iwai wrote:
> 
> 
>>>The problem I was having was that the spdif "non-audio" bit was not 
>>>being set.
>>>This patch fixes that problem.
>>
>>thanks, now applied to cvs.
> 
> 
> Is there any hope to do the same for the cs46xx?
> 
> Thank you very much,
> 
> 	Grégoire
> __________________________________________________________________
> http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
> 
> 
I don't know if I can help or not, because I don't have that sound card.
If you can send me the output of :-
lspci -v
lspci -vn
alsamixer  <- What is the name of the Card: and Chip: ?

I will see what I can do.

Cheers
James




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
