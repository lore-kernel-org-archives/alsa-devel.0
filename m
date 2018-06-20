From: Lukas Wunner <lukas@wunner.de>
Subject: HDA controller w/o CLKSTOP and EPSS support
Date: Wed, 20 Jun 2018 11:34:52 +0200
Message-ID: <20180620093452.GA25280@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
 [83.223.95.100])
 by alsa0.perex.cz (Postfix) with ESMTP id CA9F22673CB
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 11:34:53 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Henning Kuehn <prg@cooco.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Henning K=FChn reports that due to my commit 07f4f97d7b4b ("vga_switcheroo:
Use device link for HDA controller"), the discrete GPU on his hybrid
graphics laptop no longer runtime suspends.

The root cause is that the single codec of the GPU's HDA controller
doesn't support CLKSTOP and EPSS.  (The "Supported Power States" are
0x00000009, i.e. CLKSTOP and EPSS bits are not set, cf. page 209 of
the HDA spec.)

This means that in hda_codec_runtime_suspend() we do not call
snd_hdac_codec_link_down():

	if (codec_has_clkstop(codec) && codec_has_epss(codec) &&
	    (state & AC_PWRST_CLK_STOP_OK))
		snd_hdac_codec_link_down(&codec->core);

If snd_hdac_codec_link_down() isn't called, the bit in the codec_powered
bitmask isn't cleared, which in turn prevents the controller from going
to PCI_D3hot in azx_runtime_idle():

	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
	    azx_bus(chip)->codec_powered || !chip->running)
		return -EBUSY;

The codec does runtime suspend to D3, but the PS-ClkStopOk bit in the
response to "Get Power State" is not set. (Response is 0x00000033,
cf. page 151 of the HD Audio spec.)  Hence the check above
"state & AC_PWRST_CLK_STOP_OK" also results in "false".

I'm not familiar enough with the intricacies of the HD Audio spec to
fully comprehend the implications of missing EPSS and CLKSTOP support
and to come up with a fix.  We could quirk any HDA controller in a
vga_switcheroo setup to ignore missing EPSS and CLKSTOP support, but
would that be safe?  E.g. the spec says that if the bus clock does stop,
"a full reset shall be performed" when the clock is reenabled.  Are we
handling this correctly?

Any help in coming up with a proper fix would be greatly appreciated.

dmesg output is available here:
https://bugs.freedesktop.org/show_bug.cgi?id=3D106957

It's a muxed hybrid graphics machine, the HDA controller has PCI ID
1002:aa60.

Thanks!

Lukas
