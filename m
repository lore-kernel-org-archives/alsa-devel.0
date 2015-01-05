From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 11/13] ALSA: Deletion of checks before the
 function call "iounmap"
Date: Mon, 5 Jan 2015 16:58:21 +0300
Message-ID: <20150105135821.GD15033@mwanda>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54A9355F.4050102@users.sourceforge.net>
 <54A941C1.4020906@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 40D552604D0
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 14:58:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54A941C1.4020906@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-parisc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Thibaut Varene <T-Bone@parisc-linux.org>, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 04, 2015 at 02:36:01PM +0100, SF Markus Elfring wrote:
>  	/* unmap PCI memory space, mapped during device init. */
> -	for (idx = 0; idx < HPI_MAX_ADAPTER_MEM_SPACES; idx++) {
> -		if (pci.ap_mem_base[idx])
> -			iounmap(pci.ap_mem_base[idx]);
> -	}
> +	for (idx = 0; idx < HPI_MAX_ADAPTER_MEM_SPACES; ++idx)
> +		iounmap(pci.ap_mem_base[idx]);
>  

Don't do the gratuitous idx++ to ++idx changes.  You do it a couple
other places as well.  It belongs in a separate patch if you really feel
it is worth doing.  (It is not a clean up and it is not worth doing).

regards,
dan carpenter
