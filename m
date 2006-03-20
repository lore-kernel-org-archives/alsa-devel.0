From: Rimas Kudelis <rq@akl.lt>
Subject: Re: More detailed Acer (Intel HDA)
Date: Mon, 20 Mar 2006 08:50:14 +0200
Message-ID: <441E50A6.3030100@akl.lt>
References: <441D52F3.9010107@akl.lt> <1142793842.4532.28.camel@mindpipe>	 <441DE71F.7080209@akl.lt> <1142814150.4532.45.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1257; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142814150.4532.45.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hola,
>>>> I asked a user on Ubuntu forums to test Acer jack modes more
>>>> extensively. The results are a bit surprising. You may want to check
>>>> out http://ubuntuforums.org/showthread.php?p=825101#post825101.
>>>>         
>>> Breezy is too old, that driver had many bugs fixed lately.  How does it
>>> work with the latest ALSA CVS version?
>>>       
>> He IS using the latest ALSA CVS version with Breezy. ;) That's why the
>> sound does work for him. Just some of the details of HOW it works are
>> quite interesting...
>>     
> That thread is too long.  Please describe briefly exactly what the
> unexpected behavior is and how you think it should work and file an ALSA
> bug report.
>   

That thread was started long before the acer model was actually added to
hda-intel driver. Everything that I find unexpected is written in the
exact post I linked to.

I'm not going to file a bug. Just asking for Jonathan's opinion about
this (i.e., why doesn't LINE-OUT allow choosing Mic modes, but allows
Line In). After I check everything, i'm willing to write a small patch
that removes all non-working features (like CD and Beep controls) from
the current acer model and, maybe, adds one or two that are not
currently in.

Rimas




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
