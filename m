From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: dinput_mux check
Date: Sat, 20 Dec 2008 17:53:25 -0500
Message-ID: <494D7765.3050708@embeddedalley.com>
References: <494D736C.3000503@embeddedalley.com> <s5hbpv67954.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id F23A51037E3
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 23:53:32 +0100 (CET)
In-Reply-To: <s5hbpv67954.wl%tiwai@suse.de>
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
> At Sat, 20 Dec 2008 17:36:28 -0500,
> Matthew Ranostay wrote:
>> Add check to determine if dinput_mux is set by any of patch_stac*() functions,
>> otherwise a invalid pointer my be referenced causing gibberish to mixer values.
> 
> Thanks, applied now.
> 
> BTW, which git tree are you checking?
> For the latest STAC/IDT code, always check
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
OK, will do.

I was using the alsa-kmirror.git tree.

Thanks,

Matt Ranostay

> 
> Takashi
> 
