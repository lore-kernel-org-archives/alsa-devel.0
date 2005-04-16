From: fab <fab@gnux.info>
Subject: Intel HDA == No sound
Date: Sat, 16 Apr 2005 15:34:30 +0200
Message-ID: <20050416133430.GA14581@blackmilk.localzone.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I have a new Medion laptop and the card is intel hda, I got the last
alsa version (devel, 1.0.9rc2) and the module loads OK.
I can get the mixer so it seems to be OK.

I don't know if it's revealent but when the module loads I get :
ALSA
/home/fab/drv/sound/alsa/alsa-driver-1.0.9rc2/alsa-kernel/pci/hda/hda_codec
.c:512: hda_codec: no AFG node found

If I want to play sound I have no output at all, even console beep :(
I put all my outputs at 100% so it's not levels.
I discovered that if I plug something in the output jack It plays !
But the internal speaker isn't active...

alsaplayer don't makes any warnings but when I play with mplayer I get:
alsa-space: xrun of at least 0,002 msecs. resetting stream                                                                                           
alsa-space: xrun of at least 0,001 msecs. resetting stream                                                                                           
alsa-space: xrun of at least 0,001 msecs. resetting stream                                                                                           
alsa-space: xrun of at least 0,001 msecs. resetting stream                                                                                           

And the sound is chunky.
If I put -ao oss I don't get this warning and the sound plays well.

I don't know if there is an issue to this 2 problems.

Best regards.
Fabien Devaux.

PS: I've not subscribed to the list.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
