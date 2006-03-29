From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ALSA sample rate conversion and general	performance
 improvements.
Date: Wed, 29 Mar 2006 16:07:12 +0100
Message-ID: <442AA2A0.1010500@superbug.co.uk>
References: <4429C5A4.7@superbug.co.uk> <s5hirpx6256.wl%tiwai@suse.de>	<442A5B80.3010706@superbug.co.uk> <1143643959.3402.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1143643959.3402.47.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> On Wed, 2006-03-29 at 11:03 +0100, James Courtier-Dutton wrote:
>   
>> Takashi Iwai wrote:
>>     
>>> At Wed, 29 Mar 2006 00:24:20 +0100,
>>> James Courtier-Dutton wrote:
>>>   
>>>       
>>>> Hi,
>>>>
>>>> I have had some conversations with various people regarding some general
>>>> problems some audio developers have with the current ALSA sound model.
>>>>         
>
> Hi James. Not me by any chance? :)
>   
You were one of them yes. You seemed to explain it a bit better than 
other people have. I mulled over the ideas this weekend and decided that 
it would be a move in the right direction for ALSA. It would help us out 
with the current resampling problems. It might complicate error 
recovery, but I am sure we can overcome those in time. So long as we can 
still reliably detect xruns, I am all for the changes. Now, what to do 
after an xrun happens is quite another issue, but detection of it is 
certainly required.

James




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
