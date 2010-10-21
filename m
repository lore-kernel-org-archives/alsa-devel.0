From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Thu, 21 Oct 2010 20:27:01 +0200
Message-ID: <4CC085F5.9070905@gmail.com>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>	<4CBFEE94.7020103@gmail.com>	<s5hlj5sc7do.wl%tiwai@suse.de>	<4CBFF25C.2080908@gmail.com>
	<s5hfww0c6oj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DDA232414F
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 20:27:06 +0200 (CEST)
Received: by qyk5 with SMTP id 5so34517qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 11:27:04 -0700 (PDT)
In-Reply-To: <s5hfww0c6oj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, clemens@ladisch.de, linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 10/21/2010 10:05 AM, Takashi Iwai wrote:
> At Thu, 21 Oct 2010 09:57:16 +0200,
> Jiri Slaby wrote:
>> BUT, when I run pulse and it suspends the device (or whatever), all the
>> levels get down to 0 back again. When I raise it and run mplayer, it
>> gets to 0 immediately. If I raise it gets to 0 when mplayer finishes and
>> pulse writes 'protocol-native.c: Connection died.'. It never raises
>> automatically. And if I raise it during playback, nothing plays at all.
> 
> Hrm, I don't remember any so critical changes done recently in the
> sound tree.  The only possibly affecting commits are:
> 
>   commit 1cc9e8f4c45999e6069f41521d9d391eeeccc3b3
>     ALSA: hda - Fix codec muted after rebooting from Windows
> 
>   commit de8c85f7840e5e29629de95f5af24297fb325e0b
>     ALSA: HDA: Sigmatel: work around incorrect master muting

Reverting this one helps.

thanks,
-- 
js
