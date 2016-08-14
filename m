From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: rawmidi: add runtime error state
 for disorder of data transmission
Date: Sun, 14 Aug 2016 19:36:44 +0900
Message-ID: <566b5e57-f186-bf9a-0d5e-b171e212efbe@sakamocchi.jp>
References: <1471091957-14757-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id A65CD265964
 for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2016 12:36:47 +0200 (CEST)
In-Reply-To: <1471091957-14757-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Aug 13 2016 21:39, Takashi Sakamoto wrote:
> Hi,
> 
> This patchset is based on an idea addressed in this thread:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104589.html
> 
> For packet-oriented drivers such as USB Audio Device class, message
> transmission can fail due to data bus issue. In this case, corresponding
> rawmidi runtime should be closed. Although, current ALSA rawmidi core has
> no mechanism to help applications/drivers to handle this situation.
> 
> This commit adds a helper functions for this aim.
> 
> Takashi Sakamoto (2):
>   ALSA: rawmidi: handle error state for broken logical channel
>   ALSA: rawmidi: add a helper to set runtime error
> 
>  include/sound/rawmidi.h |  3 ++
>  sound/core/rawmidi.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 84 insertions(+), 5 deletions(-)

I posted this patchset without enough test. I'll post revised version.

(They're originally written in this March and I forgot they're still in
a draft stage.)


Regards

Takashi Sakamoto
