From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: Hammerfall (hdsp) initialization problem
Date: Sun, 25 Jul 2004 01:48:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090734488.3156.2.camel@modemcable182.55-70-69.mc.videotron.ca>
References: <1090607568.17750.7.camel@modemcable182.55-70-69.mc.videotron.ca>
 <20040724100520.26b4ac8f@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040724100520.26b4ac8f@laptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Blechmann <TimBlechmann@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> that's a known problem with the hdsp driver, a lot of continuous me=
mory
> has to be allocated, which can more likely be done on a freshly boo=
ted
> machine ...
> the best solution: keep the cardbus interface plugged into the slot=
 all
> the time ... if you start the computer, the memory will be allocate=
d

Actually, I suspect there's more than that. I've tried running a prog=
ram
that malloc()'s 1 GB of memory (the amount of RAM I have), writes to =
it
and then free()'s it, so there's lots of memory available after that.
Still doesn't work (and obviously there's lots of continuous memory
available).

=09Jean-Marc

--=20
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Universit=E9 de Sherbrooke




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
