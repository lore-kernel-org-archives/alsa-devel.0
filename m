From: Mark Hills <mark@pogo.org.uk>
Subject: Re: usb-audio: Correct way to do a mixer quirk?
Date: Fri, 24 Feb 2012 12:26:20 +0000 (GMT)
Message-ID: <alpine.LNX.2.01.1202241221310.1855@stax.localdomain>
References: <alpine.LNX.2.01.1202192059040.7408@stax.localdomain>
	<4F41FF5F.8040409@ladisch.de>
	<alpine.LNX.2.01.1202201945150.10992@stax.localdomain>
	<4F42BDC9.4040605@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id CCBFB104266
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 13:26:26 +0100 (CET)
In-Reply-To: <4F42BDC9.4040605@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Feb 2012, Clemens Ladisch wrote:

> Mark Hills wrote:
> > On Mon, 20 Feb 2012, Clemens Ladisch wrote:
> >> Mark Hills wrote:
> >>> The Electrix Ebox-44 is a new USB interface, but the MIXER_UNIT descriptor
> >>> is broken and refers to a non-existing unit_id.
> >>
> >> I'd suggest to change the code to not abort if a unit doesn't exist.
> >
> > It would seem a little strange to skip over the error for one specific
> > condition to accomodate a specific device -- when the rest of the code
> > does not generally do this?
> 
> It's still possible to complain about the broken firmware, but there is
> no reason to prevent the user from accessing the PCM streams and all
> other mixer controls just because one descriptors happens to be wrong.

The patch for this is relatively simple, I put it below for reference. The 
device can then be used; audio streams and a mixer are available.

But I'm not sure the resulting mixer is correct or complete so I'm in the 
process of getting access to one of these devices -- will allow me to 
check everything. I'll post more information when I have it.

Thanks

-- 
Mark


---
 sound/usb/mixer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ab23869..c374c72 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1388,7 +1388,7 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid, void *r
 	for (pin = 0; pin < input_pins; pin++) {
 		err = parse_audio_unit(state, desc->baSourceID[pin]);
 		if (err < 0)
-			return err;
+			continue;
 		err = check_input_term(state, desc->baSourceID[pin], &iterm);
 		if (err < 0)
 			return err;
-- 
1.7.4.4
