From: Jeremy Cline <jcline@redhat.com>
Subject: Re: Regression: very quiet speakers on Thinkpad T570s
Date: Fri, 30 Nov 2018 11:51:33 -0500
Message-ID: <f14c37de-29ce-529b-8b37-40efd29ff1cb@redhat.com>
References: <bbba2653-d57b-5fab-8c06-5fd22ae80aa5@redhat.com>
 <s5h36riy2qh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h36riy2qh.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kailang Yang <kailang@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Tim Van den Eynde <redhat@vdeynde.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/30/18 11:00 AM, Takashi Iwai wrote:
> On Fri, 30 Nov 2018 15:49:17 +0100,
> Jeremy Cline wrote:
>>
>> Hi,
>>
>> Some folks have reported on the Fedora bug tracker[0] that the laptop
>> speaker volume is very low on the Thinkpad T570 when running a kernel
>> that includes commit 61fcf8ece9b6 ("ALSA: hda/realtek - Enable Thinkpad
>> Dock device for ALC298 platform").
>>
>> alsa-info.sh from v4.15.4 (just before commit 61fcf8ece9b6 arrived in
>> stable) and v4.19.4 with the issue present are attached to the bugzilla.
>> I've also Cc'd Tim, who uploaded them and has the laptop in question.
>>
>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1554304
> 
> Could you pinpoint which kernel version started showing the
> regression, at least?  The diffs are fairly wide between 4.15 and
> 4.19.

Ah, sorry for not being more clear. The regression appears to be
introduced by commit 61fcf8ece9b6, which got backported to v4.15.5
because it addressed a bug with the dock[0]. v4.19.4 with that commit
reverted works, according to the bug reporter.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=195161

Regards,
Jeremy
