From: Keith Chew <keith.chew@gmail.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Tue, 31 Aug 2010 07:45:09 +1200
Message-ID: <AANLkTinofprWnFLOTGDWfe_ucaezDgRzHwGTehaFDjLk@mail.gmail.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
	<4C75A7D9.1030604@canonical.com>
	<AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>
	<4C76100C.3040205@canonical.com>
	<AANLkTimRwKPFohM46pOKXDmGbcbnCuGWX1VwwcGbk+6o@mail.gmail.com>
	<AANLkTinzKoqc7xDgU1r4yL4AxS4OwUPzkwQ3ieJuXA4h@mail.gmail.com>
	<4C792365.6050308@canonical.com>
	<AANLkTimYykihF=1vvzGhYbHYHPtxVMJK_hND=4hy+L4Z@mail.gmail.com>
	<s5haao48rnq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DBF78244C1
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 21:45:11 +0200 (CEST)
Received: by gxk28 with SMTP id 28so2322911gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 12:45:11 -0700 (PDT)
In-Reply-To: <s5haao48rnq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> This is nothing but the raw 32 bit values the codec chip will take.
> Refer to "default pin configuration" in HD-audio specification.
> Definitions can be found in hda_codec.h, too (AC_DEFCFG_*).
>

Thank you very much for this, I have managed to find it in both Intel
doc, and the hda_codec.h you mentioned. Interestingly, when I
configure all 3 jacks (via user_pin_configs) to be of type HP_OUT,
only 1 of them will be configured as that, the other 2 will not. There
must be something in the generic code that prevents more than 1 jack
being configured as HP_OUT. Looking at patch_realtek.c it appears the
norm is to set only 1 jack to be HP.

So, I ended up using the hda-verb program and set the HP_OUT on
startup, it works out well.

PS: Now I am getting static interference on one of the ports, but I
believe this is a hardware issue. In HP_OUT mode, the rear jack is
picking up static noise from the power source close by (ie noise only
comes in when keyboard is pressed repeatly or when CPU is in use).
Solved one problem, out comes another. More hardware debugging to do,
thanks again for all your help!

Regards
Keith
