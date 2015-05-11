From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Front speakers doesn't work in multichannel output,
 regression in ALC888
Date: Mon, 11 May 2015 10:34:50 +0800
Message-ID: <CAN8cciZdSoQpLQe2Cum1gozsJ48J-B9gbECFYDsHgx6=R4pLYg@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <4324603.tPLEjaP5mH@luklap.workgroup>
 <CAN8cciYbGexGm8GS3nJgBkfTphy6H-eV-dkwno6TYV0FiMfOhQ@mail.gmail.com>
 <4678913.FpDgrA5u1d@luklap.workgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1962605B0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 04:34:51 +0200 (CEST)
Received: by oift201 with SMTP id t201so94525435oif.3
 for <alsa-devel@alsa-project.org>; Sun, 10 May 2015 19:34:50 -0700 (PDT)
In-Reply-To: <4678913.FpDgrA5u1d@luklap.workgroup>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I started MS Windows and without externals speakers plugged in I could
test
> 5.1 configuration and it seemed that sound was coming from different
directions.

>
> What I managed to determine:
> I've got 3 stacks:
> 1 ST: Headphone, Line-out (FL and FR), SPDIF
> 2 ST: Microphone, Line-out (CLFE)
> 3 ST: Line-in, Line-out (RL and RR)
>
> I've got 5 responsive output pins
> PIN 0x14: Internal FL FR
> PIN 0x15: External FL FR
> PIN 0x17: Internal LFE
> PIN 0x18: External CLFE
> PIN 0x1a: External RL RR
>
> How can we make it work with these information?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/Channel-Mapping-API.txt

seem chnmap type _FIXED , _VAR and _PAIRED does not fit when LFE and FC can
be swapped for internal speaker and external speaker

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=0fb87bb474f978446786263deff6263284e6e011

How do the driver implement channel map when codec has  swap center/lfe
switch ?

Do chnmap contain both {FL FR RL RR FC LFE} and {FL FR RL RR LFE FC} ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=5a61358433b1f89b500f2c365746c73cb7a27e2f

atihdmi_paired_swap_fc_lfe
