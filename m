From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: quattro multi plugin.
Date: Fri, 19 Jul 2002 16:11:54 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D37BBBA.7030308@boosthardware.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have had some luck with getting 4 channels to register using the multi 
plugin.

I have the following in .asoundrc.

----
pcm.quattro {
         type multi;

         slaves.a.pcm "hw:2,0";
         slaves.a.channels 3;


         bindings.0.slave a;
         bindings.0.channel 0;
         bindings.1.slave a;
         bindings.1.channel 1;
         bindings.2.slave a;
         bindings.2.channel 2;
	
}

ctl.quattro {
         type hw;
         card 0;
}

pcm.q4 {
         type route;
         slave.pcm "quattro";
         ttable.1.1 1;
         ttable.2.2 1;

}
----

When I run jackd I get this output though:

----
  jackd -v -d alsa -d q4
jackd 0.37.1
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

611 waiting for signals
creating alsa driver ... q4|1024|2|48000|swmon
new client: alsa_pcm, id = 1 type 1 @ 0x8067930 fd = 14
port alsa_pcm:in_1 buf shm key 0x164398c5 at offset 4096 bi = 0x8066d00
registered port alsa_pcm:in_1, offset = 4096
port alsa_pcm:in_2 buf shm key 0x164398c5 at offset 8192 bi = 0x8066d10
registered port alsa_pcm:in_2, offset = 8192
port alsa_pcm:in_3 buf shm key 0x164398c5 at offset 12288 bi = 0x8066d20
registered port alsa_pcm:in_3, offset = 12288
port alsa_pcm:in_4 buf shm key 0x164398c5 at offset 16384 bi = 0x8066d30
registered port alsa_pcm:in_4, offset = 16384
registered port alsa_pcm:out_1, offset = 0
registered port alsa_pcm:out_2, offset = 0
registered port alsa_pcm:out_3, offset = 0
registered port alsa_pcm:out_4, offset = 0
-- jack_rechain_graph():
client alsa_pcm: inprocess client, execution_order=0.
ALSA: poll time out polled for 45558.694314
driver wait function failed, exiting
telling signal thread that the engine is done
jack main caught signal 1
----

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
