From: Tom Watson <sdc695@yahoo.com>
Subject: VIA chip (8235) with motherboard connections and ALSA
Date: Sun, 4 May 2003 00:19:08 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030504071908.28520.qmail@web21505.mail.yahoo.com>
References: <20030502120001.14973.qmail@webmail18.rediffmail.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030502120001.14973.qmail@webmail18.rediffmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK, I got the driver and all is working.  Well, sort of...  The
motherboard has this chip (VIA 8235) with a three jack I/O on the back
panel.  The motherboard documents this as "2 channel": Line-in,
Line-out, and Mic, and "6 channel":  Rear L/R, Front L/R, and
Center/Sub.

Now I'm playing around a bit with mixers and the following happens:
I've got a CD (just fine), and I can get it to go out the "Line
out/Front L/R" jack, and the "Master" mixer control works on this.  I
find out that if I turn up (and unmute) the "headphone" control, the
same pair of channels now comes out the "Line-in/Rear L/R" jack.  In
addition, if I turn up the "Line" control, I get feedback (internal, I
guess).

To say the least I'm a bit confused.  The controls don't seem control
what I figured they would.  I'm willing to experiment a bit, and I'd
like to get some information on how the chip works (is there a source
document that describes the VIA chip??).  Then maybe I can figure it
all out.

Thanks for any information supplied.

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
