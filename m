From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch
Date: Sun, 15 Jun 2003 22:42:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19RjsK-00057y-00@sc8-sf-list1.sourceforge.net>
References: <1055707956.1551.55.camel@Wizard.knechthome.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "15 Jun 2003 13:12:36 PDT."
             <1055707956.1551.55.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>RME HDSP 9652 (Card #1)
>Buffers: capture df000000 playback dee00000
>IRQ: 17 Registers bus: 0xe8800000 VM: 0xe08e6000
>Control register: 0x10080b3

You don't have the correct version of the driver. It would print:

RME Hammerfall HDSP 9652 (Card #1)
Buffers: capture f7000000 playback f6e00000
IRQ: 11 Registers bus: 0xfebb0000 VM: 0xf88af000
Control register: 0x10080f9
Control2 register: 0x800

notice the extra "Control2" register printout. check the source code
in alsa-kernel/pci/rme9652/hdsp.c contains the
snd_hdsp_9652_enable_mixer, and verify that the modifications dates on
your installed modules match those of the built object files. or
something like that. its definitely a version skew thing.

--p


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
