From: Guy Stalnaker <jstalnak@wisc.edu>
Subject: Re: Issues with HP DV4 laptop sound after Ubuntu
 Jaunty 9.04 upgrade
Date: Mon, 04 May 2009 10:26:27 -0500
Message-ID: <49FF0923.60902@wisc.edu>
References: <49FD2446.7040001@wisc.edu> <s5h4ow19way.wl%tiwai@suse.de>
Reply-To: jstalnak@wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adsum.doit.wisc.edu (adsum.doit.wisc.edu [144.92.197.210])
	by alsa0.perex.cz (Postfix) with ESMTP id A89F62433E
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 17:26:41 +0200 (CEST)
Received: from avs-daemon.smtpauth1.wiscmail.wisc.edu by
	smtpauth1.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 7.0-5.01 32bit (built Feb 19
	2009)) id <0KJ400I0CLKGZZ00@smtpauth1.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Mon, 04 May 2009 10:26:40 -0500 (CDT)
In-reply-to: <s5h4ow19way.wl%tiwai@suse.de>
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

Hello again, Takashi,

Can you think of why a new distribution might be the cause, or a change
that a new distribution makes, that would result in such behavior?  The
new distribution includes a new kernel and a new version of xorg (I
think), so everything on top of the hardware is new. What's damned
peculiar is that the HTML output interface is always recognized
successfully. It's only the Audio device: ATI Technologies Inc SBx00
Azalia (Intel HDA) on pci 00:14.2 that seems to have this issue.

To add oddity to the issue, I brought the laptop to work this morning
and on boot the Audio device was successfully recognized and aplay -l
shows it a card 0!!

I wonder ... do you think that it's possible that a keyboard, mouse,
printer, or some other USB device plugged into the laptop at boot could
affect something like this?  That's really the only difference between
work and home.

Thanks for taking the time to read that long post to the list!!

Guy

Takashi Iwai wrote:
> At Sat, 02 May 2009 23:57:42 -0500,
> Guy Stalnaker wrote:
>> Hello again.
>>
>> I was able to get my internal speakers working for my HP Pavilion Dv4
>> laptop by following the advice I found in the alsa-devel archives.  That
>> advice seems to have worked for quit a few people who found it by a post
>> I made to the Ubuntu Forums.
>>
>> But now, after I have upgraded my Ubuntu from version 8.10 (when sound
>> worked) to version 9.04, sound no longer works correctly.  I have some
>> detailed information about the sequencing and the specific error.
>> Attached is an alsa-info.txt output.
>>
>> Here's what I'm seeing (extracts from dmesg/kernel logs):
>>
>> Apr 29 15:13:17 Harlindon kernel: [   19.937190] HDA Intel 0000:00:14.2:
>> PCI INT A -> GSI 16 (level, low) -> IRQ 16
>> Apr 29 15:13:17 Harlindon kernel: [   19.937270] HDA Intel 0000:00:14.2:
>> setting latency timer to 64
>>
>> Apr 30 09:37:09 Harlindon kernel: [   19.941675] HDA Intel 0000:00:14.2:
>> PCI INT A -> GSI 16 (level, low) -> IRQ 16
>> Apr 30 09:37:09 Harlindon kernel: [   19.941750] HDA Intel 0000:00:14.2:
>> setting latency timer to 64
>>
>> May  1 16:06:01 Harlindon kernel: [   19.852324] HDA Intel 0000:00:14.2:
>> PCI INT A -> GSI 16 (level, low) -> IRQ 16
>> May  1 16:06:01 Harlindon kernel: [   19.852398] HDA Intel 0000:00:14.2:
>> setting latency timer to 64
>>
>> May  1 16:13:43 Harlindon kernel: [   20.950985] HDA Intel 0000:00:14.2:
>> PCI INT A -> GSI 16 (level, low) -> IRQ 16
>> May  1 16:13:43 Harlindon kernel: [   20.951060] HDA Intel 0000:00:14.2:
>> setting latency timer to 64
>>
>> Commit Log for Fri May  1 16:41:58 2009 [Upgrade to Ubuntu Jaunty 9.04]
>>
>> May  1 17:11:05 Harlindon kernel: [   20.318416] hda-intel: unable to
>> grab IRQ 0, disabling device
> 
> This is pretty unusual.  Most likely either a BIOS or an ACPI problem,
> has little to do with the sound driver itself.
> 
> 
> Takashi

-- 
Guy Stalnaker, I2@DOIT, jstalnak@wisc.edu
1210 West Dayton Street, Room 3209 CSS, Madison WI 53706
work 608.263.8035, cell 608.235.4718, fax 608.265.6681
