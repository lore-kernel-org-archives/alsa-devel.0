From: <pradeep.gane@wipro.com>
Subject: Usage of DMA descriptors with serializers....
Date: Sat, 7 Jan 2006 13:50:22 +0530
Message-ID: <107A57BFD3C21C4AB6EE147035A25DC70643F9@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C61362.D8D1EEBF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wip-cdctls-mx3.wipro.com (wip-cdctls-mx3.wipro.com [203.91.201.23])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9B6D13C
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 09:19:27 +0100 (MET)
Received: from wip-cdctls-mx3.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4BF7E29C018
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 13:49:25 +0530 (IST)
Received: from chn-snr-bh1.wipro.com (chn-snr-bh1.wipro.com [10.145.50.91])
	by wip-cdctls-mx3.wipro.com (Postfix) with ESMTP id 4095529C010
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 13:49:25 +0530 (IST)
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C61362.D8D1EEBF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,
=0D
I have a query.=0D
=0D
In my hardware if i have DMA descriptor functionality, how should i
design an ALSA driver.
=0D
1. I get trigger start from ALSA core module.
2. I configure the DMA descriptor and start the DMA for the PCM. Assume
that i still can configure further descriptors.
=0D
my questions are
=0D
1. First time alone, i fake an interrupt on period size.. but actually
the HW is still transferring data for the period size.
2. Can i call snd_pcm_period_elapsed API in interrupt handler, without
actually sending the data of period size. .
3. when pointer callback function is called i always say that i have
transferred one period size of data.
=0D
In my short sight, i see no problems..=0D
However, i thought of getting opinions from ALSA experts..
=0D
Thank you.
=0D
Best Regards,
Pradeep



The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you=
 are not the intended recipient, you should not disseminate, distribute or=
 copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments.=0D

WARNING: Computer viruses can be transmitted via email. The recipient=
 should check this email and any attachments for the presence of viruses.=
 The company accepts no liability for any damage caused by any virus=
 transmitted by this email.
=0D
www.wipro.com
------_=_NextPart_001_01C61362.D8D1EEBF
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>I have a=
 query.=0D
</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>In my=
 hardware if i=0D
have DMA descriptor functionality, how should i design an ALSA=0D
driver.</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>1. I get=
 trigger=0D
start from ALSA core module.</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>2. I=
 configure the=0D
DMA descriptor and start the DMA for the PCM. Assume that&nbsp;i still can=
=0D
configure further descriptors.</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>my=
 questions=0D
are</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>1. First=
 time alone,=0D
i fake an interrupt on period size.. but actually the HW is still=
 transferring=0D
data for the period size.</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=
=3D2>2.&nbsp;Can i call=0D
snd_pcm_period_elapsed API in interrupt handler, without actually sending=
 the=0D
data of period size. .</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>3. when=
 pointer=0D
callback function is called i always say that i have transferred one period=
 size=0D
of data.</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>In my=
 short sight, i=0D
see no problems.. </FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>However,=
 i thought=0D
of getting opinions from ALSA experts..</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>Thank=0D
you.</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial size=3D2>Best=0D
Regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D015190708-07012006><FONT face=3DArial=0D
size=3D2>Pradeep</FONT></SPAN></DIV></BODY></HTML>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you=
 are not the intended recipient, you should not disseminate, distribute or=
 copy this e-mail. Please notify the sender immediately and destroy all=
 copies of this message and any attachments. <br>
<br>
WARNING: Computer viruses can be transmitted via email. The recipient=
 should check this email and any attachments for the presence of viruses.=
 The company accepts no liability for any damage caused by any virus=
 transmitted by this email.<br>
 <br>
www.wipro.com<br>
</font></td></tr></table>
------_=_NextPart_001_01C61362.D8D1EEBF--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
