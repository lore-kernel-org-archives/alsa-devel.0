From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: remove duplicate headers
Date: Tue, 13 May 2014 12:30:40 +0300
Message-ID: <5371E640.7030007@linux.intel.com>
References: <1399969755-15976-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 248CC2651C0
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 11:30:43 +0200 (CEST)
In-Reply-To: <1399969755-15976-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/13/2014 11:29 AM, Andy Shevchenko wrote:
> A few files contain duplicate headers. This patch removes the second entry of
> duplicate in each file under question.
>
> There is no functional changes.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   sound/soc/intel/sst-baytrail-ipc.c | 1 -
>   sound/soc/intel/sst-haswell-ipc.c  | 1 -
>   sound/soc/intel/sst-haswell-pcm.c  | 1 -
>   3 files changed, 3 deletions(-)
>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
