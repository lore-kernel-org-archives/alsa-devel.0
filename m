From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: aplay playback-pointer
Date: Mon, 12 Apr 2004 00:24:30 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000901c4204e$6f0b3580$0403a8c0@win2K>
References: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: alsa-devel@lists.sourceforge.net
Cc: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm writting an audio driver and i have some trouble.

when i use:
 dd if=file.wav of=/dev/audio0
the oss part of the ALSA driver seams to be used and some sound (not good
sound but noise) are coming out. (the playback_pointer operator is called)

but when i use aplay:
 aplay file.wav
nothing coming out, and the playback_pointer operator is not called.
nothing is called between the start and the stop trigger.

Maybe someone could tell me why the aplay command doesn't call the
playback_pointer.
Do i need to implement some specific functions in order to use aplay?

Thanks for any help.

regards,
Mathieu Rondonneau



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
