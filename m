From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: blocking snd_rawmidi_read and usb device disconnection
Date: Mon, 28 Aug 2006 04:15:08 +0400
Message-ID: <70a871c80608271715i339b2695i87e920e3c34b75da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7684_28800360.1156724108975"
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

------=_Part_7684_28800360.1156724108975
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

If program is blocked on snd_rawmidi_read and device is disconnected,
it waits infinitely.
Is this an intentional behaviour?

Trying to read ctl device with read() yeilds the same results.

Test programs attached.

Regards,
Dmitry.


P.S. I'm not a subscrber, please cc me in your replies.

------=_Part_7684_28800360.1156724108975
Content-Type: text/x-csrc; name=read_rawmidi.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ere3n811
Content-Disposition: attachment; filename="read_rawmidi.c"

I2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8
c3RkbGliLmg+CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CglpbnQgcmVzOwoJ
Y2hhciBjOwoJc25kX3Jhd21pZGlfdCAqbSA9IE5VTEw7CgkKCXByaW50Zigib3BlbmluZyAlczog
IiwgYXJndlsxXSk7CglyZXMgPSBzbmRfcmF3bWlkaV9vcGVuKCZtLCBOVUxMLCBhcmd2WzFdLCAw
KTsKCXByaW50ZigiJXNcbiIsIHNuZF9zdHJlcnJvcihyZXMpKTsKCQoJcHJpbnRmKCJyZWFkaW5n
OiAiKTsKCXJlcyA9IHNuZF9yYXdtaWRpX3JlYWQobSwgJmMsIDEpOwoJcHJpbnRmKCIlZFxuIiwg
cmVzKTsKCglyZXR1cm4gMDsKfQo=
------=_Part_7684_28800360.1156724108975
Content-Type: text/x-csrc; name=read_posix.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ere3nlvu
Content-Disposition: attachment; filename="read_posix.c"

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVycm5vLmg+
CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CgppbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqYXJndltdKQp7CglpbnQgcmVzOwoJaW50IGZkOwoJY2hhciBjOwoKCXByaW50Zigi
b3BlbmluZyAlczogIiwgYXJndlsxXSk7CglyZXMgPSBmZCA9IG9wZW4oYXJndlsxXSwgT19SRE9O
TFkpOwoJcHJpbnRmKCIlc1xuIiwgZmQ8MCA/IHN0cmVycm9yKGVycm5vKSA6IHN0cmVycm9yKDAp
KTsKCglwcmludGYoInJlYWRpbmc6ICIpOwoJcmVzID0gcmVhZChmZCwgJmMsIDEpOwoJcHJpbnRm
KCIlZFxuIiwgcmVzKTsKCglyZXR1cm4gMDsKfQo=
------=_Part_7684_28800360.1156724108975
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_7684_28800360.1156724108975
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_7684_28800360.1156724108975--
