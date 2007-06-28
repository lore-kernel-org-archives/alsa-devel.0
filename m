From: "Paul Kavan" <pkavan@gmail.com>
Subject: ALSA Application Programming Questions
Date: Thu, 28 Jun 2007 15:41:38 -0500
Message-ID: <61c0054e0706281341o605c7b9bke27fc9c1148e63ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F07A24482
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 22:41:39 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so19992nfd
	for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2007 13:41:38 -0700 (PDT)
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

Hello all:

I have been working on getting ALSA to work on my at91sam9260 with a simple
voice codec for a few weeks. For the most part, I have my ARM board
producing nice audio with aplay/arecord. Now I need a custom application
that will allow me to create an 'intercom' like device with my ARM board. I
am planning on writing the application as I do not think there is something
out there that will accomplish what I want.

I am really new to ALSA--as some of you know--and, as such, have never
written an application for ALSA. I have found the ALSA driver api page on
the alsa site. Wondering if there is any other good documentation on writing
alsa applications?

Any advice is greatly appreciated as well. One of my concerns is building
the applications against the libs. I have the libs on my target machine. As
my host machine has a version of my rfs on it, the libs are there as well.
Just wondering how to accomplish cross-compiling new apps. I suppose I could
copy the libs into the directory with my cross-compiling tools.

Again, any advice would be great.

Thanks.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
