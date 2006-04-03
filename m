From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: alsa cvs broken
Date: Mon, 03 Apr 2006 14:47:51 +0100
Message-ID: <44312787.20608@superbug.co.uk>
References: <44310468.6080303@superbug.co.uk>	<s5hr74ec174.wl%tiwai@suse.de>	<44311356.1000108@superbug.co.uk>	<Pine.LNX.4.61.0604031438430.9509@tm8103.perex-int.cz>	<s5hlkumbz1t.wl%tiwai@suse.de>	<Pine.LNX.4.61.0604031458460.9509@tm8103.perex-int.cz> <s5hhd5aby4k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhd5aby4k.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> I must say that git looks too much "kernel" oriented and sometimes 
>> hard-to-use. Mercurial has my sympatics, because it uses Python (on other 
>> hand, it might imply some performance issues).
>>     
>
> AFAIK, no performance hit on hg due to python-scripting.
>
>
> Takashi
>   

hg seems pretty fast from what I have seen. We had a "battle" at the 
kernel summit, Linus driving git, Matt driving hg. It was fun to watch, 
as they each asked the other to try an operation, and compared speed and 
ease of use.
I would not say that is was particularly scientifically measured, but 
the main impression I got from it, is that git is good for reviewing 
code and deciding what get's included, hg is better for the source code 
developer.
I think both git and hg were as fast as CVS or SVN is now.
For example, hg has all the performance critical stuff written in C 
anyway! E.g. 3 way diff.

James




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
