From: =?ISO-8859-2?Q?Pawe=B3_R=F3=BFa=F1ski?= <tokugawa@wp.pl>
Subject: ALC655 OSS problems (1.0.0rc2)
Date: Sat, 06 Dec 2003 01:55:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FD128E5.6010808@wp.pl>
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

Hi,
   I have that odd version one (as i read Richard Chan have that one too)

   cat /proc/asound/cards
   0 [rev60  ]: VIA8233 - VIA 823x rev60
                VIA 823x rev60 at 0xe800, irq 7

   When I play quake3 everything is ok until game will play any music.
   After that it soft-freeze (I hear repeating sound, but i can change
   console and anything other works)

   And this is only the case. (I deleted music from data files, and
   everything works (without music of course))

   I use enable/direct options in pcm plugin (it is required to run the
   game)

   last lines of strace looks like:
      gettimeofday({1070667266, 963956}, NULL) = 0
   and after hang it stops too.

   And i have simple question... since ACL655 is 48000 only (am i right?)
   so the resample work is up to dirver ??? I ask because i can aplay any
   .wav and it sounds good, but when mplayer opens alsa (eg for 22050),
   alsa works like 48000 (and i hear faster(higher) sound, faster movies
   and so on). Only solution for that is srate 48000 (mplayer will
   resample by himself)

   Is this an alsa or mplayer bug ? = driver resamples/aplay resamples ?

thx for any info, and thanks for dxs support (i use this to hear music
while i play, simple script and aplay plays quake's music :),
Pawel Rozanski

Ps. I doubt if Richard Chan plays games, but maybe he can confim my problem)



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
