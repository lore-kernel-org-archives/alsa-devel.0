From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: quattro multi plugin - 4 channel recording
Date: Sun, 28 Jul 2002 17:14:27 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D43A7E3.9070402@boosthardware.com>
References: <Pine.LNX.4.33.0207211019300.755-100000@pnote.perex-int.cz> <3D3BD760.7060606@boosthardware.com> <3D3BEAB5.9090508@boosthardware.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, linux-audio-user@music.columbia.edu, Thorsten Haas <thorsten.haas@gmx.de>
List-Id: alsa-devel@alsa-project.org

I have now got 4 channel recording using arecord.

It seemed the alias for the ctl was throwing the equation.

Use the following in your .asoundrc file.


#---- 


#
# compose 4 channels from two channel x two devices, hw:2,1 and hw:2,2
# assuming that hw:2,1 and hw:2,2 give the same condition, 24_3LE/96k
#

pcm.quattro {
         type multi;

         slaves.a.pcm "hw:2,1";
         slaves.a.channels 2;
         slaves.b.pcm "hw:2,2";
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

ctl.quattro {
         type hw;
         card 2;
}


#
# remap 4 channels as interleaved.
# use plug instead of route here, since 24_3LE is unlikely supported by
# applications.
#
# arecord -r 44100 -c 4 -f s16_le -D q4 -d 5 /home/xxx/q4.wav

pcm.q4 {
         type plug;
         slave.pcm "quattro";
         ttable.0.0 1;
         ttable.1.1 1;
         ttable.2.2 1;
         ttable.3.3 1;
}



ctl.q4 {
         type hw;
         card 2;
}

#
# Use route plugin for applications that do support 24_3LE
# This lowers latency which the plug plugin introduces due to
# resampling.
#
# arecord -r 44100 -c 4 -f s16_le -D q41 -d 5 /home/xxx/q41.wav



pcm.q41 {
         type route;
         slave.pcm "quattro";
         ttable.0.0 1;
         ttable.1.1 1;
         ttable.2.2 1;
         ttable.3.3 1;

}

ctl.q41 {
         type hw;
         card 2;
}

#----





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
