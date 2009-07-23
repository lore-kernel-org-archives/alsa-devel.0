From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: multi-channel playback regression
Date: Thu, 23 Jul 2009 16:36:22 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907231633070.27466@t61.perex-int.cz>
References: <20090723065345.GA1884@localhost> <s5hskgnx4qm.wl%tiwai@suse.de>
	<20090723072253.GA15878@localhost> <s5hprbrx3dd.wl%tiwai@suse.de>
	<20090723075620.GA21405@localhost> <s5h7hxzxyj6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E9D8103A1F
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 16:36:23 +0200 (CEST)
In-Reply-To: <s5h7hxzxyj6.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Jul 2009, Takashi Iwai wrote:

> Subject: [PATCH] ALSA: pcm - Fix hwptr buffer-size overlap bug
>
> The fix 79452f0a28aa5a40522c487b42a5fc423647ad98 introduced another
> bug due to the missing offset for the overlapped hwptr.

Please, use patch names (subject) rather than SHA commit IDs. They are not 
stable in all cases until Linus merges content to it's tree.

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
