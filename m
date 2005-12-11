From: Paul Lake <knowdet@yahoo.com>
Subject: Capture program
Date: Sun, 11 Dec 2005 12:43:21 -0800 (PST)
Message-ID: <20051211204321.40817.qmail@web32107.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-686540575-1134333801=:35977"
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

--0-686540575-1134333801=:35977
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

I wrote a capture program, but i wanted to add overrun handling for synch=
ronization. My goal was to get the frames number (available + not-availab=
le frames due to overrun).
I tried snd_pcm_delay() call, but the return value was always 1 during an=
 overrun. Another attempt was to use snd_pcm_avail_update(), which gave b=
ack results more then the buffer size, but i'm not sure if it's correct c=
onsidering my goal. If it's not right, what do i do?

Thank is advance!

ps.: mmap access is used by the program

		=09
---------------------------------
Yahoo! Shopping
 Find Great Deals on Holiday Gifts at Yahoo! Shopping=20
--0-686540575-1134333801=:35977
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>I wrote a capture program, but i wanted to add overrun handling=
 for synchronization. My goal was to get the frames number (available + n=
ot-available frames due to overrun).<br>I tried snd_pcm_delay() call, but=
 the return value was always 1 during an overrun. Another attempt was to =
use snd_pcm_avail_update(), which gave back results more then the buffer =
size, but i'm not sure if it's correct considering my goal. If it's not r=
ight, what do i do?<br><br>Thank is advance!<br><br>ps.: mmap access is u=
sed by the program<br><p>
=09
		<hr size=3D1>Yahoo! Shopping<br>=20
Find Great Deals on Holiday Gifts at <a href=3D"http://us.rd.yahoo.com/ma=
il_us/footer/shopping/*http://shopping.yahoo.com/;_ylc=3DX3oDMTE2bzVzaHJt=
BF9TAzk1OTQ5NjM2BHNlYwNtYWlsdGFnBHNsawNob2xpZGF5LTA1=20
">Yahoo! Shopping</a>=20
--0-686540575-1134333801=:35977--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
