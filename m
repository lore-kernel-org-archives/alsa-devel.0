From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: intel8x0 driver motorboots (gets caught in loop)
 in Quake 3
Date: Thu, 13 Feb 2003 11:08:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4B6E83.2070000@uni-bonn.de>
References: <3E4A8A39.9000608@uni-bonn.de> <s5h4r78mrrr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r78mrrr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> could you check whether the interrupts properly generated during the
> repeated sounds?

I'll be happy to do whatever I can, but I don't exactly know what you 
mean. How do I check whether the interrupts are properly generated?


I'm fairly certain that I don't have any irq conflicts:

josh@spleen:/var/tmp/blah$ cat /proc/interrupts
            CPU0
   0:     860465          XT-PIC  timer
   1:      11671          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   4:      52364          XT-PIC  serial
   5:      26156          XT-PIC  eth1
   8:          3          XT-PIC  rtc
  10:      44468          XT-PIC  SiS SI7012
  11:     657820          XT-PIC  nvidia
  12:          0          XT-PIC  eth0
  14:      36395          XT-PIC  ide0
  15:      84988          XT-PIC  ide1
NMI:          0
ERR:          0
josh@spleen:/var/tmp/blah$




-josh


-- 
"When you wake up in the morning, Pooh," said Piglet at last,
"what's the first thing you say to yourself?"

"What's for breakfast?" said Pooh.  "What do you say, Piglet?"

"I say, 'I wonder what's going to happen exciting today?'" said Piglet.

Pooh nodded thoughtfully.  "It's the same thing," he said.

	-- A.A. Milne

-----------------------------------------------------
http://www.nyfairuse.org/

WTO + WIPO = DMCA http://www.anti-dmca.org

Innovation vs Patent Inflation http://swpat.ffii.org/

120000 voices and 400 Firms against logic patents
http://www.noepatents.org/
-----------------------------------------------------




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
