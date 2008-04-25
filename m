From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: asoc tsc210x
Date: Fri, 25 Apr 2008 12:01:05 +0300
Message-ID: <bd7b27490804250201t66eed57bw7201a0ceea6ea7c@mail.gmail.com>
References: <B9D3C48C98930741A166756A50C44A610F17B3B5@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id C80A92466A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 11:01:06 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so978810ana.80
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 02:01:05 -0700 (PDT)
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B3B5@helx1.corp.vaisala.com>
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
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 10:05 AM, <ext-jukka.hynninen@vaisala.com> wrote:

> Hello all,
>
> I'm assessing TSC2100 codec on an embdedded system.
>
> Any intentions on implementing an ASoC codec driver for TSC210x family?


I'm not aware, but in linux-omap there are some non-ASoC and touchscreen
implementations for them.

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tree;f=sound/arm/omap;h=06529db6de88ab1cdd08807706e71ef5d1b764dd;hb=HEAD

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tree;f=drivers/input/touchscreen;h=e48f7c3a3e2a1c77f52f6886e96658a2e43534a2;hb=HEAD

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=tree;f=drivers/spi;h=4b16fb8682fdc018297e4a329689b537e77f3971;hb=HEAD

Could the multi-function nature of the chip raise some issues with ASoC
> framework?
>

Probably. E.g. in TSC2301 the touchscreen subsystem starts using audio MCLK
input whenever the audio subsystem is powered on and some internal clock
otherwise. So there can always be some undocumented subsystem dependencies.


Jarkko
