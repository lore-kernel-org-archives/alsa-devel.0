From: "Ash Willis" <ashwillis@programmer.net>
Subject: problem with driver
Date: Mon, 06 Sep 2004 07:26:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040906122604.EAC9E4BDA8@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi guys, i'm in need of a tiny bit of help...

I've been working on a driver. When playing sound, there are gaps and apl=
ay complains of underuns.
There is a problem that i need to correct, regarding calculating the corr=
ect dma position.
This isn't the problem for me BUT when playing back the driver calls pcm_=
trigger (start) and pcm_trigger(stop) throughout the playback process...
So when it triggers pcm start, the card resets it's counter and any query=
 to the corresponding register is then deemed pointless because it will a=
lways return 0 (every time the interrupt routine is called, pcm_trigger (=
start) has just been called).

Any help?

Thanks a lot for you time and i hope i've been clear enough :s

Ash
--=20
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
