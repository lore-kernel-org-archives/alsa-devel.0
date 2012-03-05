From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [bug?,
 3.1 -> 3.2.7 regression] ALC269 (ThinkPad L412): auto-mute mode
 disabled by default
Date: Mon, 5 Mar 2012 13:53:15 -0600
Message-ID: <20120305195315.GA800@burratino>
References: <20120301174109.5868.87525.reportbug@lthink.lnet>
	<20120302082942.GJ5248@burratino> <4F527D2D.2010402@gmail.com>
	<20120304061506.GB14725@burratino> <4F53222C.3080505@gmail.com>
	<20120305011655.GE27427@burratino> <4F551208.1050004@gmail.com>
	<20120305194030.GA527@burratino> <s5hhay2rfsn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CA37104418
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 20:53:24 +0100 (CET)
Received: by ghbg19 with SMTP id g19so1920763ghb.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 11:53:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5hhay2rfsn.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pavel Yakunin <pyakunin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Jonathan Nieder wrote:

>> More details, including alsa-info.sh logs, at [1].
>
> The auto-mute mode is enabled as default.  It hasn't been changed at
> all.
>
> So, it must have been disabled manually in the user-space side, likely
> accidentally.  The saved asound.state is also evaluated by "alsactl
> init", thus unless you clean it up, the disabled auto-mute status is
> still applied.

Thanks, this must be what I missed.

What is the difference between "alsactl init" and "alsactl restore",
then?

Puzzled,
Jonathan

>> [1] http://bugs.debian.org/661830
