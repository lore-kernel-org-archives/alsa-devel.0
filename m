From: Daniel MacDonald <danboid@yahoo.co.uk>
Subject: CORRECTION: NFORCE recording OK, me lame!
Date: Mon, 6 Oct 2003 03:46:05 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031006104605.2858.qmail@web86308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Doh!

Thanks to Jaroslav for the very speedy reply, but it
turns out that BOTH mic. in and line in recording work
fine under ALSA 0.9.7a / NFORCE2. I THOUGHT I had the
capture level up- it would've helped if I had actually
used my eyes and what little brain I have to realise
it was at 0. Sorry about that!

However, I did notice that the NFORCE page, as linked
on the ALSA Sound Card matrix, has been replace by
generic info, all the comments are gone too. Also, I
would recommend that:

options snd-intel8x0 mpu_port=0x330

be added to modules.conf by alsaconf by default (if it
doesn't already- I haven't run the 0.9.7a version as
everything is working fine now) as MIDI doesn't work
without it.

All the best to the ALSA team,

dan



__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
