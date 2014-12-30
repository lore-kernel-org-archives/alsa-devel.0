From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: Regression for Lenovo X240 sound in 3.18
Date: Tue, 30 Dec 2014 19:13:14 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1412301907120.5263@nerf08.vanv.qr>
References: <alpine.LSU.2.11.1412291303200.30351@nerf08.vanv.qr>
 <s5h387xi2yp.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1412301629280.1813@nerf08.vanv.qr>
 <s5h1tnhi1jx.wl-tiwai@suse.de> <s5hr3vhgldi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ares08.inai.de (ares08.inai.de [46.4.84.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A69F26070C
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 19:13:15 +0100 (CET)
In-Reply-To: <s5hr3vhgldi.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mr.bobukas@gmail.com
List-Id: alsa-devel@alsa-project.org


On Tuesday 2014-12-30 17:20, Takashi Iwai wrote:
>
>Ah, I see you disable the automute.  So the headphone plug shouldn't
>matter.

Changing the "Auto-Mute" control does not do anything; the system always
exhibits Automute behavior (if that's a bug, it's one which I did not
care about so far).


>Hm, then there is nothing obvious wrong there at a quick glance.
>Maybe there is an implicit fixed connection between a DAC and a pin?
>Try the patch below.

With your patch, I get a system which still has two issues
that were not there in 3.17:
 - the "Headphone" control is present but has no volume bar
 - the "PCM" control does not affect the Speaker volume
