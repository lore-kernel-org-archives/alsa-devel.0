From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Metering on record
Date: Sun, 28 Sep 2003 12:17:41 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030928121741.45922701.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi all,

I was hoping someone might be able to shine some light on the
following issue. I am currently opening an ALSA device for 
record say 44.1 kHz and reading 32k frames of data at a time.

Now with the above setup, if I want to do a meter, I can only
only update the meter every 32k frames or a little more than
once a second which makes for a very poor display.

So, looking at /usr/include/alsa/pcm.h I find some function
definitions which seem like they are meant for metering purposes.
Unfortunalety I can't seem to find any documentation on the ALSA
site nor can I find example code showing how this stuff is 
used.

Am I missing something or does this stuff just not exist? Do
these snd_pcm_meter_* functions work? Anybody have working code
that uses these things?

Thanks,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"Anyone who says you can have a lot of widely dispersed people hack
away on a complicated piece of code and avoid total anarchy has never
managed a software project." - Andy Tanenbaum in 1992 on comp.os.minix


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
