From: Mario <anyc@hadiko.de>
Subject: Re: Enable docking station speaker jack for new Lenovo
 Thinkpads
Date: Tue, 31 Jul 2012 21:02:02 +0200
Message-ID: <50182BAA.9000709@hadiko.de>
References: <50170719.8090207@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout.scc.kit.edu (mailout.scc.kit.edu [129.13.185.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B14F265D4C
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 21:02:06 +0200 (CEST)
In-Reply-To: <50170719.8090207@hadiko.de>
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
Cc: phiamo@googlemail.com
List-Id: alsa-devel@alsa-project.org

Hi Phil,

I've managed to get it working with hda-verb only, so just execute the
following commands:

./hda-verb /dev/snd/hwC0D0 0x1b SET_PIN_WIDGET_CONTROL 0x40
./hda-verb /dev/snd/hwC0D0 0x1b SET_AMP_GAIN_MUTE 0xb000

Although the sound is better when choosing the second Audio Mixer. I
will take a closer lock at this.

I wrote a "little" blog entry and pushed a script on github. Both can
be found here:

https://kicherer.org/joomla/index.php/de/blog/liste/27-gentoo-on-thinkpad-t530
https://github.com/anyc/toolsnstuff/blob/master/gentoo_thinkpad_t530/enable_docking_hp_jack.sh

Hope this helps!

Best regards,
Mario

On 31.07.2012 00:13, Mario wrote:
> Hi all,
>
> for new Lenovo Thinkpads (mine T530, will probably affect all new
> [TXW][45]30 models), the model=thinkpad module option does not enable
> the speaker jack of the docking station. Sound works perfectly with the
> laptop, only the docking station needs extra work. I managed to get it
> work using hda-analyzer. It produced the following diff:
>
> Diff for codec 0/0 (0x10ec0269):
> ---
> +++
> @@ -210,28 +210,28 @@
> Unsolicited: tag=0x00, enabled=0
> Power: setting=D0, actual=D0
> Connection: 2
> 0x0c* 0x0d
> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
> Amp-In vals: [0x00 0x00]
> Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> - Amp-Out vals: [0x80 0x80]
> + Amp-Out vals: [0x00 0x00]
> Pincap 0x00003734: IN OUT Detect
> Vref caps: HIZ 50 GRD 80 100
> Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> Conn = 1/8, Color = Black
> DefAssociation = 0xf, Sequence = 0x0
> Misc = NO_PRESENCE
> - Pin-ctls: 0x20: IN VREF_HIZ
> - Unsolicited: tag=0x00, enabled=0
> - Power: setting=D0, actual=D0
> - Connection: 2
> - 0x0c* 0x0d
> + Pin-ctls: 0x40: OUT VREF_HIZ
> + Unsolicited: tag=0x00, enabled=0
> + Power: setting=D0, actual=D0
> + Connection: 2
> + 0x0c 0x0d*
> Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x1d [Pin Complex] wcaps 0x400400: Mono
> Pincap 0x00000020: IN
> Pin Default 0x40138205: [N/A] Speaker at Ext N/A
> Conn = ATAPI, Color = Purple
> DefAssociation = 0x0, Sequence = 0x5
> Pin-ctls: 0x20: IN
> Power: setting=D0, actual=D0
>
> Relevent lspci entry:
>
> 00:1b.0 Audio device [0403]: Intel Corporation 7 Series/C210 Series
> Chipset Family High Definition Audio Controller [8086:1e20] (rev 04)
>
> Chip: Realtek ALC269VC
>
> Further alsa-info:
> http://www.alsa-project.org/db/?f=e297bdda4fd099425516c7c831e28a2c7d8ae6b6
>
> Unfortunately, I failed to create a working hda-verb script. I can
> change the out-pin with:
>
> hda-verb /dev/snd/hwC0D0 0x1b SET_PIN_WIDGET_CONTROL 0x40
>
> but I did not find the command to unmute the channel. Can anyone tell me
> which options are necessary and can this easily be fixed in the kernel?
>
> Also, hda-analyzer showed me two mixer devices, they produce a slightly
> different sound. I don't know if this is important.
>
> Thank you very much!
> Mario
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
