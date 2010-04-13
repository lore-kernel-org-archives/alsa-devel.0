From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-lib pcm_share.c snd_pcm_share_open() bug ?
Date: Tue, 13 Apr 2010 10:10:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004131007490.16336@eeebox2.perex-int.cz>
References: <20100409150303.GA1128@Krystal> <s5hmxx794dj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F877103840
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 10:10:03 +0200 (CEST)
In-Reply-To: <s5hmxx794dj.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 Apr 2010, Takashi Iwai wrote:

> At Fri, 9 Apr 2010 11:03:03 -0400,
> Mathieu Desnoyers wrote:
>>
>> Hi,
>>
>> I was looking at snd_pcm_share_open() in alsa-lib-1.0.22, and stumbled on the
>> following line:
>>
>>         pcm->monotonic = pcm->monotonic;
>>
>> what is that supposed to do ? There is clearly something wrong there.
>
> Yeah, very fishy here.
>
> I suppose this plugin can't handle monotonic time as is.
> Jaroslav, could you fix that?

The plugin can handle the monotonic clock as well. The correct line should 
be:

 	pcm->monotonic = slave->pcm->monotonic;

Mathieu - thanks for notice.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
