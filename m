From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: Major Bug in Alsa 0.9  for over 1 year
Date: Sat, 26 Oct 2002 12:37:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021026103737.70314.qmail@web12201.mail.yahoo.com>
References: <Pine.HPX.4.33n.0210251450120.5597-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0210251450120.5597-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: kreuzritter2000@gmx.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Clemens Ladisch <clemens@ladisch.de> schrieb: >
Karsten Wiese wrote:
> > > insmod snd-cs4232
> > > Using
> /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o
> > >
> /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o:
> > > unresolved symbol
> > > snd_card_new_R506deba1
> >
> > the "_R506deba1" makes me think snd-cs4232.o is
> compiled with module
> > versionnumbers
> > and the module, snd_card_new lives in, haS been made
> without module version
> > numbers.
> 
> No, that's caused by using insmod. Using modprobe instead
> ensures that all
> required modules are loaded.
right, but none the less the "_R506deba1" in
"snd_card_new_R506deba1" means the requesting module needs
"version information on module symbols". if the use of
"version information on module symbols" is not consistent
across kernel & modules, this message can occure.

karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
