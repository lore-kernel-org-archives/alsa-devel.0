From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: HDSP -- linux CardBus issue: PCMCIA driver works!
Date: Fri, 21 Jun 2002 21:03:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020621190320.GA1029@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi all,

I just wanted to tell you that the PCMCIA card bus interface works
with the hdsp driver and a multiface (I only tested it with aplay and
2 channels so far, but think it should be possible to get the other
channels to play as well). I first had seemingly similar problems to
the ones posted on this list with my SuSE 7.3 distribution, but
changed to Debian this week. 

I use the unstable distribution and first had some problems getting
PCMCIA to work. I finally succeeded in the combination of the
kernel-pcmcia-modules-2.4.18-686 and the pcmcia-cs package (It didn't
work with the package pcmcia-modules-2.4.18-686 which gets installed
automatically if you install pcmcia-cs directly, so both packages had
to be purge-removed and then reinstalled with
kernel-pcmcia-modules... first and then the pcmcia-cs package).

I had to remove all references to my built-in soundcard from
/etc/modules.conf (and from /etc/modules as I made an entry there as
well) and just did a modprobe snd-hdsp right after system bootup with
all interfaces connected and powered. The red led flashes and turns
off and alsamixer shows the 18 outchannels of the Multiface (I don't
know how to access the input channels yet).

Anyway, now I'm off trying to get pd to play with it multichannel :-)

>From my side a big thank you to the invaluable work of Paul!

--
Orm


P.S.: My Laptop is an Acer 528TXV with PIII Mobile 850MHz if that's
important for debugging purposes. Just contact me off list for any
information/log files...


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
