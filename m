From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1:
 add interval timer support)
Date: Sun, 26 Sep 2004 20:40:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096245611.7203.66.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
	 <200409241453.i8OErtVR029650@localhost.localdomain>
	 <s5hk6uj3dko.wl@alsa2.suse.de> <1096059735.11589.45.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409261335020.1744@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409261335020.1744@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-09-26 at 07:38, Jaroslav Kysela wrote:
> On Fri, 24 Sep 2004, Lee Revell wrote:
> 
> > While certainly easier to implement in the driver, the problem with a
> > single 16 channel device is that it wastes voices.  In the example of a
> > non-ReWire compliant app (which is the same as working around a non-JACK
> > aware app), you would have to use 16 voices for each open, even if the
> > device will only use 2 of the channels.
> 
> No, read carefully my messages:
> 
> - legacy applications will use standard device
> - multichannel applications will use one (or more) multichannel device
> 

I think I understand you.  This is how I have written the driver.  I'll
post a patch as soon as the code is cleaned up.


> Then you need an application like ReWire which will touch / modify the 
> universal controls to reroute channels from bloth multichannel and legacy 
> application to appropriate FX bus.

Yes, the mixer support is an issue I have not addressed yet.  It will
also require ld10k1 and some additional DSP code; since the EFX device
captures the outputs and not the FX buses you need to connect FX buses
(or physical inputs) to the outputs that are selected with the "EFX
voices mask" control.

> 
> Everybody will be happy with minimal count of extended voices.
>

Yes, I agree.  Right now I have the first 16 voices reserved for the
multichannel device.  For the default playback device voice allocation
starts at 16. 

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
