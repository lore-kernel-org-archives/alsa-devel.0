From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Sound Driver Querry
Date: Fri, 29 Dec 2006 13:01:09 +0000
Message-ID: <1167397269.11374.59.camel@localhost.localdomain>
References: <b92b327b0612272310r142092e5nc7ca9b4d50c7460e@mail.gmail.com>
	<1167393462.11374.25.camel@localhost.localdomain>
	<b92b327b0612290416u49fa792axd5737a79bed3498e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b92b327b0612290416u49fa792axd5737a79bed3498e@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ajay Jain <ajay050@gmail.com>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-12-29 at 17:46 +0530, Ajay Jain wrote:
> > What arm cpu are you using ?
> 
> We are using an ARM926-EJS. The interface between the code chip and
> the cpu, is by our own proprietary I2C controller. Is it possible for
> us to integrate this?

Yes, providing you create a Linux i2c driver for you controller. 

> BTW, the patch you just mentioned, is that not in the main line
> 2.6.latest? We are using a 2.6.14, so is it possible to backport it?
> 

It is, although I would recommend upgrading your kernel version as
2.6.14 is quite old.

> > OSS audio is deprecated in the Linux 2.6 kernel.
> Ok, but we have a working & robust AC97 WM9712 driver for the same. It
> would be much more convenient for us if we have something similar in
> OSS. So is this guy (the WM8751), supported in any form in the OSS?

Sorry, afaik no.

Liam


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
