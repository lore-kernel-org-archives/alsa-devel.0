From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: arecord wav file, buffer different
Date: Sat, 17 Apr 2004 16:06:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <005601c424bf$ca5aac70$0403a8c0@win2K>
References: <Pine.HPX.4.33n.0404131825060.10741-100000@studcom.urz.uni-halle.de>
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
List-Id: alsa-devel@alsa-project.org

I all,

I have some problem writing an ALSA driver:

When i use arecord:
arecord -d 10 -r 8000 -f S16_LE -t wav -c 1 test.wav

the data area of the wav file (test.wav) is filled with 0.
I compared the data of the wav file and the data of the capture buffer:
They are different, the buffer is filled with audio datas.

Why my test.wav file is filed with zero?

Any ideas?

Thanks in advance.

regards,
Mahtieu



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
