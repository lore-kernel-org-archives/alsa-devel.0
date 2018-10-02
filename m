From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH - Multiple plugins 0/4] Fix leaks on
	multiple plugins
Date: Tue, 2 Oct 2018 18:18:31 +0900
Message-ID: <0d8938c1-2e86-c228-44bf-44abe5411ef7@sakamocchi.jp>
References: <20180928212727.15151-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 48431267819
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 11:18:36 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so720929plp.0
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2018 02:18:35 -0700 (PDT)
In-Reply-To: <20180928212727.15151-1-andre.guedes@intel.com>
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
To: Andre Guedes <andre.guedes@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 29 2018 06:27, Andre Guedes wrote:
> While I was working on AAF plugin RFC v2 series [1], I spotted several leaks in
> some plugins when handling *_hw_constraint() error cases. This series fixes
> these issues.
> 
> Regards,
> 
> Andre
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140290.html
> 
> Andre Guedes (4):
>    a52: Fix leaks when a52_set_hw_constraint() fails
>    jack: Fix leaks when jack_set_hw_constraint() fails
>    oss: Fix leaks when oss_hw_constraint() fails
>    usb_stream: Fix leaks when us_set_hw_constraint() fails
> 
>   a52/pcm_a52.c               | 2 +-
>   jack/pcm_jack.c             | 1 +
>   oss/pcm_oss.c               | 2 +-
>   usb_stream/pcm_usb_stream.c | 1 +
>   4 files changed, 4 insertions(+), 2 deletions(-)

I've reviewed all of the above patches.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I think it better for the plugins to use goto statement to
aggregate error paths for releasing allocated objects but this is
just for code cleanups.


Regards

Takashi Sakamoto
