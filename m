From: Adam Williamson <awilliam@redhat.com>
Subject: Internal speaker output from Sony Vaio Z (2010 model)
 lost somewhere between 3.1.0 and 3.2.6
Date: Fri, 16 Mar 2012 16:10:09 -0700
Message-ID: <1331939409.22414.29.camel@adam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 4078B2440F
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 00:10:14 +0100 (CET)
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2GNABWG021100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 19:10:11 -0400
Received: from mail.happyassassin.net (ovpn-113-61.phx2.redhat.com
	[10.3.113.61])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id q2GNAASP020359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 19:10:11 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Welp, pretty much as the topic says.

I just noticed today that sound is no longer playing from the internal
speakers of my laptop, a 2010 model Sony Vaio Z. Plugging in headphones
causes sound to be played fine through those. There are three possible
choices for 'Connector' - 'Analog Speakers', 'Analog Output', and
'Analog Headphones' - but none of these seems to make sound come out of
the internal speakers. The default is 'Analog Speakers', and when it's
set to this, headphone output does work when headphones are plugged in.

I've verified that it's broken on Fedora 16 kernels 3.2.6-4, 3.2.8-3 and
3.2.10-1. It's also broken in a very recent Fedora 17 kernel, 3.3.0rc6
or so. It works on a Fedora 16 live image, with kernel 3.1.0-1.
Unfortunately the kernels before 3.2.6 have been trashed from Fedora's
buildsystem archives, I think, so it's hard to narrow things down any
further :/

the alsa-info output is
http://www.alsa-project.org/db/?f=368e2359757b537d4daa0f5399830d3942540196 .

Thanks!
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
