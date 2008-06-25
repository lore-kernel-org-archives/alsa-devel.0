From: "Dmitry E. Mikhailov" <sexandvodka@gmail.com>
Subject: IBM X41 laptop,
	no headphone detection after s2ram cycle
Date: Wed, 25 Jun 2008 22:06:13 +0600
Message-ID: <200806252206.13236.sexandvodka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E3E1243AD
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 18:07:18 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so125478nfd.32
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 09:07:17 -0700 (PDT)
Content-Disposition: inline
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

Hi,

For about a year I got a following problem.

After s2ram cycle I got only sound from internal speaker, even if the 
headphones are plugged in.

s2disk (hibernate) restores the functionality.



Sometimes (rare!) I got the functionality after s2ram. If I repeat s2ram, it 
stops working again.

I compared ALSA registers before and after: they are all the same.

It was Ok when I got Fedora7 with kernel 2.6.18 installed. But even if I 
restore 2.6.18 now, things don't go right.

Before the Switch from 'another proprietary OS' it was also Ok.

With Fedora9 I got a famous 'alsasound' service. It's restart doesn't help. 
Reloading modules doesn't help. Unload prior to s2ram and load after it 
doesn't help. Rolling ALSA back doesn't seem to help but I 
could do it wrong way. 
Tested kernels: 2.6.18.something, 2.6.19, 2.6.20, 2.6.20.4, 
2.6.22, 2.6.22.something, 2.6.23, 2.6.23.6, 2.6.23.12, 2.6.23.12, 2.6.25, 
2.6.25.3, 2.6.25.14 (current).

Or it's a hardware failure? As a last resort I'll reinstall /\/\$ \/\/in to 
check.

	Best regards, Dmitry Mikhailov
