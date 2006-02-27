From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [A[PATCH] HDA/ALC260: 0/6 - update patch series overview
Date: Tue, 28 Feb 2006 10:17:49 +1030 (CST)
Message-ID: <200602272347.k1RNloPp014339@auster.physics.adelaide.edu.au>
References: <s5hlkvxt57f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkvxt57f.wl%tiwai@suse.de> from "Takashi Iwai" at Feb 27, 2006 12:24:20 PM
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

The following series of 7 patches (sent as separate messages with subject
line of the form "[PATCH] HDA/ALC260: x/7 - ...") contain a consolidation of
development on the ALC260 HDA codec from the past few weeks, as requested. 
Refer to the individual postings for details on what each one does.  A
summary follows for reference.

  patch 1/7: fixes the input mux label used in the test model to account for
    the fact that the two ADCs in the ALC260 have slightly different input
    selector layouts.

  patch 2/7: add code to switch a retasking pin's input/output buffer
    enables whenever the user changes the pin's mode.

  patch 3/7: generalise some structures added for the Fujitsu model but
    potentially useful for others.

  patch 4/7: add switches for the GPIO pins to the mixer of the test model.

  patch 5/7: add a new "acer" model.

  patch 6/7: some minor janitorial fixes to the fujitsu and test models.

  patch 7/7: add mixer controls to allow the SPDIF output to be enabled
    in test mode.

This series of patches has been generated against CVS from 24 Feb 2006.
They are cumulative, set up to be applied in turn from 1-7.

Having said that, all patches except 5 are more or less independent.  Patch
5 depends on the changes made in patch 3.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
