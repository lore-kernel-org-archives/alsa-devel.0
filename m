From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: 1.0.4rc from cvs-head: snd-usb-usx2y still needs snd-hwdep....
Date: Wed, 31 Mar 2004 01:19:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403310119.34195.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

..., which is not built.
this is for kernel 2.4.

/etc/asound/driver_args:
--with-cards=via82xx,msnd-pinnacle,usb-audio,usb-usx2y,es1968 
--with-kernel=/usr/src/linux-2.4 --with-debug=full --with-sequencer=yes

regards,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
