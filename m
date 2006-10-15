From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Implementation of cmipci.c snd_cmipci_pcm_prepare():
Date: Sun, 15 Oct 2006 18:48:43 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41E912DA@msilexch01.marvell.com>
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
I would be happy if someone can help me with understanding the cmipci.c
snd_cmipci_pcm_prepare():
Line 789 starts the calculation of Channel 0 Frame Register 2 field Base
count of samples at Codec:

	/* buffer and period sizes in frame */
	rec->dma_size = runtime->buffer_size << rec->shift;

The register expects to get its count in sample granularity.
This means that the rec->dma_size should be number of samples. 
The runtime->buffer_size is said to be in frames (in the above comment).
Can someone explain the above calculation? Why you multiply the
buffer_size by two if format size is greater than 16? What is the
connection between the format size and the sample number? Aren't those
correlate by HW?

Thanks in advance.




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
