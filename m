From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Errors in application building
Date: Tue, 3 Jul 2007 13:51:34 -0500
Message-ID: <61c0054e0707031151n6d90fc97v4493f41c1ab0cd1@mail.gmail.com>
References: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
	<75b66ecd0707031137i4c302270oa307df11e0a6ad3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by alsa0.perex.cz (Postfix) with ESMTP id D218C103837
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 20:51:35 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so2392014mue
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 11:51:34 -0700 (PDT)
In-Reply-To: <75b66ecd0707031137i4c302270oa307df11e0a6ad3@mail.gmail.com>
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

On 7/3/07, Lee Revell <rlrevell@joe-job.com> wrote:
>
> On 7/3/07, Paul Kavan <pkavan@gmail.com> wrote:
> > grhuser@pcL7:$ arm-linux-gcc -Wall -o grh_audio grh_audio.c
>
> You need to add -lasound to the gcc command line.
>
> Lee
>

Thanks Lee. I was digging and just found that. When I tried, I lose all the
other errors, still keep the warnings, but get a new error. The compile
attempts looks like this:

 arm-linux-gcc -lasound -Wall -o grh_audio grh_audio.c
grh_audio.c: In function 'grh_capture':
grh_audio.c:112: warning: pointer targets in passing argument 3 of
'snd_pcm_hw_params_set_rate_near' differ in signedness
grh_audio.c: In function 'grh_playback':
grh_audio.c:207: warning: pointer targets in passing argument 3 of
'snd_pcm_hw_params_set_rate_near' differ in signedness
/home/grhuser/buildroot/build_arm/staging_dir/lib/gcc/arm-linux-uclibc/4.1.2/../../../../arm-linux-uclibc/bin/ld:
cannot find -lasound
collect2: ld returned 1 exit status

I guess I am not sure where lasound ought to be....do you know what file
name I should be looking for and where it should be located for proper
compiling?


-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
