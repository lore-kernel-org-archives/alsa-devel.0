From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: sblive 4ch output w/ jack - asoundrc magic?
Date: Thu, 05 Feb 2004 00:08:18 +0100
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <40217B62.5020604@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

[crossposted to alsa-devel and jackit-devel]

hi *!

i'd like to use the rear outs of my sblive platinum with jack.

the following works:
# aplay some.wav -Dfront &
# aplay someother.wav -Drear
both signals end up at my mixer as expected, so it seems the devices=20
are independent.

front is hw:0,0 which is a duplex device.
rear is hw:0,3 and is playback only.

first and all-important question: are the front and rear out pcm=20
devices synced in hardware? i suppose so, otherwise they would be=20
pretty much useless. (if it turns out they aren't, let me know and=20
ignore the rest of this posting :( )


to use all four outs with jack, i dug out some old asoundrc hack=20
that takashi and jaroslav showed me a while ago:

// combine two devices into one
pcm.multi {
         type multi;
         slaves.a.pcm "hw:0,0";
         slaves.a.channels 2;
         slaves.b.pcm "hw:0,3";
         slaves.b.channels 2;
         bindings.0.slave a;
         bindings.0.channel 0;
         bindings.1.slave a;
         bindings.1.channel 1;
         bindings.2.slave b;
         bindings.2.channel 0;
         bindings.3.slave b;
         bindings.3.channel 1;
}

ctl.multi {
         type hw;
         card 0;
}

// somehow this device is not continous in memory and thus not=20
mmap()able. jack wants mmap access, and this routing trick should help:

pcm.ttable {
         type route;
         slave.pcm "multi";
         ttable.0.0 1;
         ttable.1.1 1;
         ttable.2.2 1;
         ttable.3.3 1;
}

ctl.ttable {
         type hw;
         card 0;
}


ok. now i can do
# jackstart -d alsa -d ttable -P
and i get 4 outs.


3 problems remain:


* no sound from the rear outs when used with jack in this way :(

* qjackctl goes all haywire with this device: xruns galore. all is=20
well when i don't use qjackctl and start jackd from the command=20
line, so it might be a qjackctl problem, but i thought i'd mention=20
it anyway - maybe the ttable device is not really kosher...

* no input from the first two channels.


jack somehow assumes that either all or no channels are duplex. if i=20
don't use the -P (or non-duplex playback only) flag, it says, "...

nettings@kleineronkel:~> jackstart -d alsa -d ttable
back from read, ret =3D 1 errno =3D=3D Invalid argument
jackd 0.94.3
[...]
creating alsa driver ...=20
ttable|ttable|1024|2|48000|0|0|nomon|swmeter|rt|32bit
ALSA lib pcm_hw.c:1055:(snd_pcm_hw_open) open /dev/snd/pcmC0D3c=20
failed: No such device
jackstart: pcm.c:689: snd_pcm_nonblock: Assertion `pcm' failed.
Aborted

=2E..",  apparently trying to find a capture device for channels 2 and 3.=


is there a way to fool jack into believing all are duplex with some=20
more asoundrc magic? ideally, those two bogus ins would produce=20
silence, but i don't really care, i don't connect them anyway.


thanks in advance,

j=F6rn


--=20
"I never use EQ, never, never, never. I previously used to use mic
positioning but I've even given up on that too."
	- Jezar on http://www.audiomelody.com


J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxaudiodev.org (Linux Audio Developers)





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
