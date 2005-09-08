From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel/ALC260: mixer control issues
Date: Fri, 9 Sep 2005 09:13:21 +0930 (CST)
Message-ID: <200509082343.j88NhLOw022109@auster.physics.adelaide.edu.au>
References: <s5hzmqn6hwd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmqn6hwd.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 08, 2005 11:14:10 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> > > It's fine as long as you use ALSA native apps, but remember that some
> > > apps require certain known controls.  Also, OSS emulation wouldn't
> > > work properly.
> > 
> > Note that the above names were abbreviated for brevity: "IntSpeaker" is
> > really "IntSpeaker Playback Volume", etc.  I should have made that clear.
> > 
> > Are these "known special names" documented anywhere?
> 
> No, it depends on apps.  Many apps want to use either "Master" or
> "PCM" control.

No worries.  I'm not touching the "PCM".

> > It'd be nice if we could have a mixer control which allowed the user to
> > switch the LineOut socket between a true LineOut and a "Headphone" output
> > (that is, a pin with the internal headphone amp turned on).  I don't think
> > there's infrastructure to allow this, however.  That might have to become
> > a module parameter (lineout_is_headphone, enable_hp_amp or something).
> 
> Basically the control names correspond their roles, not (always) the
> pin assignment.  For example, on ac97, the ture line-out is handled as
> master (processed according to a quirk table or a module option).

Sure, no worries.  I guess the problem I have with "Master" in this case is
that "LineOut" on this laptop doesn't actually control every output (which
is what "master" tends to imply, at least to me) - the internal speaker is
separate.  Anyway, I'll try to come up with something which is consistent and
submit a patch early next week for your consideration.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
