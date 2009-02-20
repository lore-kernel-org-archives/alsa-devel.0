From: Paulo Cavalcanti <promac@gmail.com>
Subject: Re: idt blue jack patch
Date: Fri, 20 Feb 2009 07:15:16 -0300
Message-ID: <68720af30902200215l2fa5f4fbvc52fb45dc3ea6a41@mail.gmail.com>
References: <68720af30902160113t5c0f206di4c63ecf801ce74ea@mail.gmail.com>
	<s5h4oyuirc5.wl%tiwai@suse.de>
	<68720af30902171804t1ce547edx41ca120396e66e72@mail.gmail.com>
	<s5htz6s8cis.wl%tiwai@suse.de>
	<68720af30902180104k40a3377cs95ae80446af61f0d@mail.gmail.com>
	<fd3eb9bf0902180144r476fd065ued924b5b26a6675@mail.gmail.com>
	<s5hk57nzs1h.wl%tiwai@suse.de> <20090219030212.GA26505@localhost>
	<1235013772.27435.118.camel@razman> <20090220010001.GA7520@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id D480E1037F9
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 11:15:17 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so368587yxh.2
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 02:15:16 -0800 (PST)
In-Reply-To: <20090220010001.GA7520@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 19, 2009 at 10:00 PM, Wu Fengguang <fengguang.wu@intel.com>wrote:

> Hi Tobin,
>
> Here are the Linux and WinXP pin configurations.
> Both Linux and WinXP configure node 0x0c as an output pin.
>
> However the driver seems to be offering three schemes:
>
>        scheme desc             0xC dev
> ------------------------------------------------------
>        IDS_CONFIG_OPEN         Speaker_Side/LineIn
>        IDS_CONFIG_51           LineIn
>        IDS_CONFIG_71           Speaker_Side
>
> Paulo, maybe you can run these commands to switch between
> linein/lineout modes:
>
>        # wget
> http://www.kernel.org/pub/linux/kernel/people/tiwai/misc/hda-verb-0.3.tar.bz2
>
>        # set PIN_IN mode
>        hda-verb /dev/snd/hwC0D2 0x0c SET_PIN_WIDGET_CONTROL 0x20
>
>        # set PIN_OUT mode
>        hda-verb /dev/snd/hwC0D2 0x0c SET_PIN_WIDGET_CONTROL 0x40
>
> Thanks,
> Fengguang
> ---
>
> /proc/asound/card0/codec\#2
>
>        Codec: IDT 92HD73E1X5
>        Address: 2
>        Vendor Id: 0x111d7676
>        Subsystem Id: 0x80865002
>        Revision Id: 0x100202
>
>
> AUD_allOS_6033.2_PV_IDTGUI_v124/WDM/WinXP/Sthda.ini
>
>        # sthda.INI
>        [Models]
>        ...
>        HDAUDIO\FUNC_01&VEN_111D&DEV_7676&SUBSYS_80865002=I73E-EL2.INI
>        ...
>
>
> AUD_allOS_6033.2_PV_IDTGUI_v124/WDM/WinXP/I73E-EL2.INI
>
>        [HKR\Settings\Pin\0C]
>        CfgDflt                         = dword: 0x01113214
>        AltCfg                          = hex: 5E,32,81,01
>        AssignedDAC     = hex: 0x18
>
>
> /proc/asound/card0/codec\#2
>
>        Node 0x0c [Pin Complex] wcaps 0x400183: Stereo Amp-In
>          Amp-In caps: N/A
>          Amp-In vals:  [0x00 0x00]
>          Pincap 0x00001737: IN OUT Detect Trigger ImpSense
>            Vref caps: HIZ 50 GRD 80
>           Pin Default 0x01113014: [Jack] Speaker at Ext Rear
>             Conn = 1/8, Color = Blue
>            DefAssociation = 0x1, Sequence = 0x4
>          Pin-ctls: 0x40: OUT VREF_HIZ
>          Unsolicited: tag=04, enabled=1
>          Connection: 6
>             0x15 0x16 0x17 0x18* 0x19 0x1e



Thanks a lot, Fengguang.

The other models for this codec are for Dell computers.
Probably, all of then will behave the same way, right?

I still have a question. I see that you  changed Pin Default 0x01113014,
for 0x01813021, in the driver for having LineIn.
Also, Pin-ctls: 0x40 should provide the pin as an output. The Node is 0x0c.

Therefore,

# set PIN_OUT mode
       hda-verb /dev/snd/hwC0D2 0x0c SET_PIN_WIDGET_CONTROL 0x40

 makes sense.

But how would I know that 0x20 would turn the pin 0x0c into LineIn?

  # set PIN_IN mode
       hda-verb /dev/snd/hwC0D2 0x0c SET_PIN_WIDGET_CONTROL 0x20

I am asking because I have a Dell laptop (Vostro 1400) where the external
mic
works when I use model=ref (and I loose the speakers in this case), but not
when I use model=dell-3stack. If I could figure out how to switch
the pin using hda-verb in this case, would solve my problems when using
skype.


-- 
Paulo Roma Cavalcanti
LCG - UFRJ
