From: Torsten Mohr <tmohr@s.netic.de>
Subject: Docu:: Alsa Audio API:: A minimal capture program
Date: Tue, 27 Jan 2004 22:40:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401272240.03344.tmohr@s.netic.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

i copied the "minimal capture program" from the
Alsa page -> Documentation -> Tutorial on using the
ALSA Audio API -> A minimal capture program.

I added "int rate = 44100" and changed the wrong
parameter "44100" in "snd_pcm_hw_params_set_rate_near"
to "&rate".

bash# gcc capture.c -lasound
bash# a.out default

But if i add a "sleep(1)" in the "for(i = 0; i < 10; i++)",
the whole program crashes.


I want to write a program where some chunk of
data is sampled from time to time, with some delay
inbetween.  The behaviour above (with sleep(1))
is a good example for what i want to do.

Can anybody tell me what i need to change to make
the program work ok?


Thanks for any hints,
Torsten.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
