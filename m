From: Ferenc Wagner <wferi@afavant.elte.hu>
Subject: Re: alsaconf checking for OSS modules
Date: Mon, 26 Jul 2004 14:03:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ok6wrc6ww.fsf@tba.elte.hu>
References: <20040723165213.089db15b@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040723165213.089db15b@mango.fruits.de> (Florian Schmidt's
 message of "Fri, 23 Jul 2004 16:52:13 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Florian Schmidt <mista.tapas@gmx.net> writes:

> i think quite a bit of trouble could be saved if the
> alsaconf script would check if any OSS modules are loaded.
> I think it's enough to spit out an error to the user.

Yes, definitely.  The alsaconf behaviour is somewhat
confusing as it correctly identifies the card and then fails
to load the modules showing the error message from a couple
of seconds only.
-- 
Feri.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
