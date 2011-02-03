From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH - hdspmixer 1/1] hdspmixer: Fix detection
 for non-MADIface RME cards
Date: Thu, 03 Feb 2011 22:10:25 +0100
Message-ID: <4D4B19C1.2000602@drcomp.erfurt.thur.de>
References: <1296767284-982-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 60FA710385F
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 22:10:38 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 596A11AC679
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 22:10:31 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PNkGofvC5hFI for <alsa-devel@alsa-project.org>;
	Thu,  3 Feb 2011 22:10:27 +0100 (CET)
Received: from [IPv6:2001:638:906:2:216:17ff:fe47:deab] (hex.inf-ra.uni-jena.de
	[IPv6:2001:638:906:2:216:17ff:fe47:deab])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ltw.loris.tv (Postfix) with ESMTPSA id 07A571AC676
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 22:10:26 +0100 (CET)
In-Reply-To: <1296767284-982-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

On 02/03/11 22:08, Adrian Knoth wrote:

>  	    printf("Card %d : %s\n", card, name);
> -	    if (!strncmp(name, "RME MADIface", 12)) {
> +            if (!strncmp(name, "RME Hammerfall DSP + Multiface", 30)) {

JFTR: Reindentation patch coming up soon. Already committed to my git
repo, but I want to add some more code beautification.

Cheers
