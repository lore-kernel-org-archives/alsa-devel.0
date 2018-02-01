From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] cplay: fix size and nmemb of mp3
	header of fread
Date: Thu, 1 Feb 2018 16:23:27 +0530
Message-ID: <20180201105327.GC18649@localhost>
References: <20180123023312.13029-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A71426782B
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 11:48:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180123023312.13029-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 23, 2018 at 11:33:11AM +0900, Katsuhiro Suzuki wrote:
> This patch swaps 'size' and 'nmemb' arguments of fread.
> The fread returns always 1 (because 'nmemb' is 1) so checking
> the return value is always failure.

Applied, thanks

-- 
~Vinod
