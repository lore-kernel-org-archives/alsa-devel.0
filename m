From: pdq808@t-online.de (Reiner Klenk)
Subject: Delta 410 support broken in CVS ?
Date: Sun, 28 Mar 2004 17:36:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4066F118.10902@t-online.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Greetings,
my Midiman Delta 410 doesn't work with CVS or 1.0.3
modprobe snd-ice1712 gives an error and the logfile says:

../alsa-kernel/i2c/cs8427.c:225: unable to find CS8427 signature 
(expected 0x71, read 0xff), initialization is not completed

../../alsa-kernel/pci/ice1712/ice1712.c:396: CS8427 initialization failed

The line numbers may be off slightly due to some additional printks 
added by me.

I suspected that the problem has something to do with the newly 
introduced timeout parameter for the ice1712 module but that parameter 
doesn't seem to be used up to the point where the error is generated in 
cs8427.c

The card seems to work OK with 1.0.2c (Fedora Core, kernel 2.4.22)

Ideas ?

Thanks,
Reiner



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
