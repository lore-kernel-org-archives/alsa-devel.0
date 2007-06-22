From: "Paul Kavan" <pkavan@gmail.com>
Subject: AT91 SoC PCM Capture
Date: Fri, 22 Jun 2007 11:35:48 -0500
Message-ID: <61c0054e0706220935y22b58671l72b11cf9c77c4b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BB2324521
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 18:35:49 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so25773nfd
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 09:35:48 -0700 (PDT)
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, Frank Mandarino <fmandarino@endrelia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am wondering what piece of code contains the capture functionality for the
at91 soc. I am hoping to see how and when the pcm activates the ssc at read
time. I just cannot figure out why TD0 would behave at such with this set of
code and yet behave correctly with my polling code. Not a criticism....just
wanting to figure this out.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
