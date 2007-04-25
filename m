From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: Re: playback open error:
Date: Wed, 25 Apr 2007 11:20:34 -0400
Message-ID: <975f530d0704250820t7afaaec8j609aa09c55a63f57@mail.gmail.com>
References: <975f530d0704250815t294d7cd4g4e5818a2a4c89eaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 4941F249C3
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2007 17:20:35 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so263523wxd
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2007 08:20:34 -0700 (PDT)
In-Reply-To: <975f530d0704250815t294d7cd4g4e5818a2a4c89eaa@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry forgot to add that

> fuser -v /dev/dsp
>
gives no output --

Thanks,
Ashlesha.

On 25/04/07, Ashlesha Shintre <ashlesha.shintre@gmail.com> wrote:
>
> Hi,
>
> I m trying to run the simple playback program that I have attached with
> this email -- and I get the following error:
>
> ALSA lib pcm_dmix.c:862:(snd_pcm_dmix_open) unable to open slave
> > Playback open error: Device or resource busy
>
>
> I am running this program as a function called wavplay (attached) --
> however, if i run the same program, as part of the main function, then there
> is no problem --
> What i mean is that if i basically just paste the code for the wavplay
> function in main and provide the input values (the pcm data to be played) --
> then it can very well open the default device and play the pcm data that is
> being passed to it!
>
> Any pointers?
> Thanks,
> Ashlesha.
>
>
>
