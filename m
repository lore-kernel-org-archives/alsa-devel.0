From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecord wav file, buffer different
Date: Tue, 20 Apr 2004 11:08:54 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404201108040.25551-100000@studcom.urz.uni-halle.de>
References: <005601c424bf$ca5aac70$0403a8c0@win2K>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <005601c424bf$ca5aac70$0403a8c0@win2K>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mathieu Rondonneau wrote:
> I have some problem writing an ALSA driver:
>
> When i use arecord:
> arecord -d 10 -r 8000 -f S16_LE -t wav -c 1 test.wav
>
> the data area of the wav file (test.wav) is filled with 0.
> I compared the data of the wav file and the data of the capture buffer:
> They are different, the buffer is filled with audio datas.

Probably the pointer callback returns wrong data.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
