From: =?gb2312?q?pony=20wang?= <zjupony2001@yahoo.com.cn>
Subject: ICH4 audio driver, SPDIF issues. I need your help!
Date: Sun, 3 Aug 2003 10:34:30 +0800 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030803023430.56043.qmail@web15002.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1932299275-1059878070=:54745"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-cvslog@lists.sourceforge.net, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--0-1932299275-1059878070=:54745
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit


-------- What I want to do?

I want to play a wave file (22050Hz, 2-ch) via SPDIF channel.

 

-------- What’s my problem?

I think the ICH4 audio controller can’t convert PCM data of 22050Hz to 48KHz. 

And the Codec can’t either (codec generally accept 3 sample rates: 32K, 44.1K, 48K).

 

-------- What’s my question?

* Is there any way to convert PCM data on audio controller side to 48K before being put to AC-Link? 

* The VIA 8235 audio Controller seems have the capability to convert PCM data to 48KHz before sending to AC-Link, but ICH4 seems hasn’t, isn’t it?

* How can I play PCM data like 22050Hz via SPDIF Channel? Shall I convert it to 48KHz before I send it to audio controller?

 

-------- What I have tried?

*My hardware: ICH4 (Audio Controller) + ALC650 (Codec) + Jazz Audio Decoder.

*I tried to carry 22050Hz PCM data on slot 3&4 with PO Channel, with the VRA bit (Codec register 2A[0]) on. And I told Codec to get SPDIF data on slot3&4 too (Codec register 2A[5:4], SPSA). I try to play PCM data via PO and SPDIF simultaneously. But only the PO channel works, the SPDIF only accept 48KHz, 44.1KHz and 32KHz data. So I can't hear anything in SPDIF channel for 22050 PCM data.

 

Thank you for your help! I'm expecting to your reply!



 

Sincerely,

Pony





---------------------------------
Do You Yahoo!?
暑期大片齐聚雅虎通 网络摄像头+雅虎通调频收音机等你来拿
--0-1932299275-1059878070=:54745
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>
<DIV>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">-------- What I want to do?<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">I want to play a wave file (22050Hz, 2-ch) via SPDIF channel.<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">-------- What’s my problem?<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">I think the ICH4 audio controller can’t convert PCM data of 22050Hz to 48KHz. <o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">And the Codec can’t either (codec generally accept 3 sample rates: 32K, 44.1K, 48K).<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">-------- What’s my question?<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">* Is there any way to convert PCM data on audio controller side to 48K before being put to AC-Link? <o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><FONT face="Times New Roman">* The VIA 8235 audio Controller seems have the capability to convert PCM data to 48KHz before sending to AC-Link, but ICH4 seems hasn’t, isn’t it?<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT face="Times New Roman" size=3>* How can I play PCM data like 22050Hz via SPDIF Channel? Shall I convert it to 48KHz before I send it to audio controller?</FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT face="Times New Roman" size=3></FONT></SPAN>&nbsp;</P><SPAN lang=EN-US><FONT face="Times New Roman">
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt; TEXT-ALIGN: left; mso-pagination: widow-orphan" align=left><FONT size=3><SPAN lang=EN-US>-------- What I have tried?</SPAN><SPAN lang=EN-US style="FONT-SIZE: 12pt; FONT-FAMILY: 'Arial Unicode MS'; mso-font-kerning: 0pt"><o:p></o:p></SPAN></FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT size=3><SPAN lang=EN-US>*My hardware: ICH4 (Audio Controller)&nbsp;+ ALC650 (Codec) + Jazz Audio&nbsp;Decoder.</SPAN><SPAN lang=EN-US style="FONT-SIZE: 12pt; FONT-FAMILY: 'Arial Unicode MS'; mso-fareast-font-family: 宋体"><o:p></o:p></SPAN></FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT size=3><SPAN lang=EN-US>*I tried to carry 22050Hz PCM data on slot 3&amp;4 with PO Channel, with the VRA bit&nbsp;(Codec register 2A[0]) on. And I told Codec&nbsp;to&nbsp;get SPDIF data on slot3&amp;4 too (Codec register 2A[5:4], SPSA). I try to play PCM data via PO and SPDIF simultaneously. But&nbsp;only the PO channel works,&nbsp;the SPDIF only accept 48KHz, 44.1KHz and 32KHz data. So I can't hear anything in SPDIF channel for 22050 PCM data.</SPAN><SPAN lang=EN-US style="FONT-SIZE: 12pt; FONT-FAMILY: 'Arial Unicode MS'; mso-fareast-font-family: 宋体"><o:p></o:p></SPAN></FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT size=3><SPAN lang=EN-US>&nbsp;</SPAN><SPAN lang=EN-US style="FONT-SIZE: 12pt; FONT-FAMILY: 'Arial Unicode MS'; mso-fareast-font-family: 宋体"><o:p></o:p></SPAN></FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><FONT size=3><SPAN lang=EN-US>Thank you for your help! I'm expecting to your reply!</SPAN><SPAN lang=EN-US style="FONT-SIZE: 12pt; FONT-FAMILY: 'Arial Unicode MS'; mso-fareast-font-family: 宋体"><o:p></o:p></SPAN></FONT></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT size=3><o:p></o:p></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"></FONT></SPAN><SPAN lang=EN-US><FONT face="Times New Roman" size=3></FONT></SPAN>&nbsp;</P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT face="Times New Roman" size=3>Sincerely,</FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US><FONT face="Times New Roman" size=3>Pony</FONT></SPAN></P></DIV></DIV><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://cn.rd.yahoo.com/mail_cn/tag/?http://cn.promo.yahoo.com/minisite/messenger1/" target=blank>暑期大片齐聚雅虎通 网络摄像头+雅虎通调频收音机等你来拿</a>
--0-1932299275-1059878070=:54745--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
