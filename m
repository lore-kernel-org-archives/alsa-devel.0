From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH 4/4 v6] ALSA: usb-audio: Scarlett mixer
 interface for 6i6, 18i6, 18i8 and 18i20
Date: Mon, 10 Nov 2014 16:00:17 -0600
Message-ID: <54613571.10206@canonical.com>
References: <s5h7fz71flj.wl-tiwai@suse.de>	<1415645958-11488-1-git-send-email-chris.j.arges@canonical.com>	<1415645958-11488-5-git-send-email-chris.j.arges@canonical.com>
 <s5hk332svu5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D529265A2E
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 23:00:26 +0100 (CET)
In-Reply-To: <s5hk332svu5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, th55@gmx.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

<snip>
> However...
> 
>> +	}
>> +
>> +	/* assign to the appropriate control */
>> +	info->opt_master.names = (const char * const *)names;
>> +	info->opt_matrix.names = (const char * const *)names;
> 
> ... I guess these will be leaked without destructor?  This has to be
> fixed.  You need to add a flag indicating the need of kfree() and do
> it in the own destructor accordingly.
> 
> 
> thanks,
> 
> Takashi
> 
Where is the best place for this destructor?

At the end of the snd_scarlett_controls_create function doesn't work due
to opt_*.names being referenced by scarlett_ctl_enum_info afterwards.

Creating a custom private_free callback doesn't seem correct either as I
should only need to free the memory once and not repeatedly. However
with a flag I could check and only free once on the callback.

Thanks,
--chris
