From: Petr Kulhavy <petr@barix.com>
Subject: Re: [PATCH v4] ASoC: wm8985: add support for WM8758
Date: Thu, 26 May 2016 12:11:38 +0200
Message-ID: <CAEP=dzAxRuCCmkUqp9JDnY2hove_6femiym6CRAOfmA6m0728w@mail.gmail.com>
References: <1464075532-12495-1-git-send-email-petr@barix.com>
 <20160524155409.GL8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com
 [209.85.161.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D9362666DF
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 12:11:59 +0200 (CEST)
Received: by mail-yw0-f169.google.com with SMTP id h19so72147991ywc.0
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 03:11:59 -0700 (PDT)
In-Reply-To: <20160524155409.GL8206@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, petr.kulhavy@yahoo.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, plamen@barix.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 24 May 2016 at 17:54, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 24, 2016 at 09:38:52AM +0200, Petr Kulhavy wrote:
>> The WM8758 chip is almost identical to WM8985 with the difference that it
>> doesn't feature the AUX input. This patch adds the WM8758 support into the
>> WM8985 driver.
>
> This doesn't apply against current code, please check and resend.

Hi Mark,

the patch is against the mainline kernel.
Do you mean I should apply it against this
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git ?

Thanks
Petr
