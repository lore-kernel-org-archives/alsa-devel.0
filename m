From: Arve Knudsen <knuarv@nith.no>
Subject: RME9636 - still struggling
Date: Thu, 17 Apr 2003 21:09:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050606592.3e9efc003ef4b@webmail.nith.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Here I am again, still not able to get a single noise out of my Hammerfall Lite 
with Alsa (0.9.2). The OSS interface seems to work, though I haven't done 
anything with it programmatically.
As Paul (Davis) suggested earlier I've now tried the non-interleaved method, 
writing to all 18 channels of the card, using mmap, 32bit signed integers. 
However, I get no output. I even modified the pcm.c test program that comes with 
alsa-lib so that it would work with my card (changed the sample format), and I 
get no output from that either (using the direct_noninterleaved method).
Is it supposed to be this hard? I bet I'm doing something wrong, but I can't see 
what at this point. As far as I know there isn't any mixer to unmute with this 
card?

Thanks in advance

A


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
