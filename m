From: Alan Jenkins <sourcejedi@gmail.com>
Subject: softvol pcm plugin
Date: Sat, 06 Aug 2005 13:07:15 +0100
Message-ID: <1123330035.4472.18.camel@singularity.jenkins>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

What is the development status of softvol?  My hardware lacks volume
control, but softvol is unusable at the moment.  I've tried the latest
tarballs and current CVS.

Theres a bug somewhere which causes the volume control to expand to 255
channels sometime between initialisation and the first use of the
device:

# cat ~/.asoundrc
pcm.!default {
        type plug
        slave.pcm "name"
}

pcm.name {
        type softvol

        slave {
                pcm "hw:0,0"
        }

        control {
                name "NAME"
        }
}

# amixer controls|grep NAME
numid=41,iface=MIXER,name='NAME'

# amixer cget numid=41
numid=41,iface=MIXER,name='NAME'
  ; type=INTEGER,access=rw---,values=255,min=0,max=0,step=0
amixer: control.c:2313: snd_ctl_elem_value_get_integer: Assertion `idx <
sizeof(obj->value.integer.value) / sizeof(obj->value.integer.value[0])'
failed.
  :
values=255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,Aborted

Attempting to change the volume wipes the control:

# amixer cset numid=41,index=1 30
numid=41,iface=MIXER,name='NAME'
  ; type=INTEGER,access=rw---,values=0,min=0,max=0,step=0
  : values=
alan@singularity:~> amixer cget numid=41
numid=41,iface=MIXER,name='NAME'
  ; type=INTEGER,access=rw---,values=0,min=0,max=0,step=0
  : values=

It also plays sound with a constant jitter, and with mplayer I get a
stream of warnings: "alsa-space: xrun of at least 10.328 msecs.
resetting stream".  I could say more, but theres no point until the
volume control is usable.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
