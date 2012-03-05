From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [bug?,
 3.1 -> 3.2.7 regression] ALC269 (ThinkPad L412): auto-mute mode
 disabled by default
Date: Mon, 5 Mar 2012 13:40:30 -0600
Message-ID: <20120305194030.GA527@burratino>
References: <20120301174109.5868.87525.reportbug@lthink.lnet>
	<20120302082942.GJ5248@burratino> <4F527D2D.2010402@gmail.com>
	<20120304061506.GB14725@burratino> <4F53222C.3080505@gmail.com>
	<20120305011655.GE27427@burratino> <4F551208.1050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AF773104412
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 20:40:39 +0100 (CET)
Received: by iakh37 with SMTP id h37so6347655iak.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 11:40:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F551208.1050004@gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Pavel Yakunin <pyakunin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi et al,

Pavel Yakunin wrote[1]:

> There is a problem with a headphones jack detection in the 3.2 kernel for the ALC269 codec: 
> sound comes from both speaker and headphones simultaneously and never switches between them. 
>
> The problem arised when I upgraded my system to the 3.2 kernel, and when I rolled back to the 3.1
> kernel, everything was ok.

It turned out to be due to the auto-mute mode control, which is
present on this model in 3.2 and not 3.1, being disabled by default.

> On 2012-03-05 05:16, Jonathan Nieder wrote:

>> One more test: if you run "alsactl init" as root, does the auto-mute
>> mode control end up enabled or disabled?
[...]
> It ends up disabled.

Versions tested:

 3.1.y - auto-mute works, no auto-mute control present
 3.2.y - auto-mute disabled by default but control works
 sound/for-next as of 2012-03-03 - likewise

Is this behavior intended?

More details, including alsa-info.sh logs, at [1].

Thanks,
Jonathan

[1] http://bugs.debian.org/661830
