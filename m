From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: recording issues
Date: Thu, 02 Oct 2003 09:36:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20031002093600.pochini@shiny.it>
References: <200310011434.29210.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310011434.29210.n8gray@caltech.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nathaniel Gray <n8gray@caltech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 01-Oct-2003 Nathaniel Gray wrote:
> My sound card uses different devices for capture (device 0) and playback 
> (device 1).  I have two issues with capture right now:
> 
> 1.  If I do something like:
>       arecord -f dat -D hw:0,1 -d 5 foo.wav
> it seems to record for much longer than 5 seconds.  In fact, "time
> arecord..." tells me that it goes for 10 seconds.  If I then try to
> play back the result with aplay:

Try aplay/arecord -v[vvvvvv] to see what parameters have been actually
set. You can also put printk()'s in the driver to check what's going
on. Why are you using different devices for capture and playback ?
Perhaps it's a typo, but if capture is dev 0, you have to type

arecord -D hw:0,0
                ^
                |


--
Giuliano.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
