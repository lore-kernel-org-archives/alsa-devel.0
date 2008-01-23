From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: S16_LE + softvol = bad
Date: Wed, 23 Jan 2008 16:21:46 +0500
Message-ID: <4797234A.10007@gmail.com>
References: <fmnlt1$g5m$1@ger.gmane.org>	<1200578447.2521.1231765977@webmail.messagingengine.com>	<s5hzlv4ee49.wl%tiwai@suse.de>
	<s5hy7aoedju.wl%tiwai@suse.de>	<c072ca310801170701o755601c0ia0822ed3a6b8e7d8@mail.gmail.com>
	<s5hbq7jcndu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 0700610382F
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 12:22:14 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so2238980fgb.44
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 03:22:14 -0800 (PST)
In-Reply-To: <s5hbq7jcndu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 17 Jan 2008 20:01:09 +0500,
> Alexander E. Patrakov wrote:
>> 2008/1/17, Takashi Iwai <tiwai@suse.de>:
>>> ... and the below is the fix.  Give it a try.
>> Tested with no explicit defaults.pcm.dmix.format, with explicit
>> S16_LE, and with explicit S32_LE, all with Intel HD audio and the PC
>> speaker (total 6 cases, including one meaningless). In all cases, the
>> code was able to choose the correct format for talking with hardware
>> (i.e., the worst of (a) explicitly specified, if any, and (b) the best
>> hardware-supported one). Thanks for a quick fix!
> 
> Thanks for checking.  I applied it to HG tree now.

Could you please apply the same tweak (use the best available sample format 
unless overridden) to dsnoop, too?

-- 
Alexander E. Patrakov
