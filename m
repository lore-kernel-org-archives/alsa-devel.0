From: Ulo Mets <umets@osa.pri.ee>
Subject: Re: Conexant 5051 lenovo-x200 fixes
Date: Wed, 24 Aug 2011 06:25:58 +0300
Message-ID: <4E546F46.2040803@osa.pri.ee>
References: <4E4C60AD.2090806@osa.pri.ee> <s5hzkj7t4ju.wl%tiwai@suse.de>
	<4E4DA7BA.5020704@osa.pri.ee> <s5h62lulzx2.wl%tiwai@suse.de>
	<4E4FCF4C.5070402@osa.pri.ee> <s5h4o19slk2.wl%tiwai@suse.de>
	<4E538FC5.5020600@osa.pri.ee> <s5hhb58p92f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from polaris.osa.pri.ee (polaris.osa.pri.ee [194.204.58.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 20440245E7
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 05:26:35 +0200 (CEST)
In-Reply-To: <s5hhb58p92f.wl%tiwai@suse.de>
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

On 08/23/2011 04:10 PM, Takashi Iwai wrote:
> For making auto-parser working, apply the patch below.
> It fixes the multi-headphone assignment case.
>
> Then, put lines below to /lib/firmware/x200t-pincfg file.
>
> ----------------------------------------------------------------
> 0x16 0x042140ff
> 0x17 0x23a11040
> 0x18 0x04a190f0
> 0x19 0x2121103f
> 0x1a 0x901701f0
> 0x1d 0x90a601f0
> ----------------------------------------------------------------
>
> After creating the file, pass "patch=x200t-pincfg model=auto" module
> options to snd-hda-intel driver.  Now the driver will be set up using
> the auto-parser with the given pin-configuration table.
>
> Let me know if this works.  Once after confirming it's working, we can
> add a static configuration in the driver itself.
>
Please disregard my last message.
I amended the x200t-pincfg file with [codec] section and added [pincfg] header, now it works much better.

In Rec screen of Alsamixer all three mic volume and boost controls are present.
Autosensing of Dock Mic works, and so do its controls. Internal mic works too, but
autosensing of Ext mic does not.
(Internal Mic Boost is so long name that it does not want to fit in its space)

In Playback screen the three Mic Boost controls are present, which is perhaps not necessary.
There is also an Auto-Mute Mode on/off control, which does not seem to do anything.
The headphone sensing and controls work as expected.

Regards,

Ulo
