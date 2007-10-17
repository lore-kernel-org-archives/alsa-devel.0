From: James Pearson <james-p@moving-picture.com>
Subject: Re: alsa-driver-1.0.15rc2 build issues on RHEL4/CentOS4
Date: Wed, 17 Oct 2007 17:41:22 +0100
Message-ID: <47163B32.9060402@moving-picture.com>
References: <46EA5F30.7000404@moving-picture.com>
	<47020CAA.4030101@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (unknown [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id E99532479C
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 18:41:22 +0200 (CEST)
In-Reply-To: <47020CAA.4030101@moving-picture.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Pearson wrote:
> James Pearson wrote:
> 
> Setting/changing the following in kconfig-vers 'fixes' the above:
> 
> SND_MTS64       2.6.10
> SND_ASIHPI      2.6.10
> SND_PORTMAN2X4  2.6.10
> SND_CS5535AUDIO 2.6.10

Unfortunately 'SND_CS5535AUDIO 2.6.10' above was missed out of 
kconfig-vers in 1.0.15 final, so alsa-driver 1.0.15 doesn't quite build 
on RHEL4/CentOS4 ...

I missed this as I tested it on x86_64 - where SND_CS5535AUDIO isn't set 
- but it is on i386 ...

James Pearson
