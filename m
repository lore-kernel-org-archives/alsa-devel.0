From: Daniel James <daniel@64studio.com>
Subject: Re: More info on hard lock-ups with MIDI on envy24, x86_64 machine
Date: Mon, 5 Dec 2005 12:34:16 +0000
Message-ID: <200512051234.16598.daniel@64studio.com>
References: <200508111525.07881.daniel@64studio.com> <200509161352.48802.daniel@64studio.com> <s5h4q8lrq80.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q8lrq80.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi, hi Lee,

I was unable to make any other progress with this bug, so I built a 
replica machine with a different motherboard, as I had begun to 
suspect a BIOS bug affecting PCI interrupts. Unfortunately, Tyan's 
support for BIOS updates seems to be very poor. 

I have put the tested M Audio Audiophile PCI sound card in the second 
test machine (identical configuration, Opteron 240, 1GB RAM except 
for motherboard, which is an ASUS SK8V. The Linux distribution 
installed is 64 Studio version 0.5.3 with kernel 2.6.13). MIDI 
appears to work perfectly in the second machine - at least I can get 
output from amsynth, and I can't reproduce the lock-up.

I therefore conclude that there is a motherboard/BIOS bug or a random 
hardware fault on this particular Tyan Tiger K8W S2875 board which 
causes the hard lock-ups when MIDI is used, but only
on an envy24 chipset card - it works fine with an EMU10K1 card such as 
a SoundBlaster Live. Weird, huh?

Thanks for all your help!

Daniel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
