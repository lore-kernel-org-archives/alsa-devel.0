From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/4] More aggressive PM for HD-audio
Date: Thu, 09 Apr 2015 08:59:17 +0200
Message-ID: <55262345.3090507@canonical.com>
References: <1426668658-15911-1-git-send-email-tiwai@suse.de>	<550C48EB.1050200@canonical.com>	<550D11D3.8000009@canonical.com>	<5513FA8B.402@canonical.com>	<s5hoanfdhvq.wl-tiwai@suse.de>	<s5hfv8rdfx3.wl-tiwai@suse.de>	<5514A019.7030604@canonical.com>	<5518F2F1.90306@canonical.com>	<55262219.6040406@canonical.com>
 <s5hmw2h6b8x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 40308260474
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 08:59:15 +0200 (CEST)
In-Reply-To: <s5hmw2h6b8x.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, hwang4 <hui.wang@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-04-09 08:56, Takashi Iwai wrote:
> Ah, OK.  Then we should revert the commit later.
>
> But let's continue debugging a bit.  Could you give alsa-info.sh
> outputs on both working and non-working states?

Just running hda-emu with a realtek codec, e g 
codecs/canonical/alc292-dell-latitude-e5440-ccert-201307-13941 turns all 
nodes, including the internal speaker, into D3. And running a playback 
test does not switch things into D0 - even the DAC node remains in D3 
even though you try to stream to it, which seems a bit strange.

Could you explain how this is supposed to work?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
