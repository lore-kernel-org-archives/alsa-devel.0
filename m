From: a b <videbimusne@yahoo.com>
Subject: Sending emu10k1 CD analog input to rear output.
Date: Fri, 14 Jul 2006 23:21:42 -0700 (PDT)
Message-ID: <20060715062142.56633.qmail@web61222.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0080840208=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from web61222.mail.yahoo.com (web61222.mail.yahoo.com
	[209.73.179.56])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 606BE226
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 08:21:58 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0080840208==
Content-Type: multipart/alternative; boundary="0-1890924111-1152944502=:56400"
Content-Transfer-Encoding: 7bit

--0-1890924111-1152944502=:56400
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:
    I'm trying fix the problem with the emu10k1 driver where the CD analo=
g input is only sent to the front output. I've tried the obvious - duplic=
ating the AC97 inputs in emufx.c -but that didn't change anything. I also=
 tried switching the front and rear outputs. Does anybody know where the =
CD input is handled? I thought it should be in the emu10k1 bytecode, but =
I can't seem to find where.

Thanks,
    Brian

 	=09
---------------------------------
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rat=
es starting at 1=A2/min.
--0-1890924111-1152944502=:56400
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:<br>&nbsp;&nbsp;&nbsp; I'm trying fix the problem with the emu10k1 =
driver where the CD analog input is only sent to the front output. I've t=
ried the obvious - duplicating the AC97 inputs in emufx.c -but that didn'=
t change anything. I also tried switching the front and rear outputs. Doe=
s anybody know where the CD input is handled? I thought it should be in t=
he emu10k1 bytecode, but I can't seem to find where.<br><br>Thanks,<br>&n=
bsp;&nbsp;&nbsp; Brian<br><p>&#32;
		<hr size=3D1>Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone ca=
lls. <a href=3D"http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://=
us.rd.yahoo.com/evt=3D39666/*http://messenger.yahoo.com"> Great rates sta=
rting at 1=A2/min.
--0-1890924111-1152944502=:56400--


--===============0080840208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0080840208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0080840208==--
