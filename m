From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [PATCH] possible fix for misbehaving hdsp
Date: Mon, 26 Jan 2004 19:43:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040126194303.12d60d84.TimBlechmann@gmx.net>
References: <40151C22.6020005@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40151C22.6020005@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

> Could people experiencing problems with their hdsp (namely Tim and
> Paul) try the attached patch ?
i tried the patch you sent me ... no success ... i tried to play a
soundfile with aplay using different period-sizes ...
the file always had the same distortions ...
btw, the patch just changed the default pci latency ... i did that a few
weeks ago manually, using every setup i could think of ... it doesn't
seem to be related to this...

i'm still confused of the third line (dmesg):

cs: cb_alloc(bus 7): vendor 0x10ee, device 0x3fc5
PCI: Enabling device 07:00.0 (0080 -> 0082)
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:663: Hammerfall-DSP: no
Digiface or Multiface connected! 
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:5052: card initialization
pending : waiting for firmware

alsa doesn't seem to realize that the multiface is connected ... is this
ok?


and:
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:807: wait for FIFO status <= 0
failed after 30 iterations
ALSA../../alsa-kernel/pci/rme9652/hdsp.c:4711: initializing firmware
upload ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:678: loading firmware
ALSA../../alsa-kernel/pci/rme9652/hdsp.c:716: finished firmware loading

when running hdsploader i usually get the first message ...

btw, paul, is the patch working on your setup?

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-- 
 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
