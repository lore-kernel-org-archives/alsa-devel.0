From: Jonathan Bennett <jbscience87@gmail.com>
Subject: Help with wm8731 support for the Utilite (imx6q)
Date: Fri, 17 Oct 2014 11:57:07 -0500
Message-ID: <CAB-pspc5KZ0sTB-7uxjBq+PEFxFdAPO5NAXof_+uwQBJ_JCejg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 725272652CE
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 18:57:09 +0200 (CEST)
Received: by mail-ie0-f170.google.com with SMTP id rd18so1147961iec.1
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 09:57:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey, I'm working with a compulab utilite, trying to get everything working
with 3.17, with the eventual goal of getting better support for it
upstream. Currently fighting the sound. It's a imx6q talking to a wm8731
over i2c/i2s.
I am booting Fedora 21 arm Alpha, with my own dtb (
http://pastebin.com/4a4PBKwx) and driver (http://pastebin.com/1CsesuVV)

It shows up in aplay -l, but trying to play anything to it gives me a div
by 0 in a driver:  [<c04f27e4>] (Ldiv0) from [<bf50512c>]
(fsl_ssi_hw_params+0x194/0x364 [snd_soc_fsl_ssi]) This div0 happens in
sound/soc/fsl/fsl_ssi.c, in the function fsl_ssi_set_bclk.

My driver file is an almost direct copy of what compulab shipped with a
3.10 kernel. This is my first attempt at kernel hacking, so any help would
be appreciated.

~Jonathan Bennett
