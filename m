From: Peter Christensen <peter@developers.dk>
Subject: Mixer control names out of control?
Date: Sat, 27 Nov 2004 10:26:40 +0100
Message-ID: <41A84850.5000604@developers.dk>
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

Hello,

Am I the only one feeling that the names of the mixer controls in ALSA is somewhat out of control? Especially when it comes to IEC958.

First of all, the AC97 driver uses the name "IEC958 Playback SPSA". What's wrong with "IEC958 Playback Volume"?

Next, quite a few drivers do not use the SNDRV_CTL_NAME_IEC958 macro, whose purpose I suppose is to ensure that alle IEC958 mixer controls follow a 
common naming syntax. Anyway, alot of drivers for some reason uses "Output" and "Input" instead of "Playback" and "Capture". Is this on purpose?

The reason I make such a fuss about it, is that I wanted to make a structured organized mixer for GTK, so that people don't have to use the sometimes 
messy and confusing alsamixer and gnome volume control (in general, all mixers based on the ALSA Simple Mixer controls). But then it struck me that 
the simple mixer did have some potentional, and the chaos basically was based on poor sorting of elements (which you can do manually in your program), 
its inability to detect several "new" mixer control names such as (Front,Rear,Side, etc.), and then the inability to have both a Switch and a Route 
element with the same name (The ice1724 driver was force to use "IEC958 Output Switch" instead of "IEC958 Playback Switch" due to this).
It is my belief, that if the simple mixer library routines was updated, and the mixer elements got proper names, the world would be alot better.

But is this simple caused by programmers not truely knowing the ALSA naming conversion or is there some deper sence in this?

I did consider makine a patch which changed the whole naming thing, but it would probably be to vital for people to accept?!

Thanks
   Peter Christensen


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
