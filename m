From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: USB quattro input quality
Date: Sat, 08 May 2004 12:58:31 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <409CD977.9000300@superbug.demon.co.uk>
References: <409B0D89.6090503@boosthardware.com> <20040507140321.28777db8@laptop> <409C687E.8010702@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <409C687E.8010702@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Tim Blechmann <TimBlechmann@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Tim Blechmann wrote:
> 
>>> Just wondering if anyone has found time to look into fixing the input 
>>> quality of the usb quattro?
>>>
>>> I'm not sure it has ever functioned perfectly for input quality.
>>>
>>> Currently I get a better sound quality from my $10 cmipci than my $400
>>>
>>> usb-quattro ;-P
>>>
>>> There is a constant crackle in the audio stream.
>>
>>
>> there is a thread on this on the alsa bugtracking system ... there is a
>> patch available, but it's not fully working for me...
>> using kernel 2.6.6rc2 with the patch to the usb subsystem to allow the
>> using of the quattro, i'll only have to restart alsa about once or
>> twice. (probably i still had problems with the alsa patch because of
>> kernel 2.6.6)
>>
> 
> 
> Thanks for the tip.
> 
> Just to confirm what I read in mantis. The quattro can only record in 
> big endian mode and playback in little endian?
> 
> How does this affect jackd?
> 
> AFAIK it's not possible to have dual modes while using jack...
> 
> 

kernel 2.6.6rc2 is very broken with respect to USB. Use 2.6.6rc3 or above.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
