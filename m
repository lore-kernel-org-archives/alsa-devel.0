From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Missing module dependencies in ALSA CVS
Date: Wed, 17 Mar 2004 22:25:56 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040317222556.48800.qmail@web40613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

ALSA CVS is still failing to generate all of dependent
modules in my particular config:

--with-kernel=/home/chris/linux-2.6.4
--with-moddir=/lib/modules/2.6.4/kernel/sound
--with-oss=yes
--with-sequencer=yes
--with-cards=intel8x0,emu10k1,dummy

I have managed to "hack" the (generated) acinclude.m4
file to fix it:

...
if test "$cards" = "all"; then
  ALSA_TOPLEVEL_ALL
  AC_MSG_RESULT(all)
else
>   CONFIG_SOUND="y"
>   CONFIG_SND="m"
>   CONFIG_SND_TIMER="m"
>   AC_DEFINE(CONFIG_SND_MODULE)
>   AC_DEFINE(CONFIG_SND_TIMER_MODULE)
  cards=`echo $cards | sed 's/,/ /g'`
  for card in $cards
  do
...

...
  emu10k1)
    CONFIG_SND_HWDEP="m"
    AC_DEFINE(CONFIG_SND_HWDEP_MODULE)
    CONFIG_SND_RAWMIDI="m"
    AC_DEFINE(CONFIG_SND_RAWMIDI_MODULE)
    CONFIG_SND_AC97_CODEC="m"
    AC_DEFINE(CONFIG_SND_AC97_CODEC_MODULE)
    CONFIG_SND_EMU10K1="m"
    AC_DEFINE(CONFIG_SND_EMU10K1_MODULE)
>     if ( test "$CONFIG_SND_SEQUENCER" == "y" -o
"$CONFIG_SND_SEQUENCER" == "m" ); then
>       CONFIG_SND_VIRMIDI="m"
>       AC_DEFINE(CONFIG_SND_VIRMIDI_MODULE)
>     fi
    ;;
...

Cheers,
Chris



	
	
		
___________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
