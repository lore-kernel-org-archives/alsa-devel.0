From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: How do I update the ALSA SoundCard Matrix?
Date: Fri, 14 Sep 2007 10:20:23 +1200
Message-ID: <46E9B7A7.9090607@audioscience.com>
References: <46E952F4.4070906@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id DB82724377
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 00:20:29 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JOB0072GVE2DC30@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 14 Sep 2007 10:20:27 +1200 (NZST)
In-reply-to: <46E952F4.4070906@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I'm looking at http://bugtrack.alsa-project.org/main/index.php/Matrix:Main. 
> I'm trying to add information on the CS4270 driver that I wrote, but I just 
> don't get it.  I know how to edit normal Wiki pages, but this looks different. 
>   It looks like all the information is obtained from some database somewhere.

The information on the main page is obtained by searching for other
pages with certain names or categories.  So you just need to create your
module and/or vendor pages and they will show up in the lists.

> 
> This page
> 
> 	http://bugtrack.alsa-project.org/main/index.php/Help:Howto-Edit
> 
> supposedly tells me how to edit, but it's useless.  It doesn't really tell me 
> *how* to edit, it just tells me that it can.

This page has a bit more info
http://alsa-project.org/main/index.php/Matrix:Description

For the driver, create Matrix:Module-cs4270  (assuming snd-cs4270 is the
driver name)

Add the modinfo template as shown in the abovementioned wiki page.
This fills much of the boilerplat text in the module page.
My preference, if you have more interesting stuff to say about your
driver, is to  place it BEFORE the modinfo template.

Example in this style,
http://alsa-project.org/main/index.php/Matrix:Module-asihpi


> So what am I missing?  How do I add information on a new driver?  I'll need to 
> add information on a new vendor soon, too.

Probably easiest to copy an existing Vendor page.
Give the page a name "Matrix:Vendor-Something"

--
Eliot
