From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib] [PATCH] pcm: add set and get methods
 for no-rewind flag
Date: Tue, 30 Jan 2018 19:42:23 +0900
Message-ID: <e9508663-98ce-0c5f-0306-412bdb3ba122@sakamocchi.jp>
References: <1517304808-16649-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id CE6F226721E
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 11:42:28 +0100 (CET)
In-Reply-To: <1517304808-16649-1-git-send-email-sriramx.periyasamy@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Patches Audio <patches.audio@intel.com>, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 30 2018 18:33, Sriram Periyasamy wrote:
> From: Ramesh Babu <ramesh.babu@intel.com>
> 
> Add functions to set/get no-rewind flag
> 
> Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
> Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
> ---
>  include/pcm.h          |  2 ++
>  include/sound/asound.h |  1 +
>  src/pcm/pcm.c          | 40 ++++++++++++++++++++++++++++++++++++++++
>  src/pcm/pcm_local.h    |  1 +
>  4 files changed, 44 insertions(+)

For this new flag, I post my comment to your work for kernel land[1].
Please refer to it.

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/131336.html

Regards


Takashi Sakamoto
