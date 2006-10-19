From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Question on PCM formats
Date: Thu, 19 Oct 2006 09:14:40 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E91D94@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net, abramo@alsa-project.org
Cc: Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi,
I was looking in http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
and I have some questions regarding the PCM format paragraph:

Q1: I think the sentence:
"...but the sample is stored in low three bits."
Should be
"...but the sample is stored in low three bytes."

Q2: What is the meaning of "full range" in the sentence:
"Some hardware does not support processing of full range"?

Q3: I'm working with kernel 2.6.12.6 and I could not find the
snd_pcm_hw_params_get_sbits() function there. In which kernel version
can I find it?

Q4: Working with 2.6.12.6 kernel, how can I solve the problem of the
ICE1712? How do I tell the stack where is the sound sample bit start
inside the 32-bit frame? 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
