From: "Peter Heatwole" <peter599@gotnet.net>
Subject: RE: AC3 passthru intel8x0 + cs4299
Date: Mon, 24 Feb 2003 08:14:51 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <23f19f17f0ec46ae8dba94f4f2c2d68c.peter599@gotnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Zierath Bernd <B.Zierath@ebv.com>
List-Id: alsa-devel@alsa-project.org

From: Zierath Bernd
> 0x0200 should be the right bit for DAC power off register AC97_POWERDOWN
> (0x26), but where is the best place to set the bit=2E


   I would recommend looking into setting up a mixer function to enable/disa=
ble
the playback SRC, the DAC, and the /Audio bit=2E  This way you can use alsam=
ixer or
your mixer of choice to turn AC3 passthru on/off=2E
   You can set which functions handle muting/unmuting of each slider, so you=
 (in
theory) should be able to have a one function to setup the card for AC3 pass=
thru
when you unmute "AC3-Passthru" (or whatever you name the slider), and anothe=
r to
reconfigure the card for normal playback when you mute "AC3-Passthru"=2E
   Sorry, I'd help but finals in school just won't allow that=2E  (BTW, what=
 would be
the standard mixer name used for AC3 passthru?)


-- Peter Heatwole
"Murphy was just a well known pessimist=2E"



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
