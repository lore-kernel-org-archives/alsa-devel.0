From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Linux driver for cs4281 with TWO cs4299 codecs?
Date: Mon, 27 May 2002 18:37:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205271816120.8370-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.21.0205231057240.439-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0205231057240.439-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: twoller@crystal.cirrus.com, pcaudio@crystal.cirrus.com, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>, arip@bfad.de
List-Id: alsa-devel@alsa-project.org

Now I have got all alsa9 utilites on the system and the driver does something.

I can see for example PCM (2 channels) and PCM 1 (2 channels) in alsamixer.

I can also record like: arecord -c 4 -t raw -f S16_LE aaa.raw
and I get:
od -i aaa.raw | more
0000000    -10     -6      0      0      1      3      0      0
0000020     -8     -8      0      0     -7     -7      0      0
0000040     -7     -6      0      0     -6     -2      0      0
0000060    -10     -9      0      0     -9     -8      0      0

But here is a problem - I would expect to see some noise in both codecs - I
have configured and unmuted them BOTH to max volume.

In fact I have tried also -c 3 and -c 5  and always only the first 2 channels
are non-zero.

arecord -l    
card 0: card0 [Cirrus Logic CS4281], device 0: CS4281 [CS4281]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

How can I record data from the secondary codec?


BTW. I have done:

--- cs4281.c-takashi-2	Sat May 25 23:02:01 2002
+++ cs4281.c	Sat May 25 23:04:35 2002
@@ -61,7 +61,7 @@
 MODULE_PARM_DESC(snd_enable, "Enable CS4281 soundcard.");
 MODULE_PARM_SYNTAX(snd_enable, SNDRV_ENABLE_DESC);
 MODULE_PARM(snd_dual_codec, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(snd_dual_codec, "Enable Dual Codec.");
+MODULE_PARM_DESC(snd_dual_codec, "Enable Dual Codec. (put ID(1-3) here)");
 MODULE_PARM_SYNTAX(snd_dual_codec, SNDRV_BOOLEAN_FALSE_DESC);
 
 /*
@@ -1449,7 +1449,7 @@
 	/*
 	 *  Set the serial port timing configuration.
 	 */
-	snd_cs4281_pokeBA0(chip, BA0_SERMC, BA0_SERMC_TCID(1) | BA0_SERMC_PTC_AC97 | BA0_SERMC_MSPE);
+	snd_cs4281_pokeBA0(chip, BA0_SERMC, BA0_SERMC_TCID(chip->dual_codec) | BA0_SERMC_PTC_AC97 | BA0_SERMC_MSPE);
 
 	/*
 	 *  Start the DLL Clock logic.


I believe this is a nice way to give the actual codec ID (0 is always the
primary codec).

Best regards,
--
Tomasz Motylewski
BFAD GmbH & Co. KG


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
