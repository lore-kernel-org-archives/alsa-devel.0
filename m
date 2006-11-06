From: "aditya shankar" <mc.aditya@gmail.com>
Subject: OSS MIxer API(OSS Emulation mode)
Date: Mon, 6 Nov 2006 18:21:40 +0530
Message-ID: <24a2bfdf0611060451l4400868brb45f5668f3504d9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1590150883=="
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

--===============1590150883==
Content-Type: multipart/alternative;
	boundary="----=_Part_36168_14283104.1162817500938"

------=_Part_36168_14283104.1162817500938
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Group,

I'm integrating OSS mixer API support on a custom ARM based platform (custom
audio chip as well). I would like to know if I can add my own IOCTL commands
in OSS mixer API and then route them to my implementation. (This is required
because there are some features in audio chip and I can't find a mapping to
the existing OSS mixer IOCTL commands).
Also I've observed that some standard IOCTLs such as REC_MASK etc are not
getting properly routed to the corresponding kcontrols.

Pl let me know any thoughts on this.

Thanks in advance
Aditya

------=_Part_36168_14283104.1162817500938
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Group,</div>
<div>&nbsp;</div>
<div>I'm integrating OSS mixer API support on a custom ARM based platform (custom audio chip as well). I would like to know if I can add my own IOCTL commands in OSS mixer API and then route them to my implementation. (This is required because there are some features in audio chip and I can't find a mapping to the existing OSS mixer IOCTL commands). 
</div>
<div>Also I've observed that some standard IOCTLs such as REC_MASK etc are not getting properly routed to the corresponding kcontrols.</div>
<div>&nbsp;</div>
<div>Pl let me know any thoughts on this.</div>
<div>&nbsp;</div>
<div>Thanks in advance</div><span>
<div>Aditya</div></span>

------=_Part_36168_14283104.1162817500938--


--===============1590150883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1590150883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1590150883==--
