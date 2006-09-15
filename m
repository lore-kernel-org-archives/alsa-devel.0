From: "shane michael matthews" <shane.michael.matthews@gmail.com>
Subject: Wall Clock Counter
Date: Fri, 15 Sep 2006 09:06:51 -0700
Message-ID: <705aa3f00609150906r56f1bda5nefea0fbe3251dee7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0747822828=="
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

--===============0747822828==
Content-Type: multipart/alternative;
	boundary="----=_Part_182026_1087644.1158336411276"

------=_Part_182026_1087644.1158336411276
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello group,

What I want to do is read the value stored in the wall clock counter on my
sound card.  Searching through the alsa documentation and source it appears
that snd_timer_read is the function I want to use.  From timer.c:

"The timer implementation uses ring buffer to store information about timing
events. In this buffer is recorded count of ticks and current tick
resolution in nanoseconds."  Is the 'ticks' referred to here the value in
the wall clock counter (It seems to always be set to 5 on my system)?  If
anyone could point me to more documentation I would greatly appreciate it.

Help is greatly appreciated,
Shane

------=_Part_182026_1087644.1158336411276
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello group,<br><br>What I want to do is read the value stored in the wall clock counter on my sound card.&nbsp; Searching through the alsa documentation and source it appears that snd_timer_read is the function I want to use.&nbsp; From 
timer.c:<br><br>&quot;The timer implementation uses ring buffer to store information about timing events. In this buffer is recorded count of ticks and current tick resolution in nanoseconds.&quot;&nbsp; Is the 'ticks' referred to here the value in the wall clock counter (It seems to always be set to 5 on my system)?&nbsp; If anyone could point me to more documentation I would greatly appreciate it.
<br><br>Help is greatly appreciated,<br>Shane<br>

------=_Part_182026_1087644.1158336411276--


--===============0747822828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0747822828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0747822828==--
