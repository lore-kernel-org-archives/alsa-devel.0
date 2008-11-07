From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] ALSA: have snd_BUG_ON() always refer to
	arguments
Date: Fri, 7 Nov 2008 02:29:25 -0500
Message-ID: <8bd0f97a0811062329l26f8338ahbb62bab9e8284c36@mail.gmail.com>
References: <1226023521-10037-1-git-send-email-vapier@gentoo.org>
	<s5hod0sqcmt.wl%tiwai@suse.de>
	<8bd0f97a0811062309m4029f612k4d3fe380e6d124df@mail.gmail.com>
	<s5hk5bgqa61.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 25B85103899
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 08:29:27 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so755697yxh.2
	for <alsa-devel@alsa-project.org>; Thu, 06 Nov 2008 23:29:26 -0800 (PST)
In-Reply-To: <s5hk5bgqa61.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 7, 2008 at 02:15, Takashi Iwai wrote:
> At Fri, 7 Nov 2008 02:09:04 -0500,
> Mike Frysinger wrote:
>> On Fri, Nov 7, 2008 at 01:22, Takashi Iwai wrote:
>> > At Thu,  6 Nov 2008 21:05:21 -0500,
>> > Mike Frysinger wrote:
>> >> The snd_BUG_ON() macro should always expand its argument even if we're
>> >> forcing it to false.  This kills off unused warnings that did not exist
>> >> before the snd_assert() -> snd_BUG_ON() conversion.
>> >
>> > Andrew already change this differently.  Check with the latest version.
>>
>> what are you defining as "latest version" ?  i'm looking in torvalds
>> linux-2.6.git.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
>> > And which warning did you get actually?
>>
>> a few codecs define local vars which only get used in snd_BUG_ON() ...
>> so if snd_BUG_ON() doesnt utilize cond, gcc whines that the var is
>> unused.
>
> I know it.  But I thought all these were removed in the actual codes.
> I'd like to see the real warning messages.

seems the warnings where in codec drivers we havent pushed into
mainline yet.  regardless, i dont think auditing code and changing it
just to avoid (cond) references is the way to go.  it also breaks
valid C code if there were side effects in the (cond) as any other
macro which does not properly utilize every argument exactly once.
-mike
