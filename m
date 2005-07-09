From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 3/14] sound/usb: fix-up sleeping paths
Date: Fri, 8 Jul 2005 17:08:09 -0700
Message-ID: <20050709000809.GJ2596__15754.3910587721$1120867841$gmane$org@us.ibm.com>
References: <20050709000324.GD2596@us.ibm.com> <20050709000439.GF2596@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0450C179
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 02:08:12 +0200 (MEST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j6908BeL414820
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:08:11 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j6908BgJ365312
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 18:08:11 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j6908B21006825
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 18:08:11 -0600
Content-Disposition: inline
In-Reply-To: <20050709000439.GF2596@us.ibm.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Kernel-Janitors <kernel-janitors@lists.osdl.org>
List-Id: alsa-devel@alsa-project.org

On 08.07.2005 [17:04:39 -0700], Nishanth Aravamudan wrote:
> From: Nishanth Aravamudan <nacc@us.ibm.com>

<snip>

> Description: Fix-up sleeping in sound/usb. Replace big_mdelay() with
> msleep() to guarantee the task delays as expected. This also involved
> replacing/removing custom sleep functions.

Sorry, forgot to CC: Kernel-Janitors.

Thanks,
Nish


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
