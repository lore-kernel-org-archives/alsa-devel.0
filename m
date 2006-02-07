From: Sergey Kolosov <freeserj@gmail.com>
Subject: questions about simple alsa driver
Date: Tue, 7 Feb 2006 13:54:34 +0300
Message-ID: <d39e2e70602070254r5ee83e37l279049ffd5abe5f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1259_1339372.1139309674190"
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

------=_Part_1259_1339372.1139309674190
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello.
I write alsa driver for device when not support dma which does not support
dma.  But I write through emulation dma that worked mmap. I.e. on
interruption data from dma buffers are read out, writind in device and set
hw_ptr for callback pointer.
1) As is filled ring dma the buffer? I.e. whence I can read through a head
of the buffer?
2) Filling of the buffer goes continuously or the separate periods are
completely filled only? And in general for what the periods are necessary?

------=_Part_1259_1339372.1139309674190
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello.<br>
I write alsa driver for device when not support dma <span id=3D"r_text" nam=
e=3D"r_text">which does not support dma.&nbsp; </span><span id=3D"r_text" n=
ame=3D"r_text">But I write through emulation dma that
worked mmap. I.e. on interruption data from dma buffers are read out,
writind in device and set hw_ptr for callback pointer.<br>
</span><span id=3D"r_text" name=3D"r_text">1) As is filled ring dma the buf=
fer?
I.e. whence I can read through a head of the buffer? <br>
2) Filling of the
buffer goes continuously or the separate periods are completely filled
only? And in general for what the periods are necessary?</span><br>

------=_Part_1259_1339372.1139309674190--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
