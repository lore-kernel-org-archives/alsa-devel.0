From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: playback open error:
Date: Wed, 25 Apr 2007 16:11:20 -0400
Message-ID: <75b66ecd0704251311i3aa51757s8276e6a712017905@mail.gmail.com>
References: <975f530d0704250815t294d7cd4g4e5818a2a4c89eaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CBA624894
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2007 22:11:21 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so418694nzf
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2007 13:11:20 -0700 (PDT)
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
To: Ashlesha Shintre <ashlesha.shintre@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/25/07, Ashlesha Shintre <ashlesha.shintre@gmail.com> wrote:
> Hi,
>
> I m trying to run the simple playback program that I have attached with this
> email -- and I get the following error:
>
> ALSA lib pcm_dmix.c:862:(snd_pcm_dmix_open) unable to open slave
> > Playback open error: Device or resource busy
>

Are you calling wavplay in a loop or something?  Maybe a delay is
required between closing the device and opening it again.

Lee
