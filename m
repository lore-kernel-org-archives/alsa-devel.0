From: Gomathi Kumar <gomathi.techgig@gmail.com>
Subject: [Audio Driver Low power state]
Date: Wed, 26 Mar 2014 09:50:40 +0530
Message-ID: <CAOdMLV+wkXCmcYHDWG0AZa1uUMdD9ss=HVwGqqx1YThmWN+few@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f67.google.com (mail-pb0-f67.google.com
 [209.85.160.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 82D002650B3
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 05:20:41 +0100 (CET)
Received: by mail-pb0-f67.google.com with SMTP id up15so604508pbc.10
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 21:20:40 -0700 (PDT)
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

Hi all,

I am new to kernel work and am trying to understand the low power state of
audio driver.

I am using ALC262 codec, hda_intel and 3.10 kernel code.
In this codec, d3_stop_clk flag is not set. So in the code flow I was able
to understand the following.

if (!codec->pm_down_notified &&
        !bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK))

this particular condition in hda_power_work function fails, as
power_keep_link_on flag is directly based on d3_stop_clk flag.

codec->d3_stop_clk = snd_hda_codec_get_supported_ps(codec, fg,
                                        AC_PWRST_CLKSTOP);

I modified the if condition to not check the power_keep_link_on flag. After
this change the audio is consuming lesser power, but I am not able to see
it going to suspend/runtime suspend.

*Please clarify what is happening when I modify the if condition and how
audio device is consuming low power?*

*Also please help me understand, the significance of flags EPSS and
D3_STOP_CLK and if they can be set by software code. *

Thanks,
Gomathi
