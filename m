From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: usb audio + mandrake 9.0 foobar :(
Date: Mon, 16 Dec 2002 11:06:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2k7ias2gm.fsf@vador.mandrakesoft.com>
References: <3DFA4539.7050207@iriXx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DFA4539.7050207@iriXx.org> (iriXx's message of "Fri, 13 Dec
 2002 20:38:17 +0000")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m@iriXx.org
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-audio-user@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

iriXx <m@iriXx.org> writes:

> just upgraded mandrake from 8.2 to 9.0....
> and found out that it seems to have made my alsa all foobar.... :(
> 
> i recompiled and reinstalled alsa 0.9.rc5 after upgrading... but i
> dont seem to be able to get it working.
> im running a quattro usb audio unit... modprobe snd-usb-audio,
> snd-pcm-oss, snd-mixer-oss, snd-seq-oss all goes fine... but on
> opening any sound or DVD apps i get error messages that there is no
> sound support / no sound device found....

note that usb audio devices default[1] to usb's audio.o module, as
lspcidrake -v should reports you.

classic bug sound tester (you need the ldetect, chkconfig, aumix and
psmisc packages):

"lspcidrake -v | fgrep AUDIO" will tell you which driver your card use
by default

"grep snd-slot /etc/modules.conf" will tell you what driver it
currently uses

"/sbin/lsmod" will enable you to check if its module (driver) is
loaded or not

"/sbin/chkconfig --list sound" and "/sbin/chkconfig --list alsa" will
tell you if sound and alsa services're configured to be run on
initlevel 3

"aumix -q" will tell you if the sound volume is muted or not

"/sbin/fuser -v /dev/dsp" will tell which program uses the sound card.

 
> anyone got any ideas what may have happened?... is there a problem with
> the supplied kernel perhaps ? it appears to be 2.4.19-16mdk

mdk9.0 came with alsa-0.9.0-rc2.
note than snd-usb-audio code did move a lot between the various alsa
rc.



[1] device-module association[2] being made in
    /usr/share/ldetect-lst/usbtable)

[2] you can alter it through the draksound tool



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
