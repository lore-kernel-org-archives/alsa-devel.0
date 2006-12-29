From: "Ajay Jain" <ajay050@gmail.com>
Subject: Re: Sound Driver Querry
Date: Fri, 29 Dec 2006 17:46:10 +0530
Message-ID: <b92b327b0612290416u49fa792axd5737a79bed3498e@mail.gmail.com>
References: <b92b327b0612272310r142092e5nc7ca9b4d50c7460e@mail.gmail.com>
	<1167393462.11374.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1167393462.11374.25.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

> What arm cpu are you using ?

We are using an ARM926-EJS. The interface between the code chip and
the cpu, is by our own proprietary I2C controller. Is it possible for
us to integrate this?
BTW, the patch you just mentioned, is that not in the main line
2.6.latest? We are using a 2.6.14, so is it possible to backport it?

> OSS audio is deprecated in the Linux 2.6 kernel.
Ok, but we have a working & robust AC97 WM9712 driver for the same. It
would be much more convenient for us if we have something similar in
OSS. So is this guy (the WM8751), supported in any form in the OSS?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
