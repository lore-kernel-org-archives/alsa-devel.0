From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 20:39:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905252036550.4067@eeebox2.perex-int.cz>
References: <4A1AB98B.9010604@yellowcouch.org> <s5hk54589xd.wl%tiwai@suse.de>
	<4A1ADAEF.3070803@yellowcouch.org> <s5h8wklvyfc.wl%tiwai@suse.de>
	<4A1AE302.8080702@yellowcouch.org> <s5h7i05vxol.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E5FCC244BA
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 20:39:45 +0200 (CEST)
In-Reply-To: <s5h7i05vxol.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Werner Van Belle <werner@yellowcouch.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 May 2009, Takashi Iwai wrote:

> At Mon, 25 May 2009 20:27:14 +0200,
> Werner Van Belle wrote:
>>
>> Takashi Iwai wrote:
>>> You can control it via fcntl().  See fcntl(2) man page.
>>>
>> I looked at that but I didn't find any place in alsalib (or libalsa
>> whatever the order of those two words), where I can obtain the file
>> handle. They are all of type pcm_something_t. I found a file handle
>> quite deep in this library but there seems no way to actually obtain
>> that handle.
>
> OK, I see the problem now, too.  In practice, you can get a file
> descriptor from poll descriptor, but this doesn't cover all underlying
> fds.  A new API function or an additional SND_PCM_* flag for
> snd_pcm_open() would be needed, indeed.

The question is if it's not better to free also allocated memory 
associated to the pcm handle in child process - so snd_pcm_close() 
call in child is not a bad idea.

 					Jaroslav
-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
