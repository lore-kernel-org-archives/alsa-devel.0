From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: ALSA HW buffer managment
Date: Tue, 7 Nov 2006 09:15:42 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41F267A5@msilexch01.marvell.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rita Shtern <rita@marvell.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
Yes, I read the "Writing an ALSA driver".
Nevertheless, it seems that the stack can configure the HW with two
independent parameters: Buffer size and period size. In such a system
where you get the interrupts on a portion of the DMA buffer size those
parameters depend on each other. How the ALSA stack can know that?
Thanks.

-----Original Message-----
From: Lee Revell [mailto:rlrevell@joe-job.com] 
Sent: Tuesday, November 07, 2006 9:08 AM
To: Assaf Hoffman
Cc: alsa-devel@lists.sourceforge.net; Rita Shtern
Subject: Re: [Alsa-devel] ALSA HW buffer managment

On Tue, 2006-11-07 at 08:48 +0200, Assaf Hoffman wrote:
> Hi,
> As I understood, ALSA buffer management uses the 'periods' notion to
> control the latency between SW stack and HW DMA.
> My HW is not capable of interrupting the SW on a period basis. The
only
> interrupt HW generates is on half or quarter of the DMA buffer (for
> example, in capture, after each half of the buffer is filled with
> samples the HW will signal interrupt).

"Period" just refers to the interval between interrupts. So your
hardware supports either 2 or 4 periods per buffer.

Did you read "Writing an ALSA driver"?

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
