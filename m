From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: when i plugin my headphone the sound come out from
	speaker and headphone
Date: Tue, 17 Nov 2009 11:38:54 -0500
Message-ID: <604760770911170838k23e07c8wd8fe311763efcb96@mail.gmail.com>
References: <cde6b8770911170756h38fd510bpc740338cc971f7bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 953D42455D
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 17:38:55 +0100 (CET)
Received: by pwj11 with SMTP id 11so137532pwj.32
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 08:38:54 -0800 (PST)
In-Reply-To: <cde6b8770911170756h38fd510bpc740338cc971f7bb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mx.MixeR@gmail.com
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2009 at 10:56 AM, Michael Domanski <mx.mixer@gmail.com> wrote:
> When I plugin my headphone the sound come out from speaker and headphone.
> The speaker and headphone working in the same time.
> I want my speaker to mute when headphone is plugged.
>
> http://www.alsa-project.org/db/?f=841de9447634e7e35ae0171f968c70de253259af
...
> mixer@mdomansky ~ $ sudo modprobe snd-hda-intel model=hp
...
> ^^^^^ sounds ok ^^^^^^

Please compile http://kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-20091117.tar.bz2
using --with-debug=full. Your SSID is already listed for using the
CXT5051_HP quirk:

SND_PCI_QUIRK(0x14f1, 0x5051, "HP Spartan 1.1", CXT5051_HP),

Please rerun alsa-info.sh after reloading the sound drivers from the
20091117 snapshot.
