From: Sundance <sundance@ierne.eu.org>
Subject: Re: problem with 8233 -- please help!
Date: Mon, 6 May 2002 01:59:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020505235958.B72C9A9F@byblos.ierne.eu.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
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

You wrote:

> It seems, that the ALC640 is not compatible to the intel810.

The ALC650 (which is what you meant, right?) is indeed not recognized by 
ALSA's AC97 code, if I understood that part of the sources of 0.9.0rc1 
correctly. That can be relatively easily fixed by adding:
{ 0x414C4720, 0xfffffff0, "ALC650",            NULL },
to snd_ac97_codec_ids[] in ac97_codec.c
With that little change the ALC650 is apparently detected alright.

Only, it doesn't work any better. =)

If I try to use the via8233 module, I get the same result as you when playing 
(no sound, I/O error). But even with the ALC650 added to ac97_codec.c, 
modprobing snd-intel8x0 doesn't work:
root@byblos:~# modprobe snd-intel8x0
/lib/modules/2.4.18/kernel/sound/pci/snd-intel8x0.o: init_module: No such 
device
And the syslog reports that the ICH device wasn't found or is busy.
So I guess it's not just a problem of AC97 not recognizing the ALC650. Argh.

I'l keep you informed, should I somehow manage to get it to work (unlikely, 
but eh). :)

-- S.

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
