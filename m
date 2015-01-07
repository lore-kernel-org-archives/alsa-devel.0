From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Wed, 7 Jan 2015 10:01:03 +0000
Message-ID: <20150107100103.GR14516@opensource.wolfsonmicro.com>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4FAD32604B0
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 11:01:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141226044457.GA12777@vaishali-Ideapad-Z570>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 26, 2014 at 10:14:57AM +0530, Vaishali Thakkar wrote:
> This patch introduces the use of function put_unaligned_be16.
> 
> This is done using Coccinelle and semantic patch used is as follows:
> 
> @a@
> typedef u16, __be16, uint16_t;
> {u16,__be16,uint16_t} e16;
> identifier tmp;
> expression ptr;
> expression y,e;
> type T;
> @@
> 
> - tmp = cpu_to_be16(y);
> 
> <+... when != tmp
> (
> - memcpy(ptr, (T)&tmp, \(2\|sizeof(u16)\|sizeof(__be16)\|sizeof(uint16_t)\|sizeof(e16)\));
> + put_unaligned_be16(y,ptr);
> |
> - memcpy(ptr, (T)&tmp, ...);
> + put_unaligned_be16(y,ptr);
> )
> ...+>
> ? tmp = e
> 
> @@ type T; identifier a.tmp; @@
> 
> - T tmp;
> ...when != tmp
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

CCing patches@opensource.wolfsonmicro.com would be handy though.

Thanks,
Charles
