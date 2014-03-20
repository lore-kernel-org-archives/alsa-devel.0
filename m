From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 latency update
Date: Thu, 20 Mar 2014 15:35:34 +0200
Message-ID: <532AEEA6.20704@ti.com>
References: <532ACD4A.3080508@univpm.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id C6FEA2650BE
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 14:35:40 +0100 (CET)
In-Reply-To: <532ACD4A.3080508@univpm.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leonardo Gabrielli <l.gabrielli@univpm.it>
Cc: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Leonardo,

On 03/20/2014 01:13 PM, Leonardo Gabrielli wrote:
> Dear Peter,
> I was investigating on TWL4030 high playback latency and stumbled in an o=
ld
> thread started by Edgar
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/045173.=
html
> where I read this is related to McBSP2 buffer length
> Recent kernels seems to have the same behavior (I have a debian beagleboa=
rdxM
> with 3.13.3-armv7-x10)
> Did you manage to get a fix to this problem? Would it be possible?

The 'misusing/configuring the McBSP, and sDMA' did not worked :(
However the mcbsp code went through quite a bit of change since than
concerning the McBSP FIFO/sDMA configuration.

If we have FIFO the sDMA is always in packet mode.
The default is to transfer one sample with sDMA per DMA request.
You can switch the McBSP to 'threshold' mode and set the maximum FIFO
threshold you want to use. The code will figure out the optimal FIFO/burst
size based on the period size and the max threshold you have set.
This is done via a sysfs file under the mcbsp, the file is dma_op_mode if I
recall correctly.
Playing with the max tx/rx threshold you might be able to get better latenc=
y.

-- =

P=E9ter
