From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 0/3] Remove support for
 SNDRV_CTL_ELEM_ACCESS_USER & minor fix
Date: Wed, 20 Jul 2016 13:29:00 +0900
Message-ID: <578EFE0C.1010205@sakamocchi.jp>
References: <cover.1468979281.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 49506265885
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 06:29:04 +0200 (CEST)
In-Reply-To: <cover.1468979281.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 20 2016 10:52, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>
> There is no ABI change in this series.
>
> Remove support for control flag SNDRV_CTL_ELEM_ACCESS_USER as Takashi
> Sakamoto suggested. Also fix 2 compiler warnings and add check before
> string cpy.
>
> History:
> v2: Revise commit messages.
>
> Mengdong Lin (3):
>    topology: Remove support for control flag SNDRV_CTL_ELEM_ACCESS_USER
>    topology: Add ATTRIBUTE_UNUSED for unused parameters to fix compiler
>      warning
>    topology: Check address and length before string copy
>
>   src/topology/ctl.c        | 1 -
>   src/topology/pcm.c        | 8 ++++----
>   src/topology/tplg_local.h | 3 +++
>   3 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

But I believe that we can seek better ways for the purpose of third 
patch. For example, changing prototype of the function to return error 
code might help callers to handle errors appropriately.

Anyway, thanks for the first patch.


Regards

Takashi Sakamoto
