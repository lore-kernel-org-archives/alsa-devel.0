From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Fw: writing audiowerk driver (philips saa7146a), some questions
Date: Fri, 31 May 2002 15:36:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000c01c208b0$a18fd720$0400a8c0@martijn>
References: <001801c2088f$71693120$0400a8c0@martijn><s5hg008h829.wl@alsa2.suse.de><003201c208a3$d8e06030$0400a8c0@martijn> <s5helfsh319.wl@alsa2.suse.de>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> there is a runtime instance for a pcm stream, and this holds the
> informaton such as the current rate, channels, formats, etc.
> there is no pitch parameter implemented in alsa, but this can be added
> easily into the runtime instance, if inevitablly necessary.

i don't think the audiowerk is the only card capable of varipitch, though
most cards don't support it, but it is a nice feature and since alsa is
supposed to be advanced... :)

> alsa pcm engine invokes a timer interrupt to update the "tick", and
> this tick is determined using the rate of the runtime instance.
> if you change the rate value dynamically during playback, then the
> tick interrupt will be wrongly scheduled, and leads to wrong detection
> of under/overrun.

shouldn't the driver detect under/overrun? would a soundcard with a
bad dac (as in not accurate) also cause problems?


--martijn






_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
