From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Major Bug in Alsa 0.9  for over 1 year
Date: Fri, 25 Oct 2002 14:58:20 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210251450120.5597-100000@studcom.urz.uni-halle.de>
References: <DAELIEGDPLDDCIJPAICBGEBACEAA.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <DAELIEGDPLDDCIJPAICBGEBACEAA.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: kreuzritter2000@gmx.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> > insmod snd-cs4232
> > Using /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o
> > /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o:
> > unresolved symbol
> > snd_card_new_R506deba1
>
> the "_R506deba1" makes me think snd-cs4232.o is compiled with module
> versionnumbers
> and the module, snd_card_new lives in, haS been made without module version
> numbers.

No, that's caused by using insmod. Using modprobe instead ensures that all
required modules are loaded.

> > modprobe snd-cs4236
> > /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: init_module: No such device

Here, the module initialization code did run, but it didn't find the sound
card. This seems to be some problem with ISA PnP.

Oliver, please try specifying the configuration manually, i.e.
	modprobe snd-cs4236 isapnp=0 port=...
with all the options listed in the INSTALL file.


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
