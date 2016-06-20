From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: How does ALSALIB commuciates with low level kernel
 API
Date: Mon, 20 Jun 2016 23:13:52 +0530
Message-ID: <20160620174352.GV16910@localhost>
References: <CAHkWnPYuUgrARoMDHjg-0vSKVfz7x6tfh9cpzoEHzvEs+cvUKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A63FC266631
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 19:37:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHkWnPYuUgrARoMDHjg-0vSKVfz7x6tfh9cpzoEHzvEs+cvUKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chemsi Mehdi <chmsmehdi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 15, 2016 at 12:12:24AM +0100, Chemsi Mehdi wrote:
> Dear experts,
> 
> I am too new in ALSA, trying to read a little bit and understand.
> I want to underatnd how ALSA userspace API calls kernel space code ?
> for example when I call  snd_pcm_open() which code is called in kernel
> sound code ?

easist would be to start gdb on alsa-lib snd_pcm_open() and start tracing
the steps.


> and how the link is made ? via IOCTL/write ?

IOCTL, see sound/core/pcm_native.c on kernel side..

-- 
~Vinod
