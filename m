From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: ALSA PCM  data format
Date: Wed, 18 Oct 2006 09:33:23 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E91A92@msilexch01.marvell.com>
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

Hi,
I'm new to ALSA and I would be happy if anyone can explain the format of
the data the ALSA stack is expecting to find in its buffer.  
For example, if I support IEC958 frames that contains 20bit PMC sample
in each sub-frame payload, (total of 40 bits per frame), the HW, which
is capable of striping down the sound sample will DMA to the buffer 40
bits of sound sample. The following frame containing the next 40bits
will be placed right after the last 40 bits, creating a total of 80 bits
in the DMA buffer.
Is that correct?
Thank you in advance.
 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
