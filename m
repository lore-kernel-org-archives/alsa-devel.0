From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: [PATCH/RFC] alsa-info: add DMI data
 to	the	alsa-info output
Date: Mon, 01 Jun 2009 16:01:17 +0300
Message-ID: <4A23D11D.10001@pardus.org.tr>
References: <4A22DC45.6000008@pardus.org.tr>
	<20090601122812.GC32054@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C5C4244A6
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 14:59:06 +0200 (CEST)
Received: from [192.168.3.203] (uekae-subnet-out.ume.tubitak.gov.tr
	[194.27.222.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by pardus.org.tr (Postfix) with ESMTP id 01ACB66B4CFB
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 15:58:59 +0300 (EEST)
In-Reply-To: <20090601122812.GC32054@tango.0pointer.de>
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

Lennart Poettering wrote On 01-06-2009 15:28:
>
> Please note that this information is exported in sysfs anyway, in
> /sys/class/dmi/id/*.
>
> It would be much better to read that data from sysfs since it doesn't
> need a kernel with /dev/mem, or root root priviliges or any other
> software installed.
>   

That's nice, didn't know about that, will resend the patch, thanks!
