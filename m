From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: matrix is complete again
Date: Thu, 25 Nov 2004 09:37:47 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411250935230.2207@pnote.perex-int.cz>
References: <XFMail.20041125092531.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B7ED825A
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2004 09:41:33 +0100 (MET)
In-Reply-To: <XFMail.20041125092531.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Nov 2004, Giuliano Pochini wrote:

> There is a typo in this file, which is the source of the
> errors in the file I sent you:
> 
> -    <name>DSP0001</chip>
> +    <name>DSP0001</name>

Fixed, thanks.

> How can I set the link in the "Details(module)" field ?  Since
> the driver is not on CVS yet, I would like to make it point to
> my page.

I extended <not_in_cvs> tag (see last README):

<not_in_cvs>
  <link>http://driver.web.here</link>
</not_in_cvs>  Driver is not in CVS but available

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
