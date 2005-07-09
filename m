From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 1/14] sound/pci: fix-up sleeping paths
Date: Fri, 8 Jul 2005 17:06:55 -0700
Message-ID: <20050709000655.GH2596__20281.7100719132$1120867746$gmane$org@us.ibm.com>
References: <20050709000324.GD2596@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF139179
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 02:07:01 +0200 (MEST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6906vTl012864
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:06:57 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6906vCf227018
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:06:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6906vmQ003263
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:06:57 -0400
Content-Disposition: inline
In-Reply-To: <20050709000324.GD2596@us.ibm.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, sailer@ife.ee.ethz.ch, mulix@mulix.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Kernel-Janitors <kernel-janitors@lists.osdl.org>
List-Id: alsa-devel@alsa-project.org

On 08.07.2005 [17:03:24 -0700], Nishanth Aravamudan wrote:
> From: Nishanth Aravamudan <nacc@us.ibm.com>

<snip>

> Description: Fix-up sleeping in sound/pci. These changes fall under the
> following two categories:

Very sorry, forgot to CC: kernel-janitors.

Thanks,
Nish


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
