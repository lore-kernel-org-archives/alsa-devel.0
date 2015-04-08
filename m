From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5 alsa-utils] amixer fixes for enumerated
	elements
Date: Thu, 09 Apr 2015 01:37:04 +0900
Message-ID: <55255930.5040008@sakamocchi.jp>
References: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 179192606C2
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:37:10 +0200 (CEST)
In-Reply-To: <1428510659-30393-1-git-send-email-o-takashi@sakamocchi.jp>
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

> [PATCH 0/5 alsa-lib] amixer fixes for enumerated elements

This is for 'alsa-utils', again...
(I seems to be obsessed by it...)

On Apr 09 2015 01:30, Takashi Sakamoto wrote:
> The amixer still has issues according to sset operation to enumerated
> items. The issues are:
>  - Fail to handle omitted value of each channel.
>  - The name of enumerated element is truncated.
>  - Unclear separators for values of channels.
> 
> This patchset fixes these issues, including a small code
> refactoring for better reading.
> 
> Takashi Sakamoto (5):
>   amixer: gather local variables in the beginning of functions
>   amixer: fix a bug to handle omitted value in parameter for enumerated
>     element
>   amixer: expand local storage for item name according to kernel code
>   amixer: arrange validation logic
>   amixer: use the same characters for separator.
> 
>  amixer/amixer.c | 60 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
