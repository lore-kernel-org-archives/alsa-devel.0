From: Dan Hollis <goemon@anime.net>
Subject: alsa 0.9.0rc2 trident incompatible with 2.4.19 pcigame?
Date: Mon, 16 Sep 2002 02:11:01 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209160158100.31525-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I can't seem to use kernel 2.4.19 pcigame (trident) joystick driver with 
0.9.0rc2.

I can load pcigame before alsa, but then alsa doesn't load.
I can load alsa before pcigame, but then pcigame doesn't load.

So I get joystick without sound, or sound without joystick.

gameport0: Trident Microsystems 4DWave NX at pci00:0b.0 speed 2840 kHz

It looks as though pcigame wants access to the same ioports that alsa
driver uses. So alsa needs to integrate trident joystick driver?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
