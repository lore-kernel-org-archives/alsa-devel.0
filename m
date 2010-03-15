From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: 2.6.34-rc1: regression: ^Z no longer stops sound
Date: Mon, 15 Mar 2010 08:46:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003150843530.4672@eeebox2.perex-int.cz>
References: <20100314075831.GA13457@elf.ucw.cz> <s5hhboijb83.wl%tiwai@suse.de>
	<20100315074132.GB8886@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EE3701037F9
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 08:46:44 +0100 (CET)
In-Reply-To: <20100315074132.GB8886@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, alsa-devel@alsa-project.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Mar 2010, Pavel Machek wrote:

>> At Sun, 14 Mar 2010 08:58:31 +0100,
>> Pavel Machek wrote:
>>>
>>> Hi!
>>>
>>> In 2.6.33, hitting ^Z stopped mpg123 in a way you'd expect (both on
>>> thinkpad and geode notebook).
>>>
>>> On 2.6.34-rc1, hit ^Z and sound starts looping.
>>
>> Is it an OSS app using the kernel OSS emulation or another backend?
>
> OSS kernel emulation, yes. ... at least I think I'm using it.

I cannot reproduce this problem here. Could you post the contents
of /proc/asound/card0/pcm0p/sub0/status file when you stop the 
audio process and looping starts?

 				Thanks,
 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
