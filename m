From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ref: pxa255 Alsa Driver
Date: Fri, 17 Nov 2006 00:14:50 +0000
Message-ID: <1163722490.3477.21.camel@localhost.localdomain>
References: <BB064186AE6A424382B0BC22417BB7A114EF3A@bnt-nav-chc-exh.navman.bnt.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <BB064186AE6A424382B0BC22417BB7A114EF3A@bnt-nav-chc-exh.navman.bnt.local>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Wang <Paul.Wang@navman.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-11-16 at 11:32 +1300, Paul Wang wrote:
> Hi, Liam,
> 
> I have further questions about this:
> 
> How can I merge the driver you mentioned into Arm Linux source
> Architecture?
> 

The ASoC patch can be merged into your recent 2.6 kernel source with the
patch command.

i.e.

cd linux
patch -p1 < asoc.patch 

> To use it, do I have to use the application on the alsa-kernel HG
> repository?

The HG repository can be checked out using the instructions (link below)
on the download page and can be copied to your kernel sound directory.

http://www.alsa-project.org/download.php

The core code is the same in the patch and the HG repository. The only
difference between them is that the patch has some extra codec drivers
atm (that will be merged into the HG repo in the future).

You will however need to write a small machine driver that will glue the
codec driver to the pxa2xx i2s and audio DMA code (e.g. corgi.c,
poodle.c) and may have to write a codec driver if your codec is
currently unsupported.

The driver can be used by using any audio application that supports
alsa. 

Liam



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
