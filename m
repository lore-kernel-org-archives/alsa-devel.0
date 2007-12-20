From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Userspace control of HDA port connections
Date: Thu, 20 Dec 2007 16:45:09 -0500
Message-ID: <76366b180712201345q2169cec2q40cbf5a40226a918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 50CF42484A
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 22:45:11 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so28848rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 13:45:09 -0800 (PST)
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi,

I'm wondering if there is any interest in providing a userspace way of
modifying the HDA port/mixer input/output mappings? The driver
currently uses hard-coded models to define the standard configuration
for a given piece of hardware, but this doesn't allow a user to
redefine a line-in port as an output port if the chipset has an
available unmapped mixer. I'm bringing this up because from what I
understand of the ALC883 is that it has 4 mixers, yet on my
motherboard there are only 3 ports configured as output by default
(6stack-dig). Correct me if I'm wrong, but I should be able to map all
of the physical jacks as outputs and then assign each of the mixers to
a jack or more than one jack. That would require adding a new model to
the driver and/or unloading/reloading the module with a new model
string. In a system which has the driver built-in and isn't using
modules, this requires a reboot. If there was a userspace way of
reconfiguring the jacks (via /proc/asound?) then perhaps even all of
the hardware -> model mappings could be moved into a little tool run
at boot time which doesn't require a kernel change every time new
hardware is introduced. A nice little ncurses tool could even be made
to modify port mappings. What do you think? If I'm misunderstanding
the capabilities of the chips please let me know.

Thanks,
-Andrew

p.s. I still have yet to test out the multi-card patch. I'll reply to
that once I have more info.
