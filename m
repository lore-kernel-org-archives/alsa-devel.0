From: Jyri Sarha <jsarha@ti.com>
Subject: Re: ASoC: davinci-mcasp: Set rule constraints if
 implicit BCLK divider is used
Date: Mon, 13 Apr 2015 16:32:24 +0300
Message-ID: <552BC568.7070907@ti.com>
References: <20150410093336.GA5779@mwanda> <552BAADA.5060401@ti.com>
 <20150413121639.GU16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id E4DEF26508C
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 15:32:28 +0200 (CEST)
In-Reply-To: <20150413121639.GU16501@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/13/15 15:16, Dan Carpenter wrote:
> Thanks for looking at this.  I haven't double checked your analysis, but
> 512 means the stack is 2k and that's too high.  I think there is
> supposed to be a build warning if we use more than 1k of stack in a
> function?
>
> It's better to allocate it with kmalloc() and free it at the end.
>
> regards,
> dan carpenter
>

The function may get called hundreds or even thousands of times when an 
audio stream is started. How heavy is kmalloc/free cycle?

Using kmalloc just feels a bit stupid since in any remotely feasible 
case the maximum number of channels is 8. But maybe I just should not care.

Best regards,
Jyri
