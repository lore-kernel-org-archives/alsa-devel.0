From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] thinkpad-acpi: Enable microphone mute LED
Date: Fri, 27 May 2011 19:26:50 +0100
Message-ID: <20110527182650.GA19697@srcf.ucam.org>
References: <8dc2b2140c2794291811cd38f51f9dc7596f482c.1306266017.git.luto@mit.edu>
 <20110527162844.GA16769@srcf.ucam.org>
 <BANLkTint5_Vcm5rWKHL_j5XsVmcAu8X7pw@mail.gmail.com>
 <20110527164855.GA17443@srcf.ucam.org>
 <BANLkTimuXJchtdeV0BT3A=BTvihOFShhwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTimuXJchtdeV0BT3A=BTvihOFShhwA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, mzjro@0pointer.de
List-Id: alsa-devel@alsa-project.org

On Fri, May 27, 2011 at 02:22:26PM -0400, Andrew Lutomirski wrote:
> On Fri, May 27, 2011 at 12:48 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Hm. That makes things kind of tricky. While it's easy to just expose the
> > LED, really we want to do it in such a way that userspace knows which
> > LEDs it should be toggling while setting the microphone mute.
> 
> One thought: call the thing laptop::micmute and teach userspace to
> look for an led with that name.

Yes, I think standardised naming is going to be necessary to make this 
kind of thing work. That just leaves us with the additional problem of 
figuring out who has responsibility for toggling it and maanging 
permissions appropriately, but we'll get to that.

> Do any of the ALSA or PulseAudio people have any preferences?

Cc:ed Lennart to get his perspective.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
