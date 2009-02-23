From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: clarification on mmap
Date: Mon, 23 Feb 2009 18:59:11 +0530
Message-ID: <98769532B4BB14429434178695419EAE31FCFB62@bgsmsx501.gar.corp.intel.com>
References: <200902211659.48009.linux@dadeos.co.uk>
	<s5hvdr1337t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E10924383
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 14:29:16 +0100 (CET)
In-Reply-To: <s5hvdr1337t.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a question on mmap. If I give my .info to be _MMAP and _MMAP_VALID. Will ALSA framework internally take care of mmap-ing the kernel buffer that has been pre-allocated in the .probe call? Do I need to do anything special to mmap a kernel buffer into user space? Just accessing the runtime->dma_area would allow me to access user data right?

Thanks,
Harsha
