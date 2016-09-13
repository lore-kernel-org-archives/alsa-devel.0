From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [v7 PATCH] amidi: add sysex-interval option
Date: Tue, 13 Sep 2016 17:37:54 +0200
Message-ID: <3f4b6e05-8f0b-248a-dae6-b7b27dbb7d05@ladisch.de>
References: <20160830160248.4595-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3DE6A266A0B
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 17:38:33 +0200 (CEST)
In-Reply-To: <20160830160248.4595-1-eu@felipetonello.com>
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
Cc: alsa-devel@alsa-project.org, "Felipe F. Tonello" <eu@felipetonello.com>
List-Id: alsa-devel@alsa-project.org

Felipe F. Tonello wrote:
> This patch adds a new option to amidi tool: sysex-interval.
>
> It adds a delay (in milliseconds) in between each SysEx message - it searches
> for a 0xF7 byte.
>
> This is very useful when sending firmware updates to a remote device via SysEx
> or any other use that requires this delay in between SysEx messages.
>
> `amidi' manual was updated with an example usage as well.
>
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>

Acked-by: Clemens Ladisch <clemens@ladisch.de>
