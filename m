From: Paul Davis <pbd@op.net>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Sun, 14 Apr 2002 18:21:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16wsMV-0003ar-00@usw-sf-list1.sourceforge.net>
References: <3CB990F8.80509@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 14 Apr 2002 15:23:52 BST."
             <3CB990F8.80509@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James@superbug.demon.co.uk
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>framework for ALSA worked out, which is even more of a problem. Its
>>still unclear at this point whether the ALSA framework will be:
>>
>>      application<->alsa-lib<->alsa-driver<->low-level-ALSA-USB-class-driver
>>
>>OR
>>
>>      application<->alsa-lib<->low-level-non-ALSA-USB-class-driver
>>
>>the first one is easier to write, the second one is more flexible.
>>
>>--p
>>  
>>
>Is the biggest problem the need to get alsa to accept Plugable hardware. 
>E.g. USB.
>Does the current alsa architecture allow for hot plug and remove of 
>sound hardware ?

thats not an issue with ALSA. pluggable hardware is not part of
ALSA. it would be part of the kernel's handling of USB. at the moment,
ALSA doesn't support any interfaces that allow hot plugging, but i
can't think of anything in the codebase that would cause a problem. i
load and unload ALSA modules very often when i'm doing driver
development, which is isomorphous to handling hot-plugged devices.

whether or not the kernel's support for USB can deal with it, i have
no idea. i would be suprised if the answer was no.

the problem i alluded to is just one of making an architectural
decision. do you consider USB Audio devices to be best supported by a
kernel driver with a USB focus, or an ALSA focus? alsa-lib can handle
either, but in the former case (USB focus), more code has to be
written in user space, and the existing USB audio driver for OSS has
to be moved out of OSS and made more generic.

--p
