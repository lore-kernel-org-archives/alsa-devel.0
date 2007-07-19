From: David Webb <david.webb@noc.soton.ac.uk>
Subject: The users view of an audio card
Date: Thu, 19 Jul 2007 18:12:54 +0100
Message-ID: <200707191812.55106.david.webb@noc.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.iss.soton.ac.uk (mailgate5.iss.soton.ac.uk
	[152.78.128.106])
	by alsa0.perex.cz (Postfix) with ESMTP id 1774724179
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 19:10:48 +0200 (CEST)
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

I've been editing a couple of the unofficial wiki pages and a number of issues 
have arisen.  My own system has the NVidia/Realtek motherboard chips so I may 
be in the dark about what is available on other chips.  Some of the questions 
are background to ensure that what I write later in the wiki is correct.  
Takashi Iwai suggested I raise the issues here:

1.  A large number of users seem to be reporting problems with Nvidia and Via 
soundcards.  As far as I can tell Nvidia and Via do not produce soundcards 
but they do produce chipsets with southbridges which can connect to a 
motherboard audio chip.  The when alsamixer (or Kmix) runs it reports 
something like:
  Card:  NVidia CK804
  Chip:  Realtek AL650 rev 0
Presumably because the southbridge is the primary PCI device.

So:

1.1  Is the above always correct (so I can add it to the wiki)?
1.2   Could alsamixer etc be modified to give a more sensible answer for 
non-experts.  

Something like:
  Card:  Motherboard via NVidia CK804
  Chip:  Realtek AL650 rev 0
might work.  I presume a look-up table is used to convert the PCI 2-byte 
integers to the above names so presumably the extra information needed could 
be obtained at this level.

2.  On different motherboards a Realtek 650 may be connected using a NVidia 
CK804 with the intel8x0 alsa driver or using a VIA VT8233 with the vt82xx 
driver.

2.1  Given that the audio chip registers are the same in both cases why are 
two different drivers needed?  (Are they?)
2.2  If it is something to do with the southbridges, where may the manuals 
that describe the differences be found?  
2.3  What would happen if the motherboard manufacturers kept the same 
southbridges but started using an audio chip with a different set of 
registers?
(2.2a  Where can an AD'97 manual be found? - I could not find one on the intel 
site)

3.  The Realtek 650 datasheet implies that independently of the mixing in the 
main input -> line-out pathway, the input to the ADC (i.e. on capture) may 
include more than one source (i.e. both audio and microphone).  However 
alsamixer (and kmix) only allows me one input stream.  So:

3.1  Is the manual misleading or have I misread it?
3.2  Is the manual correct but the driver is based on an earlier intel chip 
which did not have this facility?

Related to this the manual seems to show a number of options which I cannot 
identify in alsamixer.  For example the manual shows two surroundsound volume 
stages between which there are switched links, one to and two from the main 
stero path.  Alsamixer shows a single amplifier.  It has one link 'from' the 
main path but I could not find a link 'to' the main path. 

3.3  Is the driver assuming a old layout which fits most of the new audio chip 
layout but not all?  (This is really a question about what sort of 
warnings/advice should my write up include).

3.4  At which stage does alsa relate the registers to the descriptions, 
aux-volume, aux-mute etc?  Again does it assume a layout which fits most 
aspects of the chips listed?

Thats enough for the moment.  I presume I could sit down for a year and read 
and understand the code - but in the meantime any help will be welcome.

Regards,

David Webb.
