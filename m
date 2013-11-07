From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: [RFC/RFT v2 0/4] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Thu, 07 Nov 2013 16:20:22 -0500
Message-ID: <1383859222.6455.28.camel@Wailaba2>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
 <1380870371.875.14.camel@Wailaba2> <524F51C6.7050203@iki.fi>
 <1381031338.10109.2.camel@Wailaba2> <5251528B.4010506@iki.fi>
 <1381293134.845.4.camel@Wailaba2> <52696FB4.1090704@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alt-proxy9.mail.unifiedlayer.com (unknown [74.220.192.106])
 by alsa0.perex.cz (Postfix) with SMTP id 674302650AE
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 22:20:27 +0100 (CET)
In-Reply-To: <52696FB4.1090704@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> >>   o Contents of /proc/asound/cardX/eld#0.0
> >>
> >> Thanks a lot :)
> >>
> > monitor_present		1
> > eld_valid		1
> > monitor_name		SC-09TX
> > connection_type		HDMI
> [...]
> 
> Looks OK, thanks for testing. Do you happen to have an EDID handy for
> the receiver, just to double-check the data matches? Not sure how it is
> available with fglrx driver, maybe in /var/log/Xorg.0.log...
> No need to go to extraordinary lengths to get it, though :)
> 
Anssi,

Here is the EDID from Xorg.0.log:

[511268.796] (II) fglrx(0): EDID (in hex):
[511268.797] (II) fglrx(0):     00ffffffffffff00412f000001010101
[511268.797] (II) fglrx(0):     00110103806e3e782ad7b3ae51509423
[511268.797] (II) fglrx(0):     0c4a4721080081800101010101010101
[511268.797] (II) fglrx(0):     010101010101023a801871382d40582c
[511268.797] (II) fglrx(0):     45004e6c4200001e011d8018711c1620
[511268.797] (II) fglrx(0):     582c25004e6c4200009e000000fd0017
[511268.797] (II) fglrx(0):     3d0f450f000a202020202020000000fc
[511268.797] (II) fglrx(0):     0053432d303954580a202020202001c4

I'm seeing the monitor_name ok. Unfortunately, it doesn't dump the
extension that byte 126 indicates to be present. (the CEA EDID Timing
Extension with the SADs ?) to validate the rest of the content
of /proc/asound/cardX/eld#0.0.

Is there any other way to get the EDID data?
