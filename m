From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: ALSA HW buffer managment
Date: Tue, 7 Nov 2006 15:11:44 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41F269AD@msilexch01.marvell.com>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>, Rita Shtern <rita@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi,
Thank you for your reply.
If I can limit the number of periods via the "hw_constrains", is it
possible also to limit the period size?
Thanks you.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, November 07, 2006 2:15 PM
To: Assaf Hoffman
Cc: Lee Revell; Rita Shtern; alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] ALSA HW buffer managment

At Tue, 7 Nov 2006 09:15:42 +0200,
Assaf Hoffman wrote:
> 
> Hi,
> Yes, I read the "Writing an ALSA driver".
> Nevertheless, it seems that the stack can configure the HW with two
> independent parameters: Buffer size and period size.

Yes, but they are _not_ necessarily independent with each other.
You can set correleation/limitations between them (called
"hw_constraints").  For example, you can limit the number of periods
to 2 or 4.  That's what Lee suggested.

> In such a system
> where you get the interrupts on a portion of the DMA buffer size those
> parameters depend on each other. How the ALSA stack can know that?


Takashi


> Thanks.
> 
> -----Original Message-----
> From: Lee Revell [mailto:rlrevell@joe-job.com] 
> Sent: Tuesday, November 07, 2006 9:08 AM
> To: Assaf Hoffman
> Cc: alsa-devel@lists.sourceforge.net; Rita Shtern
> Subject: Re: [Alsa-devel] ALSA HW buffer managment
> 
> On Tue, 2006-11-07 at 08:48 +0200, Assaf Hoffman wrote:
> > Hi,
> > As I understood, ALSA buffer management uses the 'periods' notion to
> > control the latency between SW stack and HW DMA.
> > My HW is not capable of interrupting the SW on a period basis. The
> only
> > interrupt HW generates is on half or quarter of the DMA buffer (for
> > example, in capture, after each half of the buffer is filled with
> > samples the HW will signal interrupt).
> 
> "Period" just refers to the interval between interrupts. So your
> hardware supports either 2 or 4 periods per buffer.
> 
> Did you read "Writing an ALSA driver"?
> 
> Lee
> 
> 
>
------------------------------------------------------------------------
-
> Using Tomcat but need to do more? Need to support web services,
security?
> Get stuff done quickly with pre-integrated technology to make your job
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
>
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
