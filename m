From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: quattro multi plugin.
Date: Mon, 22 Jul 2002 18:58:56 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3BD760.7060606@boosthardware.com>
References: <Pine.LNX.4.33.0207211019300.755-100000@pnote.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> Please, try again. I've just added missing support for 24-bit samples to
> one alsa-lib's function.
> 

Things seem to be getting worse with jack at least. I cannot use the 
96000hz setting because that requires jack to have 24 bit support which 
it doesn't yet. 32 or 16bit are supported.

So If I use the .asoundrc that takashi sent I get an instant hang with 
only two channels being found and if I use my one I get the same but 
with four channels being found.

By instant hang I mean:

----
  jackd -v -d alsa -d q4b
jackd 0.37.1
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

611 waiting for signals
creating alsa driver ... q4b|1024|2|48000|swmon
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
----

Then my system locks hard.

I will do some testing with ecasound and the native alsa drivers.


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
