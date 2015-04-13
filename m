From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: davinci-mcasp: Set rule constraints if
 implicit BCLK divider is used
Date: Mon, 13 Apr 2015 15:16:40 +0300
Message-ID: <20150413121639.GU16501@mwanda>
References: <20150410093336.GA5779@mwanda>
 <552BAADA.5060401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 21979261A0A
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:16:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <552BAADA.5060401@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for looking at this.  I haven't double checked your analysis, but
512 means the stack is 2k and that's too high.  I think there is
supposed to be a build warning if we use more than 1k of stack in a
function?

It's better to allocate it with kmalloc() and free it at the end.

regards,
dan carpenter
