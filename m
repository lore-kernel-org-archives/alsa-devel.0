From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [3.6.9 -> 3.7.1 regression] sound: snd_hda_intel
 codec probing issue?
Date: Tue, 08 Jan 2013 15:32:13 +0100
Message-ID: <50EC2DED.7050207@canonical.com>
References: <1356704740.3953.26.camel@lamella> <s5hvcber5cz.wl%tiwai@suse.de>
 <1357421043.3912.13.camel@lamella> <s5h38ydpf45.wl%tiwai@suse.de>
 <1357648135.3849.7.camel@lamella> <s5hehhvq1dm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B522F2615F5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 15:32:13 +0100 (CET)
In-Reply-To: <s5hehhvq1dm.wl%tiwai@suse.de>
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
Cc: Vincent Blut <vincent.debian@free.fr>, alsa-devel@alsa-project.org, Maurizio Avogadro <mavoga@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/08/2013 01:56 PM, Takashi Iwai wrote:
>> I'll test with enable_msi=0 later.
>
> Thanks.
>
> FWIW, below is a patch I'm considering to merge (after testing, of
> course).  Could you buys check it?
>
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Disable runtime D3 for Intel CPT & co

For reference, I'm seeing some of this too, and have asked for people to 
test with enable_msi=0 and/or power_save_controller=0. I'm waiting for 
replies from people with the hardware.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
