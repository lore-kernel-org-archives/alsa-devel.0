From: Sundance <sundance@ierne.eu.org>
Subject: Re: [Alsa-user] RE: Support for VIA 8233A chipset on a KT333 (MSI KT3 Ultra) motherboard?
Date: Wed, 5 Jun 2002 23:00:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020605210004.A5C85ABC@byblos.ierne.eu.org>
References: <20020504233456.CFD19A9E@byblos.ierne.eu.org> <20020602121201.32f4edc8.David.Sagnol@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kraid.nerim.net (kraid.nerim.net [62.4.16.95])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA00655
	for <alsa-devel@alsa-project.org>; Wed, 5 Jun 2002 22:59:34 +0200
In-Reply-To: <20020602121201.32f4edc8.David.Sagnol@wanadoo.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: David Sagnol <David.Sagnol@wanadoo.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I was told David Sagnol said:

> Finaly, using the Last CVS code (1st June), I was able to make it work !

Hello,

I'm sorry to report that it still doesn't quite work for me.

If I modprobe snd-via8233 right away and try to play something (be it through 
ALSA or OSS emulation), I get no sound and the message: write error: 
Input/output error.

If I load the OSS/Commercial modules then unload them, and then modprobe 
snd-via8233, sound playback /almost/ works. There's sound in the speakers, 
but it's played WAY too fast. A 2 channels 44100Hz ogg file is played 
something like twice as fast as it should. A 8 bit mono 22050Hz WAV is played 
so fast it's almost inaudible.

An interesting point is that if I mix stereo channels into one with the 
--singlemix option of mpg123, the sample is played /even/ faster, by a 2x 
factor (I've verified with the OSS driver that it's not a mpg123 bug). So I 
figure that the problem might be with the way the driver handles channels.

For the records, this was tried on:
ALSA version: today's CVS
Southbridge: Via 8233A
Sound chip: ALC 650

Hope this will help Takashi or someone else get it to work. If there's any 
other way I can help, please let me know. :)

-- S.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
