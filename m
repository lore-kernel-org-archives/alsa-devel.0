From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH][ALSA] usbmidi support for Access Music
	synths.
Date: Fri, 12 Feb 2010 10:24:04 +0100
Message-ID: <4B751E34.1000703@ladisch.de>
References: <4B726306.8070506@gmail.com> <4B7274BA.3040801@ladisch.de>
	<4B73B96A.9040006@gmail.com> <4B73C3EC.2040606@ladisch.de>
	<4B745D00.5060201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 79B39243FB
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 10:24:11 +0100 (CET)
In-Reply-To: <4B745D00.5060201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastien Alaiwan <sebastien.alaiwan@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Sebastien Alaiwan wrote:
> I've replaced the QUIRK_COMPOSITE by a QUIRK_MIDI_FIXED_ENDPOINT, the
> module also probes (and fails) the USB interface 4 (I don't know
> what this interface is for on this device) which results in the
> printing of an error in the kernel log. How can I inform the
> snd-usb-audio driver that the USB interface 4 should be left alone?

With a QUIRK_IGNORE_INTERFACE for that interface.  This means you need
QUIRK_COMPOSITE again.


HTH
Clemens
