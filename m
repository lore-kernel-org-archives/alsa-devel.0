From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 23:54:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905252352590.4067@eeebox2.perex-int.cz>
References: <4A1AB98B.9010604@yellowcouch.org> <s5hk54589xd.wl%tiwai@suse.de>
	<4A1ADAEF.3070803@yellowcouch.org> <s5h8wklvyfc.wl%tiwai@suse.de>
	<4A1AE302.8080702@yellowcouch.org> <s5h7i05vxol.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0905252036550.4067@eeebox2.perex-int.cz>
	<4A1AF346.9040602@yellowcouch.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C4DAA24133
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 23:54:09 +0200 (CEST)
In-Reply-To: <4A1AF346.9040602@yellowcouch.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Werner Van Belle <werner@yellowcouch.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 May 2009, Werner Van Belle wrote:

> Jaroslav Kysela wrote:
>> The question is if it's not better to free also allocated memory
>> associated to the pcm handle in child process - so snd_pcm_close()
>> call in child is not a bad idea.
>>
> Okay, while you both have been discussing some internals, which I didn't
> try yet, I created a demonstration program to illustrate the mixed
> semantics of the 'sharing' versus 'not sharing' behavior of the dsp
> devices. In the example the parent thread will play a sound, then the
> child closes the dsp, which affects the playback in the parent (it
> either hangs or skips all remaining samples). From this one would
> conclude that the pcm device is fully shared between the two processes
> (semantics I can live with). However, when the parent then tries to
> reopen the device it cannot do so because the device is still 'busy'.

Your example program does not contain dsp_close() call in parent before 
dsp_open(). That's reason why PCM device is blocked.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
