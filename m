From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: testing alsa-lib.
Date: Fri, 02 Apr 2004 18:00:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <406D9C41.7080008@superbug.demon.co.uk>
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

alsa-lib contains a test program pcm.c that tests playback using all the 
different modes alsa-lib can do.
Can we have a similar application for capture.
When developing an alsa driver, it works fine with arecord, but fails 
with jackd, and the only difference is that arecord just uses 
snd_pcm_readi(), and jackd uses poll instead.
It would be nice to have a test application that could test all 
different sound capture modes, readi, poll, async etc.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
