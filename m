From: =?gb2312?q?li=20Tom?= <tom374233@yahoo.com.cn>
Subject: C-Media Error: "No such device"
Date: Tue, 8 Apr 2003 11:37:24 +0800 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030408033724.24598.qmail@web15103.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-346634662-1049773044=:24596"
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
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--0-346634662-1049773044=:24596
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit


Hi all,

I downloaded alsa-driver-0.9.2. I followed the install guide. I meet a problem when "modprobe card". The following is the output:

------------------------------------

[root@localhost alsa-driver-0.9.2]# modprobe snd-cmipci

/lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o: init_module: No such device

Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.

You may find more information in syslog or the output from dmesg

/lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o: insmod /lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o failed

/lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o: insmod snd-cmipci failed

------------------------------------

I use Redhat 8.0 with kernel 2.4.18-14. My sound card is C-Media.  My sound card ID auto-detected by OSS is 0x434d X 0x4941.

Who know the reason or had meet the problem?

Thank you very much for any help!

Tom



---------------------------------
Do You Yahoo!?
"雅虎通网络KTV, 随时随地免费卡拉OK~~"
--0-346634662-1049773044=:24596
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<P>Hi all,</P>
<P>I downloaded <SPAN lang=EN-US style="FONT-SIZE: 10.5pt; FONT-FAMILY: 'Times New Roman'; mso-bidi-font-size: 12.0pt; mso-fareast-font-family: 宋体; mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-CN; mso-bidi-language: AR-SA">alsa-driver-0.9.2. I followed the install guide. I meet a problem when "modprobe card". The following is the output:</SPAN></P><SPAN lang=EN-US style="FONT-SIZE: 10.5pt; FONT-FAMILY: 'Times New Roman'; mso-bidi-font-size: 12.0pt; mso-fareast-font-family: 宋体; mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-CN; mso-bidi-language: AR-SA">
<P>------------------------------------</P>
<P></SPAN><SPAN lang=EN-US style="FONT-SIZE: 10.5pt; FONT-FAMILY: 'Times New Roman'; mso-bidi-font-size: 12.0pt; mso-fareast-font-family: 宋体; mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-CN; mso-bidi-language: AR-SA"><SPAN lang=EN-US>[root@localhost alsa-driver-0.9.2]# modprobe snd-cmipci</SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US>/lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o: init_module: No such device</SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US>Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.</SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US>You may find more information in syslog or the output from dmesg</SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US>/lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o: insmod /lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o failed<?xml:namespace prefix = o ns = "urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt"><SPAN lang=EN-US>/lib/modules/2.4.18-14/kernel/sound/pci/snd-cmipci.o: insmod snd-cmipci failed<o:p></o:p></SPAN></P>
<P>------------------------------------</P>
<P>I use Redhat 8.0 with kernel 2.4.18-14. My sound card is C-Media.&nbsp; My sound card ID auto-detected by OSS is 0x434d X 0x4941.</P>
<P>Who know the reason or had meet the problem?</P>
<P>Thank you very much for any help!</P>
<P>Tom</SPAN></P><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://rd.yahoo.com/mail_cn/tag/?http://cn.messenger.yahoo.com//chat/index.html
">"雅虎通网络KTV, 随时随地免费卡拉OK~~"</a>
--0-346634662-1049773044=:24596--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
