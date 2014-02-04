From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [PATCH] ASoC: cs42l73: Don't mix
 SNDRV_PCM_RATE_KNOT with specific rates
Date: Wed, 05 Feb 2014 10:49:06 +1300
Message-ID: <52F16052.9000609@blennerhassett.gen.nz>
References: <1391543731-9085-1-git-send-email-lars@metafoo.de>
 <A40422ED-1EEB-4A09-A550-0AAAAA89464D@cirrus.com>
 <52F15519.7090109@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr2.mail.isx.net.nz (omr2.mail.isx.net.nz [111.65.230.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 759FC261AA4
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 22:49:11 +0100 (CET)
In-Reply-To: <52F15519.7090109@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/02/14 10:01, Lars-Peter Clausen wrote:
> e.g. by a rate list constraint. I find this confusing when casually
> reading the code. 


> And this is the only driver that does it.

A quick grep through the sound tree for "KNOT" shows that there are many
drivers that do?

Just a example:

pci/intel8x0m.c:  .rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
SNDRV_PCM_RATE_KNOT


Do these need 'fixing'?
