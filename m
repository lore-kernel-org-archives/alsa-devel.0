From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: ALSA 1.0.25 broke AC3 passthrough?
Date: Sat, 11 Feb 2012 21:41:21 +1100
Message-ID: <CANpj82LYZNndExqY600KJY25FaZ=1GqFr+cPAz-uaK6BySi0oA@mail.gmail.com>
References: <CANpj82+DPJGg1vUvm-otVEWEeXwK8zOy4ZAGjFH81oc5n51CTw@mail.gmail.com>
	<4F30BABD.10504@nvidia.com>
	<CANpj82JTMW-nm4r_Z3JgK_Ft7oimr84Yz+-8m-41d1pwEvtfoQ@mail.gmail.com>
	<4F349876.6080109@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7517A24371
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 11:41:24 +0100 (CET)
Received: by ghbg19 with SMTP id g19so1908537ghb.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 02:41:21 -0800 (PST)
In-Reply-To: <4F349876.6080109@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

On 10 February 2012 15:09, Stephen Warren <swarren@nvidia.com> wrote:

> You'd mentioned that this problem was present in ALSA 1.0.25, but wasn't
> in some earlier release. Potentially a lot changed between those two
> releases. It'd be nice if you could try compiling a number of
> intermediate versions of the ALSA driver to try and more precisely
> locate the change that caused the issue. "git bisect" on the ALSA driver
> repository might be useful here.

Ok...

This is interesting..

Compiling from git, using tag v1.0.25, the problem is there...
Compiling master, it's not

However, the issue doesn't show with v1.0.25, when the ALSA hardware
buffer is set to its default 64kB.
If I set it to a higher value (echo 4096 | sudo tee
/proc/asound/card1/pcm3p/sub0/prealloc) ; then it shows up.

so obviously the issue has been fixed between the time 1.0.25 was
released, and now.

I will try to identify which change between 1.0.24 and 1.0.25 broke it
however... Which would lead precisely to which change in master fixed
it. So a 1.0.25.2 can be released soon fixing that problem..

JY
