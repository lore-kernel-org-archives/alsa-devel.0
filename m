From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: aplay not playing MPEG
Date: Mon, 21 Jul 2003 14:42:17 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030721144218.92.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Can aplay/alsa send raw MPEG data to a card?

  aplay -Dhw:0  -v -t raw --channels=2 --format=MPEG --rate=44100 ~/audio/44khz
  Playing raw data '/home/eliot/audio/44khz' : MPEG, Rate 44100 Hz, Stereo
  aplay: set_params:805: Sample format non available

This command works fine if I specify S16_LE, S23, FLOAT, S24, but not MPEG.
Any suggestions as to whe - do I have a hope of making it work?
(My card supports all the above including MPEG in exactly the same way as far as
ALSA driver is concerned)

I have stepped through the code, and got lost in the bit twiddling of masks and
formats.  One thing I notice is that only the linear formats are mentioned in
many of the functions in pcm_misc.c eg  snd_pcm_format_width()

thanks

Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
