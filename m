From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: 2.6.30: xruns caused by "ALSA: pcm - Safer
 boundary checks"
Date: Sat, 23 May 2009 14:31:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905231430400.4067@eeebox2.perex-int.cz>
References: <20090522162709.2e04b688@dhcp-100-2-144.bos.redhat.com>
	<s5hmy94x0sy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 837702415E
	for <alsa-devel@alsa-project.org>;
	Sat, 23 May 2009 14:31:58 +0200 (CEST)
In-Reply-To: <s5hmy94x0sy.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Chuck Ebbert <cebbert@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 22 May 2009, Takashi Iwai wrote:

> At Fri, 22 May 2009 16:27:09 -0400,
> Chuck Ebbert wrote:
>>
>> Bug report: https://bugzilla.redhat.com/show_bug.cgi?id=498858
>>
>> To reproduce, pause a video in mplayer and then hit play:
>>
>> ALSA sound/core/pcm_lib.c:263: hda_codec: hw_ptr skipping! [Q] (pos=11263,
>> delta=17400, period=1024, jdelta=21/362/0)
>
> Does the patch fix the problem?

This patch does not look as a proper fix. I'll look to this problem on 
Monday.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
