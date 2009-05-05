From: Guy Stalnaker <jstalnak@wisc.edu>
Subject: Re: Issues with HP DV4 laptop sound after Ubuntu
 Jaunty 9.04 upgrade
Date: Tue, 05 May 2009 08:54:59 -0500
Message-ID: <4A004533.6030204@wisc.edu>
References: <49FD2446.7040001@wisc.edu> <s5h4ow19way.wl%tiwai@suse.de>
	<49FF0923.60902@wisc.edu> <s5hbpq7ddtr.wl%tiwai@suse.de>
Reply-To: jstalnak@wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from argol.doit.wisc.edu (argol.doit.wisc.edu [144.92.197.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 112341037FA
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 15:55:15 +0200 (CEST)
Received: from avs-daemon.smtpauth3.wiscmail.wisc.edu by
	smtpauth3.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 7.0-5.01 32bit (built Feb 19
	2009)) id <0KJ60070GC016900@smtpauth3.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Tue, 05 May 2009 08:55:13 -0500 (CDT)
In-reply-to: <s5hbpq7ddtr.wl%tiwai@suse.de>
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

Takashi,

I will take my queries there. Thanks for your help!!

Guy

Takashi Iwai wrote:
> At Mon, 04 May 2009 10:26:27 -0500,
> Guy Stalnaker wrote:
>> Hello again, Takashi,
>>
>> Can you think of why a new distribution might be the cause, or a change
>> that a new distribution makes, that would result in such behavior?  The
>> new distribution includes a new kernel and a new version of xorg (I
>> think), so everything on top of the hardware is new. What's damned
>> peculiar is that the HTML output interface is always recognized
>> successfully. It's only the Audio device: ATI Technologies Inc SBx00
>> Azalia (Intel HDA) on pci 00:14.2 that seems to have this issue.
>>
>> To add oddity to the issue, I brought the laptop to work this morning
>> and on boot the Audio device was successfully recognized and aplay -l
>> shows it a card 0!!
>>
>> I wonder ... do you think that it's possible that a keyboard, mouse,
>> printer, or some other USB device plugged into the laptop at boot could
>> affect something like this?  That's really the only difference between
>> work and home.
> 
> I guess it's an issue with ACPI or core PCI layer.  Or suspend, if
> this happens only after suspend/resume and not after a fresh boot.
> 
> In any way, I recommend you to report this on kernel bugzilla.
> 
> 
> Takashi

-- 
Guy Stalnaker, I2@DOIT, jstalnak@wisc.edu
1210 West Dayton Street, Room 3209 CSS, Madison WI 53706
work 608.263.8035, cell 608.235.4718, fax 608.265.6681
