From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Model quirks and duplicate device IDs
Date: Tue, 07 Jul 2009 10:47:25 +0300
Message-ID: <4A52FD8D.90805@pardus.org.tr>
References: <4A5248F9.1050607@pardus.org.tr> <s5hljn1auaj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id EE7AC1038E2
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 09:47:25 +0200 (CEST)
In-Reply-To: <s5hljn1auaj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>
>> So how should we act on those situations seen that we can't match against DMI data(which would possibly be crap on those laptops)?
>>     
>
> We can check the codec SSID as well.  If both PCI and codec SSID are
> identical, it's very likely that these are same models, but just a
> wrong model was chosen, or the model was changed during development
> and doesn't match properly any more.
>   

This is the one which is reported to work well with model=toshiba:

PCI SSID: 152d:0763
Codec: Realtek ALC268
Codec SSID: 0x152d0763

More info at:
http://www.alsa-project.org/db/?f=83c7d7cd0beec0ae4c926f162a31e4df430c20b5

This is the one reported at which is mapped to model=acer in 2007:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3343

# cat /proc/asound/card0/codec#0
Codec: Realtek ALC268
Address: 0
Vendor Id: 0x10ec0268
Subsystem Id: 0x152d0763

$ lspci -nv
00:00.0 0600: 8086:2a00 (rev 03)
        Subsystem: 152d:0763
        Flags: bus master, fast devsel, latency 0
        Capabilities: <access denied>
