From: naveenkrishna.ch <naveenkrishna.ch@gmail.com>
Subject: Re: arecord ..xrun!!!!
Date: Fri, 19 Dec 2008 18:49:04 +0530
Message-ID: <ef0d8a250812190519n8aadb3erb3922c096d32c0c9@mail.gmail.com>
References: <eeb9eca50812190504g6701afe8i2f6517179b72b74d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EAB6243E3
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 14:19:05 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so327196yxh.2
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 05:19:05 -0800 (PST)
In-Reply-To: <eeb9eca50812190504g6701afe8i2f6517179b72b74d@mail.gmail.com>
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
To: vasudha rao <vasudha.jrao@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 19, 2008 at 6:34 PM, vasudha rao <vasudha.jrao@gmail.com> wrote:

> Hi ..
>
> I am trying to record .wav files..
>
> I did like,
> $arecord -D copy test.wav
> Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> xrun!!! (at least 0.251 ms long)
> xrun!!! (at least 0.071 ms long)
> xrun!!! (at least 0.072 ms long)
> .
> .
> .
>
> When I run this test.wav, no sound!!!!
>
> Am I doing wrong anywhere??

This print is coming from alsa-utils
It is all about the underrun and overrun conditions

I saw some underrun error while playing back

underrun!!! (at least 771.790 ms long)
underrun!!! (at least 3393.433 ms long)
underrun!!! (at least 777.314 ms long)


Can any one help us understanding the issue, If possible solving it too

>
>
> Thanks:-)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Thanks,
keep smiling...
keep winning...

(: Naveen Krishna Ch :)
