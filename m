From: John Rigg <aldev2@jrigg.co.uk>
Subject: Re: Cannot combine audio devices with more than
	64	channels
Date: Wed, 8 Feb 2017 16:31:10 +0000
Message-ID: <20170208163110.GA26916@localhost.localdomain>
References: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
 <1cdef19b-a458-7441-2ede-2ba8984ec7cd@ladisch.de>
 <s5hh94khiao.wl-tiwai@suse.de>
 <CAKw=HF1kZ12YOUuBX0MmiyYsPqQ68kafP-cVmWA8FP0dHOAuDw@mail.gmail.com>
 <20170131193159.GA17070@localhost.localdomain>
 <CAKw=HF10J=Sr=qrR6yTB_m3yznDh8boUv_qP1MKN75SXFth40w@mail.gmail.com>
 <20170208162012.GA26820@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vm2962.vps.tagadab.com (vm2962.vps.tagadab.com [95.172.24.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 482AD266AB2
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 18:01:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170208162012.GA26820@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?J=F6rg_M=FCller?= <joerg.mueller7744@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 08, 2017 at 04:20:12PM +0000, John Rigg wrote:
> In jack2/common/JackGlobals.h it has the following:
> #ifndefine PORT_NUM_MAX
> #define PORT_NUM_MAX 4096
> #endif
> 

Sorry, that should be JackConstants.h

John
