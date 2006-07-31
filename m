From: "Sergey Kolosov" <freeserj@gmail.com>
Subject: sound driver for "network" sound card
Date: Mon, 31 Jul 2006 16:50:19 +0400
Message-ID: <d39e2e70607310550l2a0e8768r13de1a1d1f3b5c57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1852817958=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1852817958==
Content-Type: multipart/alternative;
	boundary="----=_Part_56982_12957803.1154350219327"

------=_Part_56982_12957803.1154350219327
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I write some network application(it shall not only form sound packets, but
something yet) for network (sound) device and i nessesary playing sound over
it. For playing sound i shall send special network packets to device.

It  look :

usual sound application(alsa-lib functions)
||
\/
/dev/snd/dsp1 (alsa-driver)
||
\/
network application (special functions for sending sound over net)

So i see some solution for this problem:
1) Sound driver create new file of device "/dev/snd/snd_net1" and
application-agent  read  data from "/dev/snd/snd_net1" and send to network
special packets for device.
2) I add new ioctl to alsa driver (it is ideological right?) and recive data
over ioctl and send to network special packets for device.
3) Into alsa driver i make special network packtes and send it to network
sound device.

What solution is optimal?

------=_Part_56982_12957803.1154350219327
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I write some network application(it shall not only form sound packets, but something yet) for network (sound) device and i nessesary playing sound over it. For playing sound i shall send special network packets to device.<br>
<br>It&nbsp; look : <br><br>usual sound application(alsa-lib functions)<br>||<br>\/<br>/dev/snd/dsp1 (alsa-driver)<br>||<br>\/<br>network application (special functions for sending sound over net)<br><br>So i see some solution for this problem:
<br>1) Sound driver create new file of device &quot;/dev/snd/snd_net1&quot; and application-agent&nbsp; read&nbsp; data from &quot;/dev/snd/snd_net1&quot; and send to network special packets for device.<br>2) I add new ioctl to alsa driver (it is ideological right?) and recive data over ioctl and send to network special packets for device.
<br>3) Into alsa driver i make special network packtes and send it to network sound device.<br><br>What solution is optimal?<br>

------=_Part_56982_12957803.1154350219327--


--===============1852817958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1852817958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1852817958==--
