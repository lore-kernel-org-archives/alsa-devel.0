From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Sat, 17 Sep 2005 11:52:15 +0800
Message-ID: <432B92EF.2020507@netvigator.com>
References: <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr>	 <20050913085552.GA2655@titan.lahn.de>	 <20050913173529.GD31269@sashak.softier1.local>	 <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com>	 <20050914205608.GD14657@sashak.softier1.local>	 <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de>	 <20050915143533.GB23218@sashak.softier1.local>	 <20050915204345.GC27700@sashak.softier1.local>	 <432AD226.6010706@netvigator.com> <1126906481.12111.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1126906481.12111.7.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@gmail.com>
Cc: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, Sasha Khapyorsky <sashak@smlink.com>
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:
> Hi,
> 
> 
>>The easy way is to create a PCM device "modem" on au8810
>>
>>
>>DMA -> FIFO -> SRC -> MIXIN --------> MIXOUT -> MC97(Modem Out)
>>                         |
>>		        +-----------> MIXOUT -> EQ -> AC97(Audio Left)
>>
>>    				Modem Speaker  On or Off
>>
>>                                   +-> MIXOUT -> EQ -> AC97(Audio Right)
>>                                   |
>>DMA <- FIFO <- SRC <- MIXOUT <- MIXIN <-------- MC97(Modem IN)
>>
>>
>>or
>>
>>
>>DMA -> FIFO -> SRC -> MC97(modem) (Playback)
>>
>>DMA <- FIFO <- SRC <- MC97(modem) (Capture)
>>
> 
> 
> Remove the samplerate converter, it does not make any sense on a modem.

AC-link requried 48kHz , is it controlled by the modem application ?

Do we need to implement snd_vortex_modem_hw_params() ?

> You will only loose signal precision with the samplerate converter
> anyway, and there are very few of them. 

When comparing au8810 and au8830, vortex_fifo_init() fail at 17th FIFO.

au8810 seem to has only 16 FIFO and 16 SRC.

http://lists.nongnu.org/archive/html/openvortex-dev/2004-03/msg00039.html


> A direct route from the fifo to the modem codec will do it and the modem
> signal device will run at the codec native samplerate without any
> precision loss.
> 

What is the format of the PCM ? (16bits signed/unsigned)

DMA -> FIFO -> MC97(modem) (Playback)

DMA <- FIFO <- MC97(modem) (Capture)

> 
>>What is the difference between modem application and audio application ?
> 
> 
> Nothing. The only modem extra functionality is the ability to switch the
> modem line off/on hook. It just sends and captures QAM modulated
> signals.
> 

What feature do SI3036 support ? (Data/Fax/speaker phone/Voice Modem)

May be we can add a simple dialer in vortex control panel to make a 
voice call ?

http://alsa.opensrc.org/au88x0

> 
>>Do the modem application open two PCM streams (one for playback and the 
>>other for capture )?
> 
> 
> Yes, it should be full duplex. This will require 2 DMA's.
> 

Do we need different playback_ops for the wavetable ?


diff -Naur modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_pcm.c 
modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c
--- modem/alsa-driver/alsa-kernel/pci/au88x0_orig/au88x0_pcm.c 
2005-09-15 19:34:02.000000000 +0800
+++ modem/alsa-driver/alsa-kernel/pci/au88x0/au88x0_pcm.c	2005-09-16 
23:19:55.000000000 +0800
@@ -525,11 +580,19 @@
  	VORTEX_PCM_TYPE(pcm) = idx;
  	pcm->private_data = chip;
  	/* set operators */
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-			&snd_vortex_playback_ops);
-	if (idx == VORTEX_PCM_ADB)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
-				&snd_vortex_playback_ops);
+	switch (idx) {
+#ifdef CHIP_AU8810
+	case VORTEX_PCM_MODEM:
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, 
&snd_vortex_modem_playback_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, 
&snd_vortex_modem_capture_ops);
+		break;
+#endif
+	case VORTEX_PCM_ADB:
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_vortex_playback_ops);
+	default:
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, 
&snd_vortex_playback_ops);
+		break;
+	};
  	
  	/* pre-allocation of Scatter-Gather buffers */
  	


> 
>>Where is the class SND_PCM_CLASS_MODEM specificed in the driver ?
> 
> 
> At least i did not.
> 

How do the modem application know which device of the sound card is a 
modem ?





-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
