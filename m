From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [Alsa-devel] hdsp fixes
Date: 26 Jan 2005 13:22:13 -0800
Message-ID: <1106774533.9769.250.camel@cmn37.stanford.edu>
References: <1106761331.11426.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <planetccrma-admin@ccrma.stanford.edu>
In-Reply-To: <1106761331.11426.17.camel@localhost>
Sender: planetccrma-admin@ccrma.Stanford.EDU
Errors-To: planetccrma-admin@ccrma.Stanford.EDU
List-Help: <mailto:planetccrma-request@ccrma.stanford.edu?subject=help>
List-Post: <mailto:planetccrma@ccrma.stanford.edu>
List-Subscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=subscribe>
List-Unsubscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=unsubscribe>
List-Archive: <http://ccrma-mail.stanford.edu/pipermail/planetccrma/>
To: thomas charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, planetccrma@ccrma.Stanford.EDU, Takashi Iwai <tiwai@suse.de>, "Michael E. Smith" <melkhorn@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-26 at 09:42, thomas charbonnel wrote:
> Sorry for my long absence. Here's a patch against 1.0.8 that should
> solve the firmware issues people are experiencing.

Wow! Thank you!!
I just tested a build of it on top of 1.0.8 and it loaded the firmware
on the first try with hotplug, no problems so far in simple tests (9652
+ Digiface on top of Fedora Core 3). 

Takashi-san: sorry, I did not try your smaller patch, I went with what
Thomas posted. 

Planet CCRMA dwellers... packages coming up soon :-)
Beautiful!
-- Fernando

> ChangeLog:
> * init sequence cleanup and firmware upload related bugfixes
> * more robust revision detection scheme
>   (should transparently handle new revisions)
> * allow hdsploader and the kernel fw loader to coexist
>   this is useful for cardbus user who compiled the driver in-kernel
>   (userspace may not be ready to upload the firmware when the card
>    is probed)
> * removed confusing and obsolete passthru option (was interfering
>   with the mixer when opening the device for capture or playback)
>   this change requires a recompile of the userspace tools against
>   the patched hdsp.h
> * removed confusing and obsolete line_outs_monitor module param
> * made precise_ptr the default behaviour, and runtime tweakable
>   (removed corresponding module param)
> * small endianness fix
> * ALSA-Configuration.txt HDSP entry update
> * error messages cleanup
