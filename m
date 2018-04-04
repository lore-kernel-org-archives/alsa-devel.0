From: Freaky <freaky2000@gmail.com>
Subject: No audio on headphones on HP X2 210 (Baytrail Atom -
	RT5640)
Date: Wed, 4 Apr 2018 10:39:32 +0200
Message-ID: <CAEw6ZyvFXPC=5fQ8T2qpvb_0VFVcYWLRmUSiQfSx2kCR49947g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com
 [209.85.220.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 490222675C8
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 10:39:34 +0200 (CEST)
Received: by mail-qk0-f177.google.com with SMTP id d206so21674368qkb.0
 for <alsa-devel@alsa-project.org>; Wed, 04 Apr 2018 01:39:34 -0700 (PDT)
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

Hi there,

we're running Fedora 27 on a HP X2 210. Grabbed the UCM config files for it
from the GIT repo of plbossart (
https://github.com/plbossart/UCM/tree/master/bytcr-rt5640) blacklisted the
snd_hdmi_lpe_audio and sound now works via the onboard speakers.

Current kernel is 4.15.13.

Audio via the headphones does not work. Been looking at the source code,
but most of the abbreviations are mumbo jumbo to me :). Doesn't look like
there are any for the headphones in 4.15.13.

Did find this patch:
https://webcache.googleusercontent.com/search?q=cache:FlvUx7XgbH4J:https://github.com/jwrdegoede/linux-sunxi/commit/+&cd=3&hl=en&ct=clnk&gl=nl

Which seems to enable a quirk for headphone detection. Doesn't seem to be
in 4.15.14 source. Do we require that patch? Not sure what this line does:

#define BYT_RT5640_JACK_PIN(quirk) ((quirk) & GENMASK(15, 13))

Would I need to flip bits 15 and 13? What would the parameter be? The file
is called bytcr_rt5640.c, but for the 5645 (Cherrytrail atoms) the kernel
parameter is called snd_soc_rt5645.quirk, is it called snd_soc_rt5640.quirk
here? Doubt it since there are quirks defined in sound/soc/codecs/rt5645.c
whereas I don't see any (4.15.14 sources) in sound/soc/codecs/rt5640.c.

Any advise would be most welcome :).

Thanks in advance.

Kind regards,
