From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 31 Aug 2004 10:52:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408310852.i7V8qSKk023731@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www4.pobox.sk (www4.pobox.sk [212.5.216.14])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 40697266
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 10:52:29 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: atlka@pg.gda.pl, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Why not create some kind of sound server (again sound server :-)) with
alsa-lib API on both sides. Some combination of dmix and dsnoop.
I don't think that most of users needs low latency provided by dmix.
Most of users need software mixing, something to be able to do
upmixing (down mixing) from 2 -> 5.1 and ability to record in more
then 1 app and maybe bass/treble (equalizer). This server can use hw
mixing too, if it is provided by sound card. This can be like virtual
soundcard, but in userspace.

Still, you will be able to route output from this sound server to dmix
plugin.

I think, you can do this with alsa-lib API. Actually I started look
after this, but I don't have enought free time.

Later softmidi synth can by added too. If someone need something
better (low latency, ...), he can use hw directly.

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 najvacsi slovensky freemail=0A=0A=0A


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
