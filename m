From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Line6 TonePort
Date: Thu, 10 Aug 2006 18:19:33 +0200
Message-ID: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0540846800=="
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============0540846800==
Content-Type: multipart/alternative;
	boundary="----=_Part_26243_31356797.1155226773137"

------=_Part_26243_31356797.1155226773137
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I hope this is the last time I write but I don't think so.
The problem is quite simple: this USB card does not support DMA transfers
(yes, seems impossible but that's what it is), so a support for this sound
card is difficult to obtain working on the snd-usb-audio module, Takashi
told me to use an intermediate buffer, but I really don't know how to do it.
Should I copy data from the buffer (playback) on usb transfer completition
callbacks? But in such case isn't it the same to just copy data into the
urb's transfer buffer?
I tried to avoid using this buffer and what I obtain is something that
resembles what the card should be playing but with huge noise.
Please help!

Stefano

------=_Part_26243_31356797.1155226773137
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I hope this is the last time I write but I don't think so.<br>The problem is quite simple: this USB card does not support DMA transfers (yes, seems impossible but that's what it is), so a support for this sound card is difficult to obtain working on the snd-usb-audio module, Takashi told me to use an intermediate buffer, but I really don't know how to do it. Should I copy data from the buffer (playback) on usb transfer completition callbacks? But in such case isn't it the same to just copy data into the urb's transfer buffer?
<br>I tried to avoid using this buffer and what I obtain is something that resembles what the card should be playing but with huge noise.<br>Please help!<br><br>Stefano<br><br>

------=_Part_26243_31356797.1155226773137--


--===============0540846800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0540846800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0540846800==--
