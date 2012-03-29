From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: asihpi - fix return type of
 hpios_locked_mem_alloc()
Date: Thu, 29 Mar 2012 08:56:28 +0300
Message-ID: <20120329055628.GB3289@mwanda>
References: <20120328065702.GA9113@elgon.mountain>
	<s5hiphoyemc.wl%tiwai@suse.de> <4F7385F8.4050004@audioscience.com>
	<s5hk424t1h9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D462104319
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 07:54:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk424t1h9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I'm obviously in favour of using standard error codes where ever
possible.  But when I'm writing a change like this, then I do look
at the surrounding context because there are places the use custom
error codes (SCSI is an example).  In this case, I was confused
because there aren't any other error codes in this file, and also
the comment says that it should return -ENOMEM.

regards,
dan carpenter
