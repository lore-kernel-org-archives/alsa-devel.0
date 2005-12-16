From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Subject: No sound after cable replug with a VT8237R.
Date: Fri, 16 Dec 2005 12:13:57 -0200
Message-ID: <20051216121357.25ac14e2.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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


 Hi people,

 If I unplug and replug the headphone cable from a VIA VT8237R sound card
several times, the sound just stops. That card is handled by the snd-via82xx
driver.

 When it happens, I can see the sound player (eg, mplayer) still playing the
song, but there is no sound at all. I have to load the module again to have
the sound back.

 As far as we tested, the problem didn't happen with Windows XP Home.

 I tested with alsa-1.0.10 and 1.0.11rc1, it's 100% reproducible.

PS: Is there an open spec for that card?

-- 
Luiz Fernando N. Capitulino


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
