From: Xuebing Wang <xbing6@gmail.com>
Subject: Can not rmmod snd_hda_codec_hdmi
Date: Tue, 23 Dec 2014 19:07:52 +0800
Message-ID: <1419332872.4067.10.camel@xbing-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 6354F2614EE
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 12:07:59 +0100 (CET)
Received: by mail-pa0-f45.google.com with SMTP id lf10so7698423pab.18
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 03:07:58 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "; Takashi Iwai" <tiwai@suse.de>, Anssi Hannula <anssi.hannula@iki.fi>, ";
 Libin Yang" <libin.yang@intel.com>, ";
 Fengguang Wu" <fengguang.wu@intel.com>, ";
 Mengdong Lin" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi community,

I am trying to implement the function of streaming SACD music over HDMI,
my PC is Intel Haswell based CPU (Intel i7 4770).

When I am trying to 'rmmod snd_hda_codec_hdmi', I get the prompt that
this module is in use (detailed message as below) 
rmmod: ERROR: Module snd_hda_codec_hdmi is in use

Is it possible that workqueue [hd-audio] is using this kernel module
(snd_hda_codec_hdmi)?

Can I use rmmod / insmod as the way to debug this module?

Thanks.
Xuebing Wang
