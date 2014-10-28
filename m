From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: soc-pcm: always cancel any pending
 delayed stream shutdown
Date: Tue, 28 Oct 2014 13:23:34 -0200
Message-ID: <CAOMZO5BjS9y0sCkT8wq_pdi7BgxB-5PMa8gCdAgs5=CfYP5K1A@mail.gmail.com>
References: <1413987293-21544-1-git-send-email-hector.palacios@digi.com>
 <20141022162802.GB2344@sirena.org.uk>
 <52F917CEA1B9C64C94833D53889D478C044B9B@dor-sms-xch01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id C48AC26041A
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 16:23:34 +0100 (CET)
Received: by mail-lb0-f180.google.com with SMTP id z12so794716lbi.25
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 08:23:34 -0700 (PDT)
In-Reply-To: <52F917CEA1B9C64C94833D53889D478C044B9B@dor-sms-xch01.digi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Palacios, Hector" <Hector.Palacios@digi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Hector,

On Wed, Oct 22, 2014 at 3:25 PM, Palacios, Hector
<Hector.Palacios@digi.com> wrote:

>> You're not saying what the problems are, just that they might be caused.
>
> Sorry, your right. When I do a recording 2 seconds after a previous playback, and later play the recorded sound I hear 3 seconds of correct audio and then I continue to hear good audio but mixed with noise and at a higher volume, as if the codec had reseted certain parameters to some default values.

Are you able to reproduce this problem on 3.18-rc?
