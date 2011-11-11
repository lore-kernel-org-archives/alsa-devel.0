From: Anders Gnistrup <agn@datarespons.dk>
Subject: Problem with bluetooth headset and "aplay -l"
Date: Fri, 11 Nov 2011 15:01:40 +0100
Message-ID: <C516192DA6D2B74F8192CDC209D958FD5833F9EE5B@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.datarespons.com (mailgw01.datarespons.com
	[81.0.189.39]) by alsa0.perex.cz (Postfix) with ESMTP id F1652103B74
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 15:01:44 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

I have a wired problem. I can pair, and connect a bluetooth headset using bluez-simple-agent and bluez-test-audio, no problem.
I kan also record and play using aplay/arecord -D bluetooth.

But i can list the device in "aplay -l" og "aplay -L".
My gees is that I am missing a ctl interface or a kernel module. (or that ubuntu has done something nasty)

My system is a ubuntu 11.04, where the bluetooth pulseaudion plugin have been removed. I am developing for a embedded arm platform also running ubunut 11.04 and the problem is the same on target.
The list of modules is listed in the bottom og this email.

Regards Anders Gnistrup


Module                  Size  Used by
aesni_intel            55161  1 
cryptd                 20510  1 aesni_intel
aes_x86_64             17208  1 aesni_intel
aes_generic            38279  2 aesni_intel,aes_x86_64
parport_pc             36959  0 
ppdev                  17113  0 
snd_hda_codec_hdmi     28167  1 
snd_hda_codec_idt      71137  1 
binfmt_misc            17565  1 
pata_pcmcia            17074  1 
snd_hda_intel          33176  2 
snd_hda_codec         103804  3 snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_intel
snd_hwdep              13604  1 snd_hda_codec
rfcomm                 47694  19 
snd_pcm                96391  3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
snd_seq_midi           13324  0 
sco                    18187  2 
arc4                   12529  2 
snd_rawmidi            30486  1 snd_seq_midi
bnep                   18308  2 
snd_seq_midi_event     14899  1 snd_seq_midi
l2cap                  53610  28 rfcomm,bnep
snd_seq                61621  2 snd_seq_midi,snd_seq_midi_event
tpm_infineon           17572  0 
iwlagn                333716  0 
i915                  515078  8 
snd_timer              29602  2 snd_pcm,snd_seq
drm_kms_helper         42394  1 i915
iwlcore               167502  1 iwlagn
hp_wmi                 13706  0 
pcmcia                 49166  1 pata_pcmcia
joydev                 17606  0 
sparse_keymap          13898  1 hp_wmi
snd_seq_device         14462  3 snd_seq_midi,snd_rawmidi,snd_seq
mac80211              294370  2 iwlagn,iwlcore
drm                   227534  4 i915,drm_kms_helper
yenta_socket           27846  0 
psmouse                73535  0 
pcmcia_rsrc            18372  1 yenta_socket
cfg80211              178528  3 iwlagn,iwlcore,mac80211
snd                    67382  14 snd_hda_codec_hdmi,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
tpm_tis                18537  0 
btusb                  18600  6 
bluetooth              72320  11 rfcomm,sco,bnep,l2cap,btusb
soundcore              12680  1 snd
snd_page_alloc         18529  2 snd_hda_intel,snd_pcm
hp_accel               21880  0 
serio_raw              13166  0 
tpm                    22267  2 tpm_infineon,tpm_tis
lis3lv02d              19893  1 hp_accel
tpm_bios               13684  1 tpm
lp                     17825  0 
input_polldev          14007  1 lis3lv02d
parport                46458  3 parport_pc,ppdev,lp
pcmcia_core            22569  3 pcmcia,yenta_socket,pcmcia_rsrc
intel_ips              18097  0 
i2c_algo_bit           13400  1 i915
video                  19438  1 i915
hid_microsoft          12865  0 
usb_storage            53538  0 
uas                    17996  0 
hid_logitech           17693  0 
ff_memless             13097  1 hid_logitech
usbhid                 46956  1 hid_logitech
hid                    91020  3 hid_microsoft,hid_logitech,usbhid
firewire_ohci          40370  0 
sdhci_pci              13989  0 
firewire_core          62646  1 firewire_ohci
sdhci                  27387  1 sdhci_pci
crc_itu_t              12707  1 firewire_core
ahci                   25951  2 
libahci                26642  1 ahci
e1000e                159096  0 
