From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: AC97 Codec Rate Problem
Date: Fri, 12 May 2006 19:15:45 +0200
Message-ID: <4464C2C1.4030908@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

Hello folks,

I've developed an ALSA driver for the Renesas SH7760 (a SH-4 SoC)
AC97 component, following Takashi Iwai's howto document.

Right now, I call snd_ac97_set_rate() in the drivers' prepare() callback;
but since I don't know which rates the attached codec actually supports,
I thought maybe there is a way to let ALSA itself handle setting
the rates?

If anyone wants to have a look at the source, I've put it up at
http://140.78.4.77/~mano/camelot-ac97.c

(The driver works pretty well on my devel platform, LM4549 codec)

Thanks!

-- 
 Manuel Lauss


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
