From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Fwd: [ALSA: doc notes additions]
Date: Mon, 16 Feb 2004 09:18:01 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40300C39.9000703@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

The following has been submitted as a note for the documentation of 
intel8x0.


        	       	acharnley andrew.charnley@nvmax.com</a><br>
        	       	Sunday, 15 February 2004</td>

Support for nForce 2 chipset (Shuttle, Slackware 9.1) appears broke
with xine 0.96 after ALSA 0.9.6. XMMS et all still working fine.

Any changes to .asound as mentioned above cause any audio app to lock up.
I have had to remove .asound and use defaults.

I am _desperately_ trying to convert standard 2 channel audio to
Dolby Digital stream in XMMS and pass through instead of passing
2 channel through IEC958 and having to use ESP effect on my
external AMP.

I see ALSAMIXER has duplication options and send analog to IEC958,
which would be perfect, but none of those controls work. :(







-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
