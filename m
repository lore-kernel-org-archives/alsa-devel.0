From: "" <panbohui@hotmail.com>
Subject: different between "default" and "hw:0,0"?
Date: Tue, 28 Nov 2006 13:26:29 +0800
Message-ID: <BAY127-W126B9E39CB4FA3B9ED5A58C9E50@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1199481504=="
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

--===============1199481504==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable


Hi all,
I'm new to alsa, and get some confused with "default" device and and the
"hw:0,0" device, do they have any difference?
i write a very simple media player app, using xine-lib, i modify the
xine config file, set the "audio.device.alsa_front_device" value to
"hw:0,0".=20
i found that, when the value is "hw:0,0", the program can NOT run more
than one process at same time(I mean only one process can play
sound,others hang),
when the value set to "default", i can run more than one process, and
every app can play sound at same time.
so, it seems that, the "default" and he "hw0,0" are not same, and i
don't know the detail.

can anybody help me? thanks a lot!
Bhpan=20




_________________________________________________________________
=C2=CA=CF=C8=B3=A2=CA=D4 Windows Live Mail=A1=A3
http://ideas.live.com/programpage.aspx?versionId=3D5d21c51a-b161-4314-9b0=
e-4911fb2b2e6d


--===============1199481504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1199481504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1199481504==--
