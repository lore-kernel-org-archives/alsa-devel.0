From: Michael Jochum <e9725005@stud3.tuwien.ac.at>
Subject: rtcw,quake3 hang on exit
Date: 20 Mar 2002 20:58:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1016654302.933.2.camel@mjo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi!

some time back there has been a similar bug report about the same
problem:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg01675.html
with no response ... so i will be a bit more verbose :)

it have this problem on all computers (Athlon, P3, P4, Cleron) i have
access to. all of them have different sound cards (SB128, SB Live, AC97
Via686 and AC97 on a i845) and on all of them i have used various 0.9
betas of alsa and versions of the linux kernel (2.4.5 to 2.4.18).
no problem with the oss driver

i have done a strace run of rtcw and found some interesting things:

somewhere rtcw opens the dsp device:
open("/dev/dsp", O_RDWR)                = 16
but i cant find the coresponding
close(16)

this are the last lines of output (process locks here):

write(2, "----- CL_Shutdown -----\n", 24) = 24
write(2, "-----------------------\n", 24) = 24
fcntl64(0, F_GETFL)                     = 0x802 (flags
O_RDWR|O_NONBLOCK)
fcntl64(0, F_SETFL, O_RDWR)             = 0
write(2, "Shutdown tty console\n", 21)  = 21
ioctl(0, SNDCTL_TMR_STOP, {B38400 opost isig icanon echo ...}) = 0
_exit(0)                                = ?

i dont know much about kernel internals - but isnt _exit a kernel syscal
that is supposed to close all open devices?
so what kind of bug is this? rtcw? alsa? kernel?

this is a very anoying bug for me and it would be nice if someone could
help me with this problem. i have even mada a panel button to kill the
hanging processes :)

tia,
michael.



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
