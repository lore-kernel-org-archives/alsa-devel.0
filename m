From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/6] ASoC: adau17x1: Mark DSP parameter
 memory as readable and precious
Date: Fri, 21 Nov 2014 17:30:30 +0100
Message-ID: <546F68A6.2040008@metafoo.de>
References: <1416418148-14803-1-git-send-email-lars@metafoo.de>
 <1416418148-14803-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-170.synserver.de
 [212.40.185.170])
 by alsa0.perex.cz (Postfix) with ESMTP id E15772606E0
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 17:30:25 +0100 (CET)
In-Reply-To: <1416418148-14803-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/19/2014 06:29 PM, Lars-Peter Clausen wrote:
> To be able to read back data from the DSP parameter memory the register
> range needs to be marked as readable. At the same time we do not want them
> to e.g. appear in debugfs output so mark them as precious as well.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>


It looks like this one was lost, shall I resend?

Thanks,
- Lars
