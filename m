From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCHv3 1/3] ASoC: codec: Simplify ASoC probe
	code.
Date: Mon, 10 Mar 2014 09:54:51 -0500
Message-ID: <CAOZdJXXH-ngaaPRWje8vCNQS1D1movzFt40jGfTM-5F=KNt_WA@mail.gmail.com>
References: <1393814545-15002-1-git-send-email-Li.Xiubo@freescale.com>
 <1393814545-15002-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 01A122656D4
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 15:54:53 +0100 (CET)
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by muin.pair.com (Postfix) with ESMTPSA id 345D28FC12
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 10:54:52 -0400 (EDT)
Received: by mail-vc0-f181.google.com with SMTP id id10so831794vcb.40
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 07:54:51 -0700 (PDT)
In-Reply-To: <1393814545-15002-2-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 2, 2014 at 8:42 PM, Xiubo Li <Li.Xiubo@freescale.com> wrote:
> For some CODEC drivers like who act as the MFDs children are ignored
> by this patch.

This makes no sense to me.  Is there a comma missing, maybe?
Regardless, I think this patch description is too short.
