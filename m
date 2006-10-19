From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: ALSA supported PCM formats
Date: Thu, 19 Oct 2006 09:44:33 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E91DB2@msilexch01.marvell.com>
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
To: alsa-devel@lists.sourceforge.net
Cc: Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org

HI,
I'm new to ALSA and I'm trying to understand the PCM formats and the way
ALSA stack place/pick them from the DMA buffer.

My understanding concerns PCM formats that their physical representation
bit size is bigger than the actual sound sample bit size.
For example, defined in pcm_misc.c file under pcm_formats[]:
	[SNDRV_PCM_FORMAT_x24_xE]  = {.width = 24, .phys = 32, ...}
	[SNDRV_PCM_FORMAT_x20_3xE] = {.width = 20, .phys = 24, ...}
	[SNDRV_PCM_FORMAT_x18_3xE] = {.width = 18, .phys = 24, ...}
How the ALSA stack (kernel 2.6.12.6) knows the offset of the sound
sample bits inside the format physical size? For example, when the sound
sample size is 24 (.width = 24) and the format physical size is 32
(.phys = 32) the sound sample offset inside the physical frame can
anywhere beteen 0-7 bit. How the ALSA stack can know where to look for
the sound sample?
Thanks. 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
