From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: No sound after returning from suspend-to-ram
Date: Thu, 24 Sep 2009 22:03:44 +0300
Message-ID: <4ABBC290.2000605@pardus.org.tr>
References: <4ABA66E3.7090202@pardus.org.tr> <s5hskecvlxt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 912CF24379
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 21:03:49 +0200 (CEST)
In-Reply-To: <s5hskecvlxt.wl%tiwai@suse.de>
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
> Even reloading the driver doesn't fix?  No sound even from the
> headphone?  If so, it's weird.  Likely the issue below the sound
> hardware level, i.e. PCI or somewhat the core stuff.
>   

He said that rmmod/modprobe'ing snd_hda_intel brings the sound back.
Should I CC this to lkml for grabbing suspend guys' attention?

Regards,
