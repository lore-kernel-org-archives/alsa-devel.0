From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000951]: Fix bugs with early IRQs mishandling, missing silence fill, and wrong timing calculations
Date: Tue, 1 Mar 2005 09:36:07 +0100
Message-ID: <62ab2ce44ab6e446ac88c74750311498@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 69349201
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2005 09:36:08 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been set as RELATED TO issue 0000946.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=951> 
======================================================================
Reported By:                charles_levert
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   951
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-28-2005 21:26 CET
Last Modified:              03-01-2005 09:36 CET
======================================================================
Summary:                    Fix bugs with early IRQs mishandling, missing
silence fill, and wrong timing calculations
Description: 
A patch is forthcoming.

Here is the text from the patch preamble.

    This patch is against alsa-driver-1.0.8.
    It covers:
        alsa-kernel/core/pcm_lib.c
        alsa-kernel/include/pcm.h
        alsa-kernel/core/pcm_native.c
        alsa-kernel/core/oss/pcm_oss.c
    The main changes are in the first listed file.

    An original bug description was filed
    under "[ALSA - driver] PCI - cmipci":
        <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=946>
    since the problems were first observed on this hardware.

    The patch fixes the following problems:

     -- Properly handle early IRQs in
        snd_pcm_update_hw_ptr_interrupt() in pcm_lib.c.

        This does occur, at least with CMI8738MC6 hardware.

        This bug had a major impact that caused the DMAs
        to run for too long and irritating noise to be
        heard at the end of playback.

     -- Properly compute estimated time of next interrupt
        in snd_pcm_update_hw_ptr_interrupt() in pcm_lib.c;
        this is no longer done with a
        "... % runtime->period_size" kludge (which didn't
        even attempt to round to nearest instead of merely
        truncating).

     -- Test whether hw_avail is big enough to handle
        the next runtime->period_size in
        snd_pcm_update_hw_ptr_post() in pcm_lib.c,
        otherwise call snd_pcm_tick_prepare() to
        tentatively set up a timer if needed (to be able
        to take earlier action in that case).

     -- Centralize all folding of values with regard to
        runtime->boundary in the new snd_pcm_next_buf()
        function in pcm_lib.c.

        All relevant values are now systematically in
        coherent synchronization without resorting to the
        ugly and error-prone "value %= runtime->boundary"
        kludge all over the place; unobvious wrapping
        conditions testing is no longer needed in these
        places.

        A safe zone worth one runtime->buffer_size is now
        kept on the left side of the operating interval,
        just like it was the case for the right side;
        this is necessary for proper simplified operation.

     -- Direct manipulations of values with respect to
        runtime->boundary needed to be brought in line
        with new proper practices (and thus simplified)
        in pcm.h, pcm_lib.c, pcm_native.c, and pcm_oss.c.

     -- Isolate the second part of
        snd_pcm_playback_silence() in the new
        snd_pcm_playback_silence_fill() function in
        pcm_lib.c.

        This makes the code more readable since the
        task this performs should not be confused with
        what is done in the remaining first part of
        snd_pcm_playback_silence().

        The isolated code is unchanged.

     -- Rewrite the remaining first part of
        snd_pcm_playback_silence() to properly handle all
        situations, including computing minimum silence
        insertion even when "runtime->silence_size == 0".

        This is needed for proper operation of the aplay
        program, for one, and is much more forgiving on the
        user; insertion of silence samples in user space
        was always useless and a wrong solution anyway (but
        user space specification of kernel space silence
        insertion is useful and still very much supported).

        The code is now much more straightforward to read.

        Updates of runtime->control->appl_ptr (due
        to the user writing samples) and updates to
        runtime->status->hw_ptr (due to the audio hardware
        consuming samples) are now _both_ properly
        accounted for in all cases; the new code makes
        this much more obvious.

     -- All calls to snd_pcm_playback_silence() in
        pcm_lib.c and pcm_native.c must no longer be under
        the "runtime->silence_size > 0" condition.

     -- Properly perform rounded-up integer division in
        snd_pcm_system_tick_set() in pcm_lib.c.

        This only had a minor impact.

     -- Properly compute distance to next interrupt in
        snd_pcm_tick_prepare() in pcm_lib.c; again, avoid
        using any "... % runtime->period_size" kludge.

     -- The usage of runtime->rate in
        snd_pcm_tick_prepare() in pcm_lib.c was incorrect,
        regarless of other changes.

        The impact was that the timer was systematically
        set to 1 single tick when it needed to be set to
        typically hundreds of ticks.

     -- The usage of runtime->sleep_min in
        snd_pcm_tick_prepare() in pcm_lib.c was incorrect,
        regarless of other changes.

        The impact was that the number of ticks for
        the timer was not properly adjusted up to what
        sleep_min is documented to mean, when needed.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000946 Early playback DMA IRQ with CMI8738MC6 ...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-28-05 21:26 charles_levert New Issue                                    
02-28-05 21:26 charles_levert Kernel Version            => 2.4.22          
02-28-05 21:29 charles_levert File Added: early-irqs.patch                    
03-01-05 09:36 perex          Relationship added       related to 0000946  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
