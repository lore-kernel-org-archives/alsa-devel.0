From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: start stop
Date: Mon, 12 Apr 2004 10:45:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002501c420a5$31dd35d0$0403a8c0@win2K>
References: <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass> <000901c4204e$6f0b3580$0403a8c0@win2K>
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

i'm writting an ALSA driver. I have some trouble with it.

I load the driver and then i play sound with dd (dd if=file.wav
of=/dev/audio0).
all goes right (i have noise rather than sound but, it's another problem).
the trigger call start then play noise, then call stop.

my problem is when i want to play another time, it doesn't work.
the trigger call start then stop then start then stop ...then start and
stop... and doesn't end and doesn't play any sound.

I thank you very much for any help.

regards,
Mathieu Rondonneau



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
