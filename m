From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: copy plugin, connecting output-input (virtual soundcard
 with connected out->in)
Date: Tue, 13 Aug 2002 22:53:06 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D590F42.8030902@boosthardware.com>
References: <13809.1029241000@www8.gmx.net>
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
To: Friedrich.Ewaldt@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Friedrich.Ewaldt@gmx.de wrote:
> Hi Patrick,
> 
> 
>>There is a plugin called copy in the pcm plugins docs. Have a read.
>>
>>http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins
> 
> 
> I did a lot of tests and experiments with the copy plugin (everything that
> came into my mind) but had no success in getting sound from an ALSA output
> device to an input device. Besides, I have some problems using the copy plugin
> with some applications (e.g. brutefir). I get a "file descriptor in bad state"
> error when brutefir calls snd_pcm_start. (you'll find further description od
> this problem at
> http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg04080.html
> )
> Do you know what I should do to get this running?
> 

Your right that it is not easy.

I was under the impression that something like:

----
      	pcm.first {
              	type hw
                 card 0
		device 0
      	}

       	ctl.first {
              	type hw
              	card 0
      	}

      	pcm.second {
              	type hw
                 card 1
		device 0
      	}

       	ctl.second {
              	type hw
              	card 1
      	}

	pcm_slave.sl {
      		pcm second
      		rate 44100
	}

	pcm.c1 {
         	type copy
         	slave sl
	}
			
	ctl.c1 {
		type hw
         	card 0		
	}
----

Would allow you to do what you want. The plugins docs says it will copy 
from master pcm to the slave pcm. I assume that the master is the first 
device hw:0,0.

Did you try anything like the above?

I would but I'm testing alsaplayer and it is having problems with 
releasing the ALSA pcm device currently so I have to shut down first.
		
HTH.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
