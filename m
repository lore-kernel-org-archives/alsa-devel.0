From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [ardour-dev] Re: Tascam US-224/428 MMC: Work in progress...
Date: Wed, 28 Jul 2004 13:35:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407281735.i6SHZo1N003338@localhost.localdomain>
References: <200407281653.i6SGrMZn032601@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 28 Jul 2004 12:53:22 EDT."
             <200407281653.i6SGrMZn032601@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, alsa-devel@lists.sourceforge.net, ardour-dev <ardour-dev@lists.ardour.org>
List-Id: alsa-devel@alsa-project.org

>>If only ardour would actually send that missed MMC-Play command, the LED
>
>It will be fixed in CVS by the end of the day.

ahem. libs/ardour/session_transport.cc:740

so, it already does attempt to send this, but only if it has been
requested via the options dialog.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
