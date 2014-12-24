From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: Can not rmmod snd_hda_codec_hdmi
Date: Wed, 24 Dec 2014 21:27:40 +0800
Message-ID: <1419427660.2226.4.camel@gmail.com>
References: <1419332872.4067.10.camel@xbing-ubuntu>
 <680798B3-0846-423E-80F5-11AA542B563A@ladisch.de>
 <1419414572.1861.3.camel@gmail.com> <549A8DF8.1010004@iki.fi>
 <1419422073.1929.5.camel@gmail.com> <549AB171.8030700@sakamocchi.jp>
 <1419426474.4103.10.camel@xbing-ubuntu> <549ABDC4.7010901@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C70A6261522
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 14:27:47 +0100 (CET)
Received: by mail-pa0-f41.google.com with SMTP id rd3so10054032pab.14
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 05:27:46 -0800 (PST)
In-Reply-To: <549ABDC4.7010901@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "; Libin Yang" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "; Takashi Iwai" <tiwai@suse.de>, ";
 Mengdong Lin" <mengdong.lin@intel.com>, Clemens Ladisch <clemens@ladisch.de>, Anssi Hannula <anssi.hannula@iki.fi>, "; Fengguang
 Wu" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-12-24 at 22:21 +0900, Takashi Sakamoto wrote:
> On Dec 24 2014 22:07, Xuebing Wang wrote:
> > 2) However, in Fedora, 'pulseaudio --kill' or your way can get refcount
> > of snd_hda_intel from 7 to 2 (5 decreased). Any suggestions how to
> > decrease the rest 2 refcount?
> > 
> > 3) I did try to build tag 3.13 from mainline kernel (using Fedora 3.17.4
> > config file) and tried 3.13 kernel on Fedora, and got the same result
> > (refcount of snd_hda_intel is down from 7 to 2).
> 
> Hm. In this case that the refcount is down to 2, how is the output of
> 'fuser' command? If any applications use these character devices, we can
> see the name of command.

Sakamoto-san, thanks for your help.

I found out that it is alsactl in Fedora. After kill alsactl, refcnt is
now down to 0, and both snd_hda_intel and snd_hda_codec_hdmi can be
rmmod'ed. 'fuser -v /dev/snd' does not reveal alsactl.

Thanks again.


> Regards
> 
> Takashi Sakamoto
> o-takashi@sakamocchi.jp
> 
