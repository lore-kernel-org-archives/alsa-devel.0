From: Robin Gareus <robin@gareus.org>
Subject: Re: Scarlett 18i8 hardware out of sync with AlsaMixer
Date: Sun, 14 Jun 2015 01:03:42 +0200
Message-ID: <557CB6CE.4090702@gareus.org>
References: <CADN=WdobTC9qdHjKD3PyPW99f2pX-j82vVzZ32zp4ed-C0Gbgg@mail.gmail.com>
 <s5h8ucaed12.wl-tiwai@suse.de>
 <CADN=WdpM_gUD=TpxP9cJmS3VXRwzgODgNeNE0Z2EwC71mZ8yAw@mail.gmail.com>
 <s5hzj4q9mri.wl-tiwai@suse.de> <20150527135325.GA12862@canonical.com>
 <CADN=WdpOfSDS+X_PSvx0UAXxGzfEWRKUDxWCc_5BPJQNKja2cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.219])
 by alsa0.perex.cz (Postfix) with ESMTP id A143C260464
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 01:03:45 +0200 (CEST)
In-Reply-To: <CADN=WdpOfSDS+X_PSvx0UAXxGzfEWRKUDxWCc_5BPJQNKja2cg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <adam@spicenitz.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Chris J Arges <chris.j.arges@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/10/2015 06:24 AM, Adam Goode wrote:
[..]
> My guess is that the ALSA mixer settings are cached too soon, before
> the device itself internally overwrites the settings from NVRAM. We
> are either missing some invalidation event from the device itself, or
> we don't do the right thing during initialization.

I didn't follow the whole discussion, so please excuse me if this was
mentioned before:

I'm pretty sure that the NVRAM is restored on the Scarlet before the
device shows up on USB: Save a config with Hi-Z on but configuring it as
off in software. When connecting & re-powering the device, the indicator
LED will blink on and then go off.


It is not possible to read the full state from the device itself.
Trying to read the value from the device results in garbage for the most
part. The values must be set by ALSA and ALSA must remember the state.
That worked in the original alsa mixer even across suspend/resume for
the 18i6. Either something was changed or has been lost since.

This is also how the OSX and Windows drivers work for the Scarlett
series. As soon as the device is [re]connected, software pushes the last
known state (on that given machine) to the device. (At least it was that
way ~2 years ago when I reverse engineered it).

BTW the prop. driver saves state to the NVRAM quite often. I don't know
if this is a marketing trick (intentionally wear it out quickly) or if
it's OK to do that.


best,
robin
