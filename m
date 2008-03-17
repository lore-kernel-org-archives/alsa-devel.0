From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Emvy24control s/pidf input issue
Date: Mon, 17 Mar 2008 17:32:18 +0100
Message-ID: <47DE9D12.9030900@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr9.xs4all.nl (smtp-vbr9.xs4all.nl [194.109.24.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 50DE51038B0
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 17:32:25 +0100 (CET)
Received: from surfplank2.hierzo (pindarots.xs4all.nl [82.92.197.115])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2HGWIFf087068
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 17:32:24 +0100 (CET)
	(envelope-from udovdh@xs4all.nl)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I just noticed that S/PDIF input on my Audiophile 2496 does not work.
I see:

[udo@wda ~]$ envy24control
using    --- input_channels: 0
         --- output_channels: 4
         --- pcm_output_channels: 8
         --- spdif in/out channels: 2
Unable to read S/PDIF input switch: No such file or directory

Changing the Digital Input from coax to optical or vice versa
gives:
Unable to write S/PDIF on/off switch: No such file or directory
Unable to write S/PDIF input switch: No such file or directory

This is on Fedora 8 x86_64 with alsa-tools 1.0.12-4 from Fedora Core 7,
envycontrol 0.6.0.
S/PDIF output works without a problem. Did not have S/PDIF input working
before, as far as I remember.

Using -v I do not see signal in the meters.

In the source I see in spdif_input_update:

        if ((card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTADIO2496) &&
            ! card_is_dmx6fire)
                return;
        if ((err = snd_ctl_elem_read(ctl, spdif_input)) < 0)
                g_print("Unable to read S/PDIF input switch: %s\n",
snd_strerror(err));
(etc)

Why does snd_ctl_elem_read fail?
How could I make S/PDIF input work again?

Tips are very welcome!

Kind regards,
Udo
