From: Fergus Reid <fergusr@solid-state-logic.com>
Subject: asound.conf for multiple cards one device
Date: Thu, 07 Nov 2002 18:11:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCAACD6.8090206@solid-state-logic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi, I'm trying to configure asound.conf to support "two cards as one" 
(but with 3, 8 channel cards!) as suggested in the .asoundrc doc. When I 
try to aplay the new device however I get:

"ALSA lib pcm_multi.c:928:(_snd_pcm_multi_open) Invalid or missing 
schannel for channel 0
aplay: main:462: audio open error: Invalid argument"

I'm using three terratec ews88mt cards and my asound.conf looks like this:



pcm_slave.ssl8_s {
    pcm ssl8_0
}
pcm.ssl8_0 {
    type hw
    card 0
}
ctl.ssl8_0 {
    type hw
    card 0
}
pcm.ssl8_1 {
    type hw
    card 1
}
ctl.ssl8_1 {
    type hw
    card 1
}
pcm.ssl8_2 {
    type hw
    card 2
}
ctl.ssl8_2 {
    type hw
    card 2
}
ctl.ssl_24 {
    type hw
    card 0
}

pcm.ssl_24 {
    type multi;
    slaves.a.pcm ssl8_0;
    slaves.a.channels 8;
    slaves.b.pcm ssl8_1;
    slaves.b.channels 8;
    bindings.0.slave a;
    bindings.0.channel 0;
    bindings.1.slave a;
    bindings.1.channel 1;
    bindings.2.slave a;
    bindings.2.channel 2;
    bindings.3.slave a;
    bindings.3.channel 3;
    bindings.4.slave a;
    bindings.4.channel 4;
    bindings.5.slave a;
    bindings.5.channel 5;
    bindings.6.slave a;
    bindings.6.channel 6;
    bindings.7.slave a;
    bindings.7.channel 7;

    bindings.0.slave b;
    bindings.0.channel 8;
    bindings.1.slave b;
    bindings.1.channel 9;
    bindings.2.slave b;
    bindings.2.channel 10;
    bindings.3.slave b;
    bindings.3.channel 11;
    bindings.4.slave b;
    bindings.4.channel 12;
    bindings.5.slave b;
    bindings.5.channel 13;
    bindings.6.slave b;
    bindings.6.channel 14;
    bindings.7.slave b;
    bindings.7.channel 15;

    bindings.0.slave c;
    bindings.0.channel 16;
    bindings.1.slave c;
    bindings.1.channel 17;
    bindings.2.slave c;
    bindings.2.channel 18;
    bindings.3.slave c;
    bindings.3.channel 19;
    bindings.4.slave c;
    bindings.4.channel 20;
    bindings.5.slave c;
    bindings.5.channel 21;
    bindings.6.slave c;
    bindings.6.channel 22;
    bindings.7.slave c;
    bindings.7.channel 23;
}

pcm.ttable {
    type route;
    slave.pcm "ssl_24";
    ttable.0.0 1;
    ttable.1.1 1;
    ttable.2.2 1;
    ttable.3.3 1;
    ttable.4.4 1;
    ttable.5.5 1;
    ttable.6.6 1;
    ttable.7.7 1;
    ttable.8.8 1;
    ttable.9.9 1;
    ttable.10.10 1;
    ttable.11.11 1;
    ttable.12.12 1;
    ttable.13.13 1;
    ttable.14.14 1;
    ttable.15.15 1;
    ttable.16.16 1;
    ttable.17.17 1;
    ttable.18.18 1;
    ttable.19.19 1;
    ttable.20.20 1;
    ttable.21.21 1;
    ttable.22.22 1;
    ttable.23.23 1;
}
# see above.
ctl.ttable {
        type hw;
        card 0;
}

Incidentally I can't see what the first pcm_slave entry is for. Can I 
get this to work somehow?
Thanks
Fergus




**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
