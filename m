From: "Robert Rozman" <rozman@fri.uni-lj.si>
Subject: Bug in sis7012 driver - or probably I'm doing something wrong ?
Date: Sat, 24 Apr 2004 10:59:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <024601c429db$ce113f70$6500a8c0@Lapitopi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

I have Asus pundit with sis7012 sound device and alsa 1.0.4 under Suse 9.0.
I've got advice how to use this 6 channel device as 3 stereo channels but
there seems something not to be right (it could be my mistake).


Now I do:

- alsaplayer with mp3 file on device plug:a
- aplay -D plug:ch12 (funny is that plug:a doesn't work)
- everything is ok and mixed properly

- but if I start another alsaplayer on plug:b (probably also plug:c would be
the same), then aplay produces sound that is "interleaved" in short chunks
and also sound from alsaplayer on plug:b is also heard in addition to
original mp3 and aplay sound.

Am I doing something worng or is this somkind of bug or limitation of alsa
driver ?

Thanks in advance,

Robert.


I have /etc/asound.conf :
pcm_slave.sis {
pcm "hw:0"
channels 6
rate 48000
buffer_size 4096 # make these sizes smaller for lower latency
period_size 2048
periods 0
period_time 0
}

pcm.ch12 {
type dmix
ipc_key 47110815
slave sis
bindings.0 0
bindings.1 1
}

pcm.ch34 {
type dmix
ipc_key 47110815
slave sis
bindings.0 2
bindings.1 3
}

pcm.ch56 {
type dmix
ipc_key 47110815
slave sis
bindings.0 4
bindings.1 5
}


pcm.a {
type plug
slave.pcm ch12
}

pcm.b {
type plug
slave.pcm ch34
}

pcm.c {
type plug
slave.pcm ch56
}

pcm.dmixerALL {
type dmix
ipc_key 47110815
slave sis
    bindings.0 0
    bindings.1 1
    bindings.2 2
    bindings.3 3
    bindings.4 4
    bindings.5 5
}

pcm.channelALL {
    type plug
    slave.pcm "dmixerALL"
    ttable.0.0 1
    ttable.1.1 1
    ttable.0.2 1
    ttable.1.3 1
    ttable.0.4 1
    ttable.1.5 1
}
-----------------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
