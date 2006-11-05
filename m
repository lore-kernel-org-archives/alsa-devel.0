From: Volker Schroer <dl1ksv@gmx.de>
Subject: Problem with M5455 card
Date: Sun, 05 Nov 2006 10:23:58 +0100
Message-ID: <454DADAE.3020609@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi,
I hope, this is the right list to post this question.
I'm porting an Ham- Radio application  from oss to alsa.
I'm using an ASROCK motherboard with on board sound and an AMD64 dual 
core. OS is gentoo linux , kernel 2.6.18, alsa-driver 1.0.13, alsa- lib 
1.0.13.

I set the card to FLOAT_LE format.
If I read the samples with snd_pcm_readi, I get invalid values ( 10*e34 
) from time to time, although  the result code of readi does not signal 
any errors.

Is there a way to check if the read values  are valid inside the driver 
? I think, there is a problem inside the driver. Using a delta 44 
soundcard, the problem is gone.

Thanks

Volker

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
