From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Sun, 14 Apr 2002 15:23:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CB990F8.80509@superbug.demon.co.uk>
References: <200204141306.g3ED6wX27769@post2.fast.net>
Reply-To: James@superbug.demon.co.uk
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

>>This is a multi-part message in MIME format...
>>    
>>
>
>AKA: This is a message in which the content is about 2% of the message
>body :)
>
>  
>
>>I'm trying to get some specs from midiman for the usb quattro. They have asked
>>this question. Can anyone fill me in so I can relay the info?
>>    
>>
>
>  
>
>>Is there "class driver" support under Linux?
>>    
>>
>
>I suspect he means something like "audio class", "printer class",
>etc. The answer is yes, sort of. What we have right now is a single
>USB audio driver for OSS that attempts to implement the audio class
>and also contains the inevitable long list of per-device hacks needed
>to work around the fact that almost no manufacturer fully complies
>with the class specification.
>
>However, its for OSS, which is a problem, and we don't yet have a USB
>framework for ALSA worked out, which is even more of a problem. Its
>still unclear at this point whether the ALSA framework will be:
>
>      application<->alsa-lib<->alsa-driver<->low-level-ALSA-USB-class-driver
>
>OR
>
>      application<->alsa-lib<->low-level-non-ALSA-USB-class-driver
>
>the first one is easier to write, the second one is more flexible.
>
>--p
>  
>
Is the biggest problem the need to get alsa to accept Plugable hardware. 
E.g. USB.
Does the current alsa architecture allow for hot plug and remove of 
sound hardware ?

Cheers
James



>  
>
