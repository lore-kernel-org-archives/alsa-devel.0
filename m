From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 09:35:51 -0400
Message-ID: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id E5B4626087E
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 15:35:52 +0200 (CEST)
Received: by mail-lb0-f178.google.com with SMTP id c11so5806154lbj.23
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 06:35:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

soc_pcm_hw_params() sets the parameters in this order:
link, codec, cpu, platform

This is tripping me up when switching between the 44100 and 48000
families.  If previous song was 44100 then the codec has sysclk set to
the 44100 family.

Now I play a 48000 family song. codec gets new hardware params and
errors out because sysclk is still in the 44100 family.

I have code in the cpu set_hw_params which will switch the sysclk, but
it never gets to run because the codec set_hw_params() has already
errored out.

Shouldn't this order be:
platform, link, cpu, codec

-- 
Jon Smirl
jonsmirl@gmail.com
