From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [ardour-dev] Re: Tascam US-224/428 MMC: Work in
     progress...
Date: Wed, 28 Jul 2004 20:56:25 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32925.192.168.1.5.1091044585.squirrel@192.168.1.5>
References: Your message of "Wed, 28 Jul 2004 12:53:22 EDT."            
    <200407281653.i6SGrMZn032601@localhost.localdomain>
    <200407281735.i6SHZo1N003338@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407281735.i6SHZo1N003338@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net, ardour-dev <ardour-dev@lists.ardour.org>
List-Id: alsa-devel@alsa-project.org

Hi Paul,

>>> If only ardour would actually send that missed MMC-Play command,
>>
>>It will be fixed in CVS by the end of the day.
>
> ahem. libs/ardour/session_transport.cc:740
>
> so, it already does attempt to send this, but only if it has been
> requested via the options dialog.
>

I have come across that line, that's why I said it was supposed to send
that MMC-DeferredPlay, but it doesn't actually do so.

Surely I've always checked that MIDI/'Send MMC' option on the options
dialog. Is there any other option you're referring to?

Cheers!
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
