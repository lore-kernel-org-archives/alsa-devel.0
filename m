From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: multi-channel playback regression
Date: Thu, 23 Jul 2009 10:14:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907231008540.17096@eeebox2.perex-int.cz>
References: <20090723065345.GA1884@localhost> <s5hskgnx4qm.wl%tiwai@suse.de>
	<20090723072253.GA15878@localhost> <s5hprbrx3dd.wl%tiwai@suse.de>
	<20090723075620.GA21405@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 678A010399F
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 10:14:28 +0200 (CEST)
In-Reply-To: <20090723075620.GA21405@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Jul 2009, Wu Fengguang wrote:

>> Is this with the patched (as is on sound git tree) kernel?
>
> Yes, it's unmodified latest git tree.
>
>> What if changing from #if 1 to #if 0?
>
> This makes 8-channel playback work again.

Can we check if we running under VMWare at runtime?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
