From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Tue, 8 Sep 2009 17:05:46 +0200
Message-ID: <7c5010d60909080805o7f707a0cx10d7699803ef0ef2@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5hpra7ynut.wl%tiwai@suse.de>
	<7c5010d60909040411y76818280p7b7ded46f2df9b64@mail.gmail.com>
	<7c5010d60909040910l2cd54890rc89222b17ca6d8eb@mail.gmail.com>
	<7c5010d60909070400n48b5d494h1769285c958e9626@mail.gmail.com>
	<s5heiqjxbc8.wl%tiwai@suse.de>
	<7c5010d60909071205o74873cadh5eb3703224531940@mail.gmail.com>
	<s5hocpl60ax.wl%tiwai@suse.de>
	<7c5010d60909080629s502f99c7l43f1dccf84aa4d8@mail.gmail.com>
	<s5hiqft5zjv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 924D92456A
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 17:05:49 +0200 (CEST)
Received: by bwz25 with SMTP id 25so2735896bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2009 08:05:47 -0700 (PDT)
In-Reply-To: <s5hiqft5zjv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 8, 2009 at 3:36 PM, Takashi Iwai<tiwai@suse.de> wrote:
>>
>> I'm not sure I've understood. There will be a /proc pseudofile that I
>> can read and write and that alters the values of period and buffer?
>
> Yes.
>

Sorry to ask again on this, I've tried to write to various files under
/proc/asound (notably to dummy_pcm) but I was not able to modify
values.

Please, could you hint me with a working example write (eg: echo
"channels_max=3" > /proc/asound/Dummy/dummy_pcm) ?

-giovanni
