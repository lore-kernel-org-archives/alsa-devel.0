From: novamail@novanix.com
Subject: AD1888 sound driver mainly working but optical problems.
Date: Wed, 03 Mar 2004 14:15:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1Aybpe-0004En-Rm@server3.novanix.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I have the AD1888 on the P4P800S working to some degree.  I have the alsa drivers and it reads the card as: SIS SI7012 and Chip as obviously AD1888.   All sound seems to come out the headphone port no problem, however the optical out is a bit more flaky.  I seem to have mplayer working via optical out as long as I have the following set in alsamixer:


IEC958 Playback Source:  AC-Linkv (A/D conv also works but often has a tinny sound to it)


IEC958 Playback AC97-SPSA: 0


However, when I go to play a wav file (using aplay or mplayer) something goes wrong and it automatically mutes the IEC958 item in alsamixer.  On my previous motherboard I remember there being an option to convert wav type audio to the optical jack without a problem,  is there some way I can still do that?


 


Thanks for everyones help on this driver.
                 Thank You For Your Time,
                                                      Nick Daum
                                         http://www.Novanix.com


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
