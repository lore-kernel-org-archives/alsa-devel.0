From: Dennis van der Meer <dvdmeer@wanadoo.nl>
Subject: Terratec Aureon Space 7.1 and digital out
Date: Thu, 28 Aug 2003 23:44:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030828232924.021e2830@192.168.10.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everyone,

For quite a long time now I have been trying to get my digital out on my
Terratec Aureon Space 7.1 to work. The analog out is working but since
I only use the digital out it isn't sufficient for me.

Because I was hoping to get an answer as to how to enable the digital
out I posted several emails to the alsa-user mailinglist.
Although the answers I got helped me to better understand how Alsa
works I still haven't received the answer I was hoping for: what should
I do/enable to get sound through the digital out?
Since the information I might need is a little more technical than just a
"run this tool" or "copy this file" I figured that I might get a better answer
when I post my question on this mailinglist.

I tried playing with the mixer to increase the volume and fiddled with some
other controls but no luck there.
I have also tried iecdump and iecset but these tools also didn't provide me
with the necessary results.
The problem will probably have nothing to do with the drivers but it looks
like I have to flip a few bits in order to activate the digital out.
Could someone please provide me with the correct bitmask that I need for
enabling the interface?

I have included some further info below that might be helpful.
It seems that control.18, control.19 and control.20 are the most interesting
controls. But I don't know what bitmask I should use to enable the digital
out and I'm a little afraid to just start playing with the controls. I 
don't want
to break anything by writing invalid values to it.
Control.16 also seems important but since it's on by default I don't think
that I have to worry about that one.


./iecdump -Dhw:1

Mode:           consumer
Data:           audio
Rate:           44100 Hz
Copyright:      protected
Emphasis:       none
Category:       general
Original:       1st generation
Clock:          1000 ppm

./iecdump -Dhw:1 -x

AES0=0x04,AES1=0x80,AES2=0x00,AES3=0x00


/etc/asound.state

state.T71Space {
         control.1 {
                 comment.access read
                 comment.type BYTES
                 iface CARD
                 name 'ICE1724 EEPROM'
                 value 
'1145153b13021380f8c2ffffbf0000000000000000000000000000000000000000000000000000000000000000000000ffffbf00'
         }
         control.2 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 '8000'
                 comment.item.1 '9600'
                 comment.item.2 '11025'
                 comment.item.3 '12000'
                 comment.item.4 '16000'
                 comment.item.5 '22050'
                 comment.item.6 '24000'
                 comment.item.7 '32000'
                 comment.item.8 '44100'
                 comment.item.9 '48000'
                 comment.item.10 '64000'
                 comment.item.11 '88200'
                 comment.item.12 '96000'
                 comment.item.13 '176400'
                 comment.item.14 '192000'
                 comment.item.15 'IEC958 Input'
                 iface MIXER
                 name 'Multi Track Internal Clock'
                 value '32000'
         }
         control.3 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 iface MIXER
                 name 'Multi Track Rate Locking'
                 value false
         }
         control.4 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 iface MIXER
                 name 'Multi Track Rate Reset'
                 value true
         }
         control.5 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 value 'PCM Out'
         }
         control.6 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 index 1
                 value 'PCM Out'
         }
         control.7 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 index 2
                 value 'PCM Out'
         }
         control.8 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 index 3
                 value 'PCM Out'
         }
         control.9 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 index 4
                 value 'PCM Out'
         }
         control.10 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 index 5
                 value 'PCM Out'
         }
         control.11 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 index 6
                 value 'PCM Out'
         }
         control.12 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'H/W Playback Route'
                 index 7
                 value 'PCM Out'
         }
         control.13 {
                 comment.access read
                 comment.type INTEGER
                 comment.range '0 - 255'
                 iface MIXER
                 name 'Multi Track Peak'
                 value.0 0
                 value.1 0
                 value.2 0
                 value.3 0
                 value.4 0
                 value.5 0
                 value.6 0
                 value.7 0
                 value.8 0
                 value.9 0
                 value.10 0
                 value.11 0
                 value.12 0
                 value.13 0
                 value.14 0
                 value.15 0
                 value.16 0
                 value.17 0
                 value.18 0
                 value.19 0
                 value.20 0
                 value.21 0
         }
         control.14 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'IEC958 Playback Route'
                 value 'PCM Out'
         }
         control.15 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'PCM Out'
                 comment.item.1 'H/W In 0'
                 comment.item.2 'H/W In 1'
                 comment.item.3 'IEC958 In L'
                 comment.item.4 'IEC958 In R'
                 iface MIXER
                 name 'IEC958 Playback Route'
                 index 1
                 value 'PCM Out'
         }
         control.16 {
                 comment.access 'read write'
                 comment.type BOOLEAN
                 iface MIXER
                 name 'IEC958 Output Switch'
                 value true
         }
         control.17 {
                 comment.access 'read write'
                 comment.type IEC958
                 iface PCM
                 device 1
                 name 'IEC958 Playback Default'
                 value 
'0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
         }
         control.18 {
                 comment.access read
                 comment.type IEC958
                 iface MIXER
                 device 1
                 name 'IEC958 Playback Con Mask'
                 value 
'3fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
         }
         control.19 {
                 comment.access read
                 comment.type IEC958
                 iface MIXER
                 device 1
                 name 'IEC958 Playback Pro Mask'
                 value 
df00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
         }
         control.20 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 value 88
         }
         control.21 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 index 1
                 value 88
         }
         control.22 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 index 2
                 value 88
         }
         control.23 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 index 3
                 value 88
         }
         control.24 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 index 4
                 value 92
         }
         control.25 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 index 5
                 value 90
         }
         control.26 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 index 6
                 value 92
         }
         control.27 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'DAC Volume'
                 index 7
                 value 90
         }
         control.28 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 101'
                 iface MIXER
                 name 'Master Playback Volume'
                 value 90
         }
         control.29 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 31'
                 iface MIXER
                 name 'ADC Volume'
                 value 27
         }
         control.30 {
                 comment.access 'read write'
                 comment.type INTEGER
                 comment.range '0 - 31'
                 iface MIXER
                 name 'ADC Volume'
                 index 1
                 value 27
         }
         control.31 {
                 comment.access 'read write'
                 comment.type ENUMERATED
                 comment.item.0 'CD Left'
                 comment.item.1 'CD Right'
                 comment.item.2 'Aux Left'
                 comment.item.3 'Aux Right'
                 comment.item.4 'Line Left'
                 comment.item.5 'Line Right'
                 comment.item.6 'Mic Left'
                 comment.item.7 'Mic Right'
                 iface MIXER
                 name 'Capture Route'
                 value.0 'CD Left'
                 value.1 'CD Left'
         }
}


Kind regards,

Dennis van der Meer



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
