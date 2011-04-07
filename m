From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDA record fails with FIFO error
Date: Thu, 07 Apr 2011 16:30:00 +0200
Message-ID: <4D9DCA68.40302@canonical.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B01308469@sshaexmb1.amd.com>
	<s5h7hb6pe20.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DCFA103815
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 16:30:04 +0200 (CEST)
In-Reply-To: <s5h7hb6pe20.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Xu, Andiry" <Andiry.Xu@amd.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, 741825@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 2011-04-07 12:10, Takashi Iwai wrote:
> At Thu, 7 Apr 2011 16:54:50 +0800,
> Xu, Andiry wrote:
>>
>> Hi Takashi,
>>
>> Currently I encountered an HD audio issue reported by customer on a
>> Lenovo x100e system. Sometimes, but not always, when starting a
>> recording stream through the HDA controller, the controller generates a
>> large amount of interrupts (~40 000 interrupts per second). After this
>> has happened, jack sense (i e unsolicited events from the codec) stops
>> working until the next system reboot.

This seems more reproducible now than it was a while ago, now it seems 
to happen more often than not.

>> SD0STS returns a FIFO error (0x28) in interrupt handler. The interrupt
>> service routine acknowledges this error but does not do anything to
>> counteract the root cause to the problem, so it appears again and again.
>> Restarting the stream does not seem to help. Enable MSI or not does not
>> help either.
>>
>> The issue occurs on 2.6.35 and 2.6.38-rc8+, have not tried latest kernel
>> yet but I think it's also there. FIFO error indicates FIFO overrun
>> occurring while the RUN bit is set, but the driver simply acknowledge
>> and clear the error. I wonder what the root cause and the right
>> treatment are in this case. Any suggestions?

Brainstorming:
1) We could try adding udelays at random places.
2) There are a few workarounds for different chips already in 
hda_intel.c, maybe try applying them here as well.

Does that make sense to either of you?

> FIFO_ERR is actually never handled, so basically we can ignore.
> Simply disabling it like below works around your problem?
>
> Of course, a proper handling of FIFO error would be better, but
> this may need more code rewrites.

This does not fix the error in question, it removes the interrupts all 
right, but neither recording nor jack sense starts to work.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
