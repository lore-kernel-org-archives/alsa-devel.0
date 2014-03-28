From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 3/3 v2] ASoC: tas5086: add regulator
	consumer support
Date: Fri, 28 Mar 2014 12:40:09 +0100
Message-ID: <53355F99.4010306@gmail.com>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
 <1395952936-10670-3-git-send-email-zonque@gmail.com>
 <20140328113521.GA30768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id A5433261987
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 12:40:24 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id my13so896702bkb.25
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 04:40:24 -0700 (PDT)
In-Reply-To: <20140328113521.GA30768@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/28/2014 12:35 PM, Mark Brown wrote:
> On Thu, Mar 27, 2014 at 09:42:16PM +0100, Daniel Mack wrote:
>> While at it, move the device identification from the i2c probe to the
>> codec probe, so we do it after the regulators have been enabled.
> 
> It'd be better style to enable the regulators during probe to read the
> ID register rather than deferring.

I had it that way, but that meant I had to introduce device-level pm
functions in parallel to the soc-level ones, in order to really bring
down the supply in suspend, even in setups where the codec is not
actually used.

Nevermind, I can change it back. Will resend the patches for tas5086 and
ak4104.


Thanks,
Daniel
