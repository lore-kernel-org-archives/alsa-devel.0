From: "M. Nentwig" <nentwig@users.sourceforge.net>
Subject: Hammerfall DSP: Midi-related audio dropouts workaround / question
Date: Fri, 15 Nov 2002 08:45:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD4980D.8C70735B@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

a couple of days I wrote about audio dropouts caused by MIDI data.
Now I found a workaround: Unloading the uhci (USB) driver, loading the
hammerfall driver, reloading the uhci driver gets rid of the dropouts.
Also plugging in a USB device helps. Both USB controller and hdsp share
the same interrupt on my laptop.

Before I found this workaround, I spent some time hacking the hdsp
driver. I created a new thread, that sleeps
('interruptible_sleep_on(sth)'), until the MIDI interrupt wakes it
('wake_up'(sth)). As long as it's doing no real work (just counting MIDI
events for example), everything works fine.
But as soon as I take the MIDI processing out of the interrupt (or
remove it completely), the machine locks up. Probably during the
interrupt - even the 'magic sysrq key' is dead. And I don't understand
this at all. Does the hardware crash, if I don't empty the MIDI FIFO
queue in time?
The crash occurs also, when MIDI processing is removed from a vanilla
hdsp driver.

Some related observations:
- The dropouts disappear, if I disable MIDI interrupts. But then MIDI in
is unreliable, big surprise.
- The dropouts don't get any better, if I don't submit the received data
to alsa at the end of the MIDI-in processing.

Regards

Markus



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
