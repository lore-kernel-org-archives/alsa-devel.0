From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Website to Wiki migration
Date: Thu, 09 Aug 2007 12:58:33 +1200
Message-ID: <200708091258.34103.linux@audioscience.com>
References: <20070808225429.5C0401F50B1@ws1-2.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 199E410384B
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 02:58:33 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JMH00B5BEO3I910@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 09 Aug 2007 12:57:40 +1200 (NZST)
In-reply-to: <20070808225429.5C0401F50B1@ws1-2.us4.outblaze.com>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-user@lists.sourceforge.net, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 09 August 2007 10:54:29 Ash Willis wrote:
> The Wiki's looking great. It's obvious that you've thought about where
> everything should be and how it should all tie in instead of blinding
> porting the old pages. It's looking very fresh and making much more sense.

Thanks for the feedback

>
> Is it just me though, or is
>
> "Vendor-A-trend    Vendor-ALi    Vendor-AMD"
>
> much harder to read than
>
> "A-trend    ALi    AMD"?
>
> Am I OK to go ahead and remove those prefixes or do we want those kept?
> Same with the modules, although I find the module prefixes much easier
> to deal with visually for some odd reason.

Note that there are cross links between Vendor- and Module- pages.

These prefixes are used to generate the lists of vendors and modules 
automatically.  Another way to do this might be to use categories Vendor and 
Module.   So far I cant see a way to include category list on another page 
see:  http://bugtrack.alsa-project.org/main/index.php/Matrix_Talk:Main

Here are the standalone category pages.  These lists would be better without 
the prefix...
http://bugtrack.alsa-project.org/main/index.php/Category:Module
http://bugtrack.alsa-project.org/main/index.php/Category:Vendor

I'd like to hear from the architect of this part of the wiki (Jaroslav) before 
embarking on wholesale rename of pages.

> Also, two of the modules that don't have pages were written by myself.
> I'd be glad to make the pages for those modules but I don't really know
> what should go on those pages TBH. IMO, most of the info on the module
> pages is outdated and pointless. At the very least, it's heavily repeated.
> Is this something we should look at? Personally I find that it's letting
> down the rather nice new site.

This page says what should be on a Vendor- and Module- page:
http://bugtrack.alsa-project.org/main/index.php/Matrix:Description

The repeated information is generated using a template. One possibility is to 
replace the template contents generic instructions with a link to a single 
page with generic instructions.  The template does give the specific module 
name in the instructions.

For the module that I work on, I have put specific information at the top of 
the page E.g.

http://bugtrack.alsa-project.org/main/index.php/Matrix:Module-asihpi

I suggest you do something similar E.g.

Driver for cards from [[Matrix:Vendor-]]
{| align="right"
 | __TOC__
 |}
==Driver Specific Information==
=== Additional Installation notes===
....
{{Template:Modinfo etc


regards

Eliot
