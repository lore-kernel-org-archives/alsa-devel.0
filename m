From: "Paul Wang" <Paul.Wang@navman.com>
Subject: Re: ref: pxa255 Alsa Driver
Date: Thu, 16 Nov 2006 11:32:19 +1300
Message-ID: <BB064186AE6A424382B0BC22417BB7A114EF3A@bnt-nav-chc-exh.navman.bnt.local>
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
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, Liam,

I have further questions about this:

How can I merge the driver you mentioned into Arm Linux source
Architecture?

To use it, do I have to use the application on the alsa-kernel HG
repository?

regards.

Paul Wang


-----Original Message-----
From: Liam Girdwood [mailto:liam.girdwood@wolfsonmicro.com] 
Sent: Thursday, 16 November 2006 1:23 a.m.
To: Paul Wang
Cc: alsa-devel
Subject: Re: [Alsa-devel] ref: pxa255 Alsa Driver

Hi Paul,

On Wed, 2006-11-15 at 14:48 +1300, Paul Wang wrote:
> Hi, all,
> 
> I am new to Linux sound drivers.
> What I am looking for is a pxa255 sound driver based on pxa255
I2Sound.
> Does any Alsa driver implement this on kernel 2.6?
> 

There is an I2S driver for the pxa255 in the alsa-kernel HG repository. 

http://hg-mirror.alsa-project.org/alsa-kernel

Alternatively, the driver can also be found in this patch :-

http://opensource.wolfsonmicro.com/~lg/asoc/asoc-v0.12.3.patch

This patch also includes more supported codecs than the HG repo atm.

HTH

Liam


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
