From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA: compress: Fix kernel-doc warnings
Date: Tue, 15 Nov 2016 08:51:32 +0530
Message-ID: <20161115032132.GI3000@localhost>
References: <20161114213005.22443-1-tiwai@suse.de>
 <20161114213005.22443-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 412402654BE
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 04:12:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161114213005.22443-3-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2016 at 10:30:04PM +0100, Takashi Iwai wrote:
> Some fields in struct snd_compr have no corresponding comments, and
> the kernel-doc complains like:
> 
>   ./include/sound/compress_driver.h:162: warning: No description found for parameter 'id[64]'
>   ./include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_root'
>   ./include/sound/compress_driver.h:162: warning: No description found for parameter 'proc_info_entry'
> 
> Actually all these are internal elements, just put "private:" comment
> so that they will be ignored.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
