From: Fabrizio Lombardozzi <fabrizio.lombardozzi@cooperativacapodarco.it>
Subject: usb headset with mic Jabra GN2400 (0b0e:2400)
	regression bug on linux 4.4.0-21-generic
Date: Wed, 01 Mar 2017 19:07:45 +0100
Message-ID: <3447575.fJn87WCcAO@fabpc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 43367266834
 for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2017 19:08:44 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id m70so8681159wma.1
 for <alsa-devel@alsa-project.org>; Wed, 01 Mar 2017 10:08:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, francesco.primerano@cooperativacapodarco.it
List-Id: alsa-devel@alsa-project.org

Hi,
I've found that the headset gn2400 is not working properly any more on latest kernels, while it was working fine up to 3.8.0-19 (Ubuntu 13.04).
The headset is steadily playing squeaky sound (probably a kind of rate mismatch) with any application that try to set a playback sample rate below 32Khz, e.g.:
mplayer -srate 8000 song.mp3 
Instead it can records properly at any rate:
arecord -f S16_LE -r 8000 -D hw:1,0 -d 5 t.wav (but then you can't hear it)
 
After "a few" modules recompilations I found an acceptable solution:

--- ../../../linux-4.4_originale/linux-4.4/sound/usb/quirks.c	2017-02-24 17:22:57.021006325 +0100
+++ quirks.c	2017-03-01 18:36:51.877837419 +0100
@@ -1113,6 +1113,18 @@
 		set_format_emu_quirk(subs, fmt);
 		break;
 	}
+
+	if  (subs->stream->chip->usb_id == USB_ID(0x0b0e, 0x2400))  /* Jabra BIZ-2400 */
+	{
+		if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		{
+			int flr,rate=48000;
+			printk(KERN_ALERT "snd_usb_set_format_quirk() Jabra BIZ-2400 PLAYBACK forced rate:%d\n",rate);
+			for (flr=0;flr<fmt->nr_rates;flr++) fmt->rate_table[fmt->nr_rates] = rate;
+			fmt->rate_min=rate;
+			fmt->rate_max=rate;
+		}
+	}
 }
 
 bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)



I hope it can be useful for others.

Here are some other info


root@fab-desktop:~/linux-4.4/sound/usb# lsusb -vvv  -d 0b0e:2400

Bus 005 Device 059: ID 0b0e:2400 GN Netcom 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0b0e GN Netcom
  idProduct          0x2400 
  bcdDevice            1.41
  iManufacturer           0 
  iProduct                2 Jabra BIZ 2400 Mono USB
  iSerial                 3 1C48F9103BE5x014100
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          256
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          103
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID              10
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 5
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 7
        bNrInPins               1
        baSource( 0)            5
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               7
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 8
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 9
        bNrInPins               1
        baSource( 0)            8
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                10
        bNrInPins               2
        baSourceID( 0)          1
        baSourceID( 1)          9
        bNrChannels             1
        wChannelConfig     0x0000
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        16000
        tSamFreq[ 2]        48000
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x81
            Sampling Frequency
            MaxPacketsOnly
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              0 Decoded PCM samples
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0060  1x 96 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           6
        bDelay                  0 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        16000
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay              0 Decoded PCM samples
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     339
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered








-- 


 Saluti
Fabrizio

Ing.Fabrizio Lombardozzi
Coord. Servizi Ippofono Capodarco
Via Ostiense, 131L asc.B 00154 ROMA
Tel. +39 0657 060 230 
Cell. +39 335 585 3047 
Email: fabrizio.lombardozzi@sociale.it
Ai sensi e per effetti della legge sulla tutela della riservatezza personale (D.lgs n.196/2003), questa @mail e' destinata unicamente alle persone sopra indicate e le informazioni in essa contenute sono da considerarsi strettamente riservate. E' proibito leggere, copiare, usare o diffondere il contenuto della presente @mail senza autorizzazione. Se avete ricevuto questo messaggio per errore, siete pregati di rispedire la stessa al mittente. Grazie

-- 
"Ai sensi e per gli effetti della legge sulla tutela dei dati personali 
(D.lgs 196/2003),
le informazioni contenute nella presente @mail sono di natura riservata e 
destinate
ad un uso aziendale-lavorativo con esclusione di utilizzi ad uso personale; 
come tali,
pertanto, sono riservate esclusivamente ai destinatari sopra indicati. E' 
proibito leggere,
copiare, usare o diffondere il contenuto della presente @mail senza 
autorizzazione.
Se avete ricevuto questa @mail per errore, siete pregati di rispedire la 
stessa al mittente.
Grazie"
