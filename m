From: Mark_H_Johnson@Raytheon.com
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with	CONFIG_PM=n
Date: Fri, 7 Jan 2005 08:41:51 -0600
Message-ID: <OF54D6A36A.84E8AEAC-ON86256F82.0050BC7F-86256F82.0050BCA9__31667.9194373593$1105111589$gmane$org@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from lax-gate4.raytheon.com (lax-gate4.raytheon.com [199.46.200.233])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3CDEC326
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 15:42:41 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

> And if you want to find out who is using it then try fuser /dev/dsp,
> fuser /dev/snd/*, or lsof.

Hmm. I figured out which application is "getting in my way" but am not
quite sure why I have a problem opening the audio / what I should do
about it.

On my system...

# fuser /dev/snd/* /dev/dsp
/dev/snd/pcmC0D0p:    2972  2972m
# ps -fe | grep 2972
u21305    2972  2936  0 10:15 ?        00:00:02 artsd -F 10 -S 4096 -a alsa
-s 60 -m artsmessage -c drkonqi -l 3 -f
root      4915  3407  0 11:08 pts/7    00:00:00 grep 2972
# fuser /dev/snd/* /dev/dsp
[I caused a console beep here using backspace]
# fuser /dev/snd/* /dev/dsp
/dev/snd/pcmC0D0p:    2972  2972m

OK, so artsd wakes up on some trigger and then waits around a while
expecting to get some more audio to process. I see it is a user of
/dev/snd/pcmC0D0p but not a user of /dev/dsp. Yet when I attempt to
open /dev/dsp, I get an error.

When I successfully run latencytest (and open /dev/dsp) I see...

# fuser /dev/snd/* /dev/dsp
/dev/dsp:             9156

which is the pid of latencytest.

Can someone please explain the relationship between these devices
and why access to one of these devices prevents access to another?
This is certainly confusing to me.

Thanks.
  --Mark



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
