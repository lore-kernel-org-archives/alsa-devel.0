From: Alexander Winnig <vernehmlassung@googlemail.com>
Subject: Raspberry Pi + Bluetooth Headset + Broadcom adapter
Date: Fri, 14 Jun 2013 14:19:21 +0200
Message-ID: <51BB0A49.3000001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

I want to give you a short summary of what I'm doing and what I'm trying 
to achieve: I have a Bluetooth headset "Iqua BHS-611" ( 
http://www.iqua.com/sites/default/files/product/iqua_slim_4.png ) and a 
Belkin USB adapter( 
http://www.amazon.co.uk/Belkin-USB-4-0-Bluetooth-Adapter/dp/B009IQB3US 
). I can hear A2DP-transmitted audio on my headset. But when it comes to 
using the microphone I record zero bytes on a regular basis using

parecord -r -d bluez_source.<whatever mac address> test.wav

No error output, just a zero byte test.wav. Trying to use paplay to play 
a file(I tried 8000 Hz, 44,100 Hz files I created using another 
application, which contained audio data) also doesn't work using the 
HSP. Using the A2DP again, there is no problem.

On your " contact us" - page ( 
http://bluetooth-alsa.sourceforge.net/contact.html ) you wrote
> You might be able to get a broadcom adapter to work but it may require 
> that you boot with a kernel argument (the force_scofix parameter of 
> the hci_usb driver?) to
> force sco mtu values
I do have a Broadcom adapter, the belkin one. But I am using the 
raspberry pi, which only has a cmdline.txt for kernel parameters. I 
added force_scofix=1 but that didn't change anything. So now I am back to

> dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 
> console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline 
> rootwait

for cmdline.txt.

How can I make sure, that the reason is really the broadcom adapter, so 
I won't buy a new one in vain? After all A2DP is working.

PS: Plugging in the Bluetooth adapter into an USB port of a computer 
that is running Windows 7 and installing the drivers that were included 
on the included CD-ROM, I can use all functionality of the headset, I 
can use the microphone just as a normal microphone in the microphone's 
list, I can use the stereo audio output, everything works.

This is the hcidump for the recording attempt:

HCI sniffer - Bluetooth packet analyzer ver 2.4
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:1A:7D:11:C0:66 class 0x240404 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:1A:7D:11:C0:66 role 0x00
     Role: Master
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Role Change (0x12) plen 8
     status 0x00 bdaddr 00:1A:7D:11:C0:66 role 0x00
     Role: Master
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 11 bdaddr 00:1A:7D:11:C0:66 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 11
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 11 slots 5
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 11
     Features: 0xff 0xfe 0x0f 0xc6 0x8b 0xef 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
     handle 11 page 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 11 page 1 max 1
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:1A:7D:11:C0:66 mode 2 clkoffset 0x0000
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< ACL data: handle 11 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
       Connection pending - No futher information available
< ACL data: handle 11 flags 0x00 dlen 10
     L2CAP(s): Info req: type 2
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x0000
< ACL data: handle 11 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 48
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 48
 > ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 11 flags 0x02 dlen 24
     L2CAP(d): cid 0x0040 len 20 [psm 1]
         SDP SSA Req: tid 0x1 len 0xf
           pat uuid-32 0x111f (Handsfree AG)
           max 38
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:1A:7D:11:C0:66 name 'Iqua Slim'
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
< ACL data: handle 11 flags 0x00 dlen 33
     L2CAP(d): cid 0x0040 len 29 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x18
           count 21
           record #0
               aid 0x0004 (ProtocolDescList)
                  < < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xd > >
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:1A:7D:11:C0:66
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:1A:7D:11:C0:66 key 4118887B24F8519BEBF20B626C48413E
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:1A:7D:11:C0:66
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 11 encrypt 0x01
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 11 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
       Connection successful
< ACL data: handle 11 flags 0x00 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 895
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 895
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 11 flags 0x00 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 26 frame_type 0 credit_flow 15 pri 0 ack_timer 0
       frame_size 126 max_retrans 0 credits 0
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 26 frame_type 0 credit_flow 14 pri 0 ack_timer 0
       frame_size 126 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
     handle 11
 > HCI Event: Command Status (0x0f) plen 4
     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:1A:7D:11:C0:66
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:1A:7D:11:C0:66 key 4118887B24F8519BEBF20B626C48413E
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:1A:7D:11:C0:66
 > HCI Event: Auth Complete (0x06) plen 3
     status 0x00 handle 11
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
     handle 11 encrypt 0x01
 > HCI Event: Command Status (0x0f) plen 4
     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
 > HCI Event: Encryption Key Refresh Complete (0x30) plen 3
     status 0x00 handle 11
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 11 encrypt 0x01
< ACL data: handle 11 flags 0x00 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 6
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 6
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 6
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 6
< ACL data: handle 11 flags 0x00 dlen 9
     L2CAP(d): cid 0x0041 len 5 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 33
 > ACL data: handle 11 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 15
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 11 fcs 0xe4
< ACL data: handle 11 flags 0x00 dlen 22
     L2CAP(d): cid 0x0041 len 18 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 2
< ACL data: handle 11 flags 0x00 dlen 134
     L2CAP(d): cid 0x0041 len 130 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 126 fcs 0x3e
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 9 fcs 0xf8 credits 3
< ACL data: handle 11 flags 0x00 dlen 32
     L2CAP(d): cid 0x0041 len 28 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 24 fcs 0x3e
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 28
     L2CAP(d): cid 0x0040 len 24 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 19 fcs 0xf8 credits 2
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 1
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 11 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 0 status 0
       Connection successful
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 48
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
       MTU 48
 > ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 1
 > ACL data: handle 11 flags 0x02 dlen 24
     L2CAP(d): cid 0x0041 len 20 [psm 1]
         SDP SSA Req: tid 0x1 len 0xf
           pat uuid-32 0x111f (Handsfree AG)
           max 38
           aid(s) 0x0009 (BTProfileDescList)
           cont 00
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e
< ACL data: handle 11 flags 0x00 dlen 29
     L2CAP(d): cid 0x0042 len 25 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x14
           count 17
           record #0
               aid 0x0009 (BTProfileDescList)
                  < < uuid-16 0x111e (Handsfree) uint 0x105 > >
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0042
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0042
 > ACL data: handle 11 flags 0x02 dlen 30
     L2CAP(d): cid 0x0040 len 26 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 21 fcs 0xf8 credits 1
< ACL data: handle 11 flags 0x00 dlen 17
     L2CAP(d): cid 0x0041 len 13 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 9 fcs 0x3e
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Connect req: psm 25 scid 0x0041
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 0 status 0
       Connection successful
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 0
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 895
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 4
       MTU 895
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Connect req: psm 23 scid 0x0042
< ACL data: handle 11 flags 0x00 dlen 6
     L2CAP(d): cid 0x0043 len 2 [psm 25]
       AVDTP(s): Discover cmd: transaction 0 nsp 0x00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0042 result 1 status 2
       Connection pending - Authorization pending
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 25]
       AVDTP(s): Discover rsp: transaction 0 nsp 0x00
         ACP SEID 1 - Audio Sink
< ACL data: handle 11 flags 0x00 dlen 7
     L2CAP(d): cid 0x0043 len 3 [psm 25]
       AVDTP(s): Capabilities cmd: transaction 1 nsp 0x00
         ACP SEID 1
 > ACL data: handle 11 flags 0x02 dlen 20
     L2CAP(d): cid 0x0041 len 16 [psm 25]
       AVDTP(s): Capabilities rsp: transaction 1 nsp 0x00
         Media Transport
         Media Codec - SBC
           16kHz 32kHz 44.1kHz 48kHz
           Mono DualChannel Stereo JointStereo
           4 8 12 16 Blocks
           4 8 Subbands
           SNR Loudness
           Bitpool Range 2-53
         Content Protection
           02 00
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0042 result 0 status 0
       Connection successful
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 0
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
       MTU 895
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 4
       MTU 895
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
       Success
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
     enable 0
 > HCI Event: Command Complete (0x0e) plen 4
     Write Scan Enable (0x03|0x001a) ncmd 1
     status 0x00
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
 > HCI Event: Command Complete (0x0e) plen 5
     Read Scan Enable (0x03|0x0019) ncmd 1
     status 0x00 enable 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Disconn req: dcid 0x0043 scid 0x0041
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Disconn req: dcid 0x0044 scid 0x0042
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0041
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0044 scid 0x0042
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
     class 0x4a0100
 > HCI Event: Command Complete (0x0e) plen 4
     Write Class of Device (0x03|0x0024) ncmd 1
     status 0x00
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
     fec 0x00
     Unknown type 0x45 with 8 bytes data
     Unknown type 0x2d with 2 bytes data
 > HCI Event: Command Complete (0x0e) plen 4
     Write Extended Inquiry Response (0x03|0x0052) ncmd 1
     status 0x00
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
     class 0x4e0100
 > HCI Event: Command Complete (0x0e) plen 4
     Write Class of Device (0x03|0x0024) ncmd 1
     status 0x00
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
     handle 11 voice setting 0x0060 ptype 0x003f
 > HCI Event: Command Status (0x0f) plen 4
     Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
     status 0x00 handle 6 bdaddr 00:1A:7D:11:C0:66 type eSCO
     Air mode: CVSD
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 10 fcs 0x3e
< ACL data: handle 11 flags 0x00 dlen 19
     L2CAP(d): cid 0x0041 len 15 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 11 fcs 0x3e
< SCO data: handle 6 flags 0x00 dlen 48
< SCO data: handle 6 flags 0x00 dlen 48
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
     enable 3
 > HCI Event: Command Complete (0x0e) plen 4
     Write Scan Enable (0x03|0x001a) ncmd 1
     status 0x00
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
 > HCI Event: Command Complete (0x0e) plen 5
     Read Scan Enable (0x03|0x0019) ncmd 1
     status 0x00 enable 3
 > HCI Event: Mode Change (0x14) plen 6
     status 0x00 handle 11 mode 0x02 interval 160
     Mode: Sniff

