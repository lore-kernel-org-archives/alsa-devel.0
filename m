From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda - add Intel Panther Point HDMI codec id
Date: Fri, 20 May 2011 15:53:32 +0800
Message-ID: <20110520075332.GA15346@localhost>
References: <20110520073543.GA14685@localhost> <s5h4o4p7raa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FEFD103851
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 09:53:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4o4p7raa.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2011 at 03:41:17PM +0800, Takashi Iwai wrote:
> At Fri, 20 May 2011 15:35:43 +0800,
> Wu Fengguang wrote:
> > 
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> 
> Applied now.  Thanks.

Thank you!  FYI here are the outputs after patch.

aplay -l

        card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
          Subdevices: 1/1
          Subdevice #0: subdevice #0
        card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
          Subdevices: 1/1
          Subdevice #0: subdevice #0

/proc/asound/card0/codec#3

        Codec: Intel PantherPoint HDMI
        Address: 3
        AFG Function Id: 0x1 (unsol 0)
        Vendor Id: 0x80862806
        Subsystem Id: 0x80860101
        Revision Id: 0x100000
        No Modem Function Group found
        Default PCM:
            rates [0x0]:
            bits [0x0]:
            formats [0x0]:
        Default Amp-In caps: N/A
        Default Amp-Out caps: N/A
        GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
        Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
          Control: name="IEC958 Playback Con Mask", index=1, device=0
          Control: name="IEC958 Playback Pro Mask", index=1, device=0
          Control: name="IEC958 Playback Default", index=1, device=0
          Control: name="IEC958 Playback Switch", index=1, device=0
          Device: name="HDMI 0", type="HDMI", device=3
          Converter: stream=0, channel=0
          Digital: Enabled
          Digital category: 0x0
          PCM:
            rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
            bits [0x1e]: 16 20 24 32
            formats [0x5]: PCM AC3
          Power states:  D0 D3 EPSS
          Power: setting=D0, actual=D0
        Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
          Control: name="IEC958 Playback Con Mask", index=2, device=0
          Control: name="IEC958 Playback Pro Mask", index=2, device=0
          Control: name="IEC958 Playback Default", index=2, device=0
          Control: name="IEC958 Playback Switch", index=2, device=0
          Device: name="HDMI 1", type="HDMI", device=7
          Converter: stream=0, channel=0
          Digital: Enabled
          Digital category: 0x0
          PCM:
            rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
            bits [0x1e]: 16 20 24 32
            formats [0x5]: PCM AC3
          Power states:  D0 D3 EPSS
          Power: setting=D0, actual=D0
        Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
          Control: name="IEC958 Playback Con Mask", index=3, device=0
          Control: name="IEC958 Playback Pro Mask", index=3, device=0
          Control: name="IEC958 Playback Default", index=3, device=0
          Control: name="IEC958 Playback Switch", index=3, device=0
          Device: name="HDMI 2", type="HDMI", device=8
          Converter: stream=0, channel=0
          Digital:
          Digital category: 0x0
          PCM:
            rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
            bits [0x1e]: 16 20 24 32
            formats [0x5]: PCM AC3
          Power states:  D0 D3 EPSS
          Power: setting=D0, actual=D0
        Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
          Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
          Amp-Out vals:  [0x00 0x00]
          Pincap 0x09000094: OUT Detect HBR HDMI DP
          Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
            Conn = Digital, Color = Unknown
            DefAssociation = 0x1, Sequence = 0x0
          Pin-ctls: 0x40: OUT
          Unsolicited: tag=05, enabled=1
          Power states:  D0 D3 EPSS
          Power: setting=D0, actual=D0
          Connection: 1
             0x02
        Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
          Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
          Amp-Out vals:  [0x00 0x00]
          Pincap 0x09000094: OUT Detect HBR HDMI DP
          Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
            Conn = Digital, Color = Unknown
            DefAssociation = 0x1, Sequence = 0x0
          Pin-ctls: 0x40: OUT
          Unsolicited: tag=06, enabled=1
          Power states:  D0 D3 EPSS
          Power: setting=D0, actual=D0
          Connection: 1
             0x03
        Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
          Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
          Amp-Out vals:  [0x00 0x00]
          Pincap 0x09000094: OUT Detect HBR HDMI DP
          Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
            Conn = Digital, Color = Unknown
            DefAssociation = 0x1, Sequence = 0x0
          Pin-ctls: 0x40: OUT
          Unsolicited: tag=07, enabled=1
          Power states:  D0 D3 EPSS
          Power: setting=D0, actual=D0
          Connection: 1
             0x04
        Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono

Thanks,
Fengguang
