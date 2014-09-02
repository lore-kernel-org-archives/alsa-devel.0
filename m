From: Andreas Allacher <andreas.allacher@gmx.at>
Subject: Re: [PATCH] ALSA: virtuoso: add Xonar Essence STX II
 support
Date: Tue, 02 Sep 2014 15:48:34 +0200
Message-ID: <5405CAB2.70708@gmx.at>
References: <53FC4901.6070908@allacher.com>	<53FC49A8.1010108@gmx.at>	<53FC4D56.5020808@ladisch.de>	<53FC6532.2080903@gmx.at>	<54003095.200@ladisch.de>
 <5400C662.8030606@gmx.at> <5400CF94.8030503@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C1342656ED
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 15:48:35 +0200 (CEST)
In-Reply-To: <5400CF94.8030503@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I just tested the card with the H6 board and the patch and it seems to 
work fine - only tested 5.1 because I do not have 7.1 but I guess 7.1 
should work as well.
One question: Could it be that under Linux the same sound volume is a 
bit lower than under Windows (not really a problem but...)?

Will this patch make it into 3.17 final or will it be moved to 3.18?

Regards,
    Andreas


Clemens Ladisch wrote:
> Andreas Allacher wrote:
>> Is the path already in the kernel source git or do I have to apply it manually?
> This patch is completely untested and not yet in any git.
>
>
> Regards,
> Clemens
>
