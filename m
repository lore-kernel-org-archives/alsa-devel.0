From: Michael Hirsch <m.hirsch@phase-zero.de>
Subject: Re: 'node->type == SND_CONFIG_TYPE_COMPOUND' failed
Date: Mon, 12 Jan 2009 17:51:11 +0100
Message-ID: <496B74FF.90006@phase-zero.de>
References: <496B6BD3.5040400@phase-zero.de> <s5hfxjobiwn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp122.webpack.hosteurope.de (wp122.webpack.hosteurope.de
	[80.237.132.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A44A1037EC
	for <Alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 17:49:39 +0100 (CET)
In-Reply-To: <s5hfxjobiwn.wl%tiwai@suse.de>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Takashi Iwai wrote:
>> kernel version matches the user space library and utils version.
>>
>> searching the archives / google brings no result.
>>
>> We tried with an empty alsa.conf but then the message:
>>
>> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
>> aplay: main:564: audio open error: No such file or directory
>>
>> appears. However the card shows up /proc/asound/cards and alsamixer is 
>> able to access it.
>>
>> Any ideas?
> 
> Try a newer version of alsa-lib.  Possibly fixed, or give you a better
> error message.  At least, this bad "assert" should be gone now.

isn't it an obligation to keep version of user space and kernel in sync?
The kernel we use ships with alsa 1.0.16 and this nothing we can change 
easily.

Michael
