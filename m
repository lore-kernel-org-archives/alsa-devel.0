From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa asynchonus playnback
Date: Tue, 29 Nov 2011 16:14:23 +0100
Message-ID: <4ED4F6CF.8040004@ladisch.de>
References: <CAOONfQtrZGd0itFu5rdcyXgfHU4jM5P5M1uBqkBjWwvqF=LGtQ@mail.gmail.com>
	<4ED4DE51.7070805@ladisch.de>
	<CAOONfQsONoj1bokU9xnQz6MvDps=o9M_3Bfk=zOEXv=PLiQJGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 304C210383B
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 16:13:34 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 46D4020D7A
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 10:13:32 -0500 (EST)
In-Reply-To: <CAOONfQsONoj1bokU9xnQz6MvDps=o9M_3Bfk=zOEXv=PLiQJGA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Martin schmidt <schmidtmartin00@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin schmidt wrote:
> my problem is, the sound has an Echo (in german Hall-Effekt).
>
> int write_to_audiostream(short*buf)
> {
>     memcpy(audiobuffer[audiobuffercounter],buf,audio_buffersize*sizeof(short));
>    int w=  snd_pcm_writei (pcm_handle, audiobuffer[audiobuffercounter], 2* audio_buffersize);

This looks correct (as long as the buffer is correctly filled).
Do you ever check w?

>    audiobuffercounter = ++audiobuffercounter % 10;

It is a bad idea to disable compiler warnings, or to not heed them.

> in a Timer-Event

Why a timer?  How is the timer synchronized to the sample clock?


Regards,
Clemens
