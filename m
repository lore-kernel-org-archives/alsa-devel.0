From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Steps get aplay and arecord working on an embedded
	board
Date: Fri, 22 Jun 2007 16:53:26 +0530
Message-ID: <8d6898730706220423m50b9f22bj5b974c7d3d79ebfd@mail.gmail.com>
References: <61445c750706220411ted88f4bk4b321e5831acb4f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by alsa0.perex.cz (Postfix) with ESMTP id A23FF244FE
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 13:23:28 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so787170nzf
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 04:23:27 -0700 (PDT)
In-Reply-To: <61445c750706220411ted88f4bk4b321e5831acb4f8@mail.gmail.com>
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
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

First check the /proc/asound to see it is as expected.

Then use amixer to  set the setting
like enable playback/capture and set the volume etc.

Now use aplay or arecord

aplay/arecord --help will give more information

Nobin

On 6/22/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hi
> I have to test my audio driver on an omap based board. I have got the lib and
> utils on my board but dont know the exact steps to follow for using aplay etc.
>
> Can anyone point me to relevant documentation? Couldn't find any. Or just brief
> outline about the steops to follow would be great help.
>
> -pharaoh
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
