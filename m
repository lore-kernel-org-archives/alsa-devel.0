From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: SND_PCM_OPEN_PLAYBACK & SND_PCM_OPEN_CAPTURE
Date: Wed, 13 Aug 2003 11:18:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308131518.h7DFIJuZ011589@localhost.localdomain>
References: <1060786583.30084.1.camel@linuxzone>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "13 Aug 2003 16:56:23 +0200."
             <1060786583.30084.1.camel@linuxzone>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Damien Sandras <dsandras@seconix.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> note that some cards (the early SB series come to mind) will not
>> support the same parameters for playback and capture when opened for
>> duplex usage, so it can a bit more complex than you'd really like.
>> 
>
>How can I determine that and solve that problem? Is there a source code
>example that I could look at?

you can only find out by trying it.

if you always open "plughw:N" (where N is going to be 0 for most
users, since most people have only soundcard), this won't matter,
because a "plughw" device will support (almost) any parameters you
use. 

the limitations of the hardware only matter if you try to open "hw:N",
which will expose the stupid (cheap) design of the soundcard. there is
no workaround for "hw" device other than to use a "plughw" device
instead. 

--p




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
