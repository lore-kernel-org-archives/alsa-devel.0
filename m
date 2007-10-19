From: "" <semiyd@hotmail.com>
Subject: ALSA Bluetooth connection issue
Date: Fri, 19 Oct 2007 05:42:11 +0000
Message-ID: <BAY117-W54CC296D4E581831BA293C09F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s39.bay0.hotmail.com (bay0-omc2-s39.bay0.hotmail.com
	[65.54.246.175]) by alsa0.perex.cz (Postfix) with ESMTP id DA90B2451E
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 07:42:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi All:
    Im using ALSA 1.0.14 and bluez 3.20 and linux 2.6.18.The linux 2.6.18
(montavista) is running on an embeded development board(using S3C2410).
    When i tried to use 'aplay' to connect my bluetooth headset, i got
the following error from ALSA:

 $ aplay -D bluetooth /1.wav
audio[326]: Accepted new client connection on unix socket (fd=8)
audio[326]: Package PKT_TYPE_CFG_REQ:0
hcid[318]: /org/bluez: org.bluez.Manager.FindAdapter()
audio[326]: Got path /org/bluez/hci0 for adapter with address
00:80:E1:00:00:00
hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
hcid[318]: no matching session found. creating a new one
hcid[318]: sdp session added to cache
hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
hcid[318]: found matching session, removing from list
hcid[318]: sdp session added to cache
hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
hcid[318]: found matching session, removing from list
hcid[318]: sdp session added to cache
hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
hcid[318]: found matching session, removing from list
hcid[318]: sdp session added to cache
hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
hcid[318]: found matching session, removing from list
hcid[318]: sdp session added to cache
hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
hcid[318]: found matching session, removing from list
hcid[318]: sdp session added to cache
hcid[318]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
hcid[318]: found matching session, removing from list
hcid[318]: sdp session added to cache
audio[326]: Audio service discovery completed with success
hcid[318]: /org/bluez/hci0:
org.bluez.Adapter.FinishRemoteServiceTransaction()
hcid[318]: found matching session, removing from list
audio[326]: Found Hansfree record
audio[326]: Discovered Headset service on RFCOMM channel 1
audio[326]: Found Headset record
audio[326]: Found Audio Sink
audio[326]: Selecting default device
audio[326]: avdtp_ref(0x3b018): ref=2
audio[326]: a2dp_source_request_stream: selected SEP 0x37250
audio[326]: avdtp_ref(0x3b018): ref=3
hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
audio[326]: AVDTP: connected signaling channel to 00:0D:3C:EB:53:F0
audio[326]: session_cb
audio[326]: DISCOVER request succeeded
audio[326]: seid 1 type 1 media 0 in use 0
audio[326]: seid 2 type 1 media 0 in use 0
audio[326]: session_cb
audio[326]: GET_CAPABILITIES request succeeded
audio[326]: seid 1 type 1 media 0
hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
audio[326]: session_cb
audio[326]: GET_CAPABILITIES request succeeded
audio[326]: seid 2 type 1 media 0
audio[326]: Discovery complete
audio[326]: avdtp_set_configuration(0x3b018): int_seid=1, acp_seid=1
audio[326]: session_cb
audio[326]: SET_CONFIGURATION request succeeded
audio[326]: SBC Source: Set_Configuration_Cfm
audio[326]: avdtp_ref(0x3b018): ref=4
audio[326]: stream state changed: IDLE -> CONFIGURED
audio[326]: session_cb
audio[326]: OPEN request succeeded
audio[326]: stream state changed: CONFIGURED -> OPEN
audio[326]: AVDTP: connected transport channel to 00:0D:3C:EB:53:F0
audio[326]: SBC Source: Open_Cfm
audio[326]: session_cb
audio[326]: START request succeeded
audio[326]: SBC Source: Start_CAlignment trap: bluetoothd-serv (326)
PC=0x0001be44 Instr=0xe1c320b0 Address=0xbec85c2d FSR 0x813
fm
audio[326]: SBC Source SEP 0x37250 locked
hcid[318]: Service owner exited: :1.2
aplay: main:550: audio open error: Input/output error
hcid[318]: Audio service (audio) was killed by signal 7

ALSA's aplay reports an "Input/output error".

Later i digged into alsa-lib-1.0.14/src/pcm/pcm.c and found that
snd_config_search_definition() returns an error.
It seems ALSA didn't find the proper conf definition or something like
that.

My ".asoundrc" is as followed:

pcm.a2dpd {
          type a2dpd
          }

pcm.bluetooth {
 type bluetooth
 device 00:0D:3C:EB:53:F0
}

pcm.!default {
      type hw
      card 0
      device 0
}

pcm.card0 {
  type hw
  card 0
}
ctl.card0 {
  type hw
  card 0
}

Does someone have any idea about what's going wrong in this?



Thanks in advance!


semiyd
_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=windows+vista&mkt=en-US&form=QBRE
