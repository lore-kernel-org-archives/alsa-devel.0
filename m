From: Florian Schmidt <mista.tapas@gmx.net>
Subject: alsaconf checking for OSS modules
Date: Fri, 23 Jul 2004 16:52:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040723165213.089db15b@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hi

i think quite a bit of trouble could be saved if the alsaconf script would check if any OSS modules are loaded. I think it's enough to spit out an error to the user. rmmod'ing them would fail in most cases anyways since users that use alsaconf usually run some desktop environment like kde or gnome, too. And these like to keep the modules busy with their mixer applets, sound servers, etc...

What do you guys think?

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
