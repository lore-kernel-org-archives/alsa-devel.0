From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: [RFE] Power down AC'97 when muted
Date: Wed, 22 Dec 2004 20:41:23 +0100
Message-ID: <41C9CDE3.4020605@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have a request for a new feature in the AC97 driver (my card is an 
intel ICH4). I'd like to see the driver power off the AC97 part when the 
master volume is muted. Currently the power control has a seperate 
volume control that can be used.

The reason I want this is because my laptop has a LED indicating mute 
status. This is triggered by the power down function of the AC97 function.

Since the power is exposed through a volume control this could be done 
in user space, but that would me that every program that mutes the sound 
card would need special logic to see if the card has an "External 
amplifier" (as the channel is called). Therefore it seems much better to 
do this in the driver.

Another point is that Windows seems to have this behaviour (since the 
LED functions fine there in every application) so manufacturers rely on 
this (HP in my case).

I tried doing this myself by adding an extra call inside 
ac97_put_double() checking for changes to the master channel but I 
couldn't get it to work. I just got a faint flicker out of the LED. If 
people give me enough pointers I might be able to put together a patch 
for this.

Rgds
Pierre


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
