From: David Henningsson <david.henningsson@canonical.com>
Subject: Lost dB volumes on USB headset between 2.6.38 and 3.0
Date: Tue, 09 Aug 2011 11:52:33 +0200
Message-ID: <4E410361.7010808@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000103050607070003070802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9FB9824544
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 11:52:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000103050607070003070802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hmm, I and Colin Guthrie have found a regression between kernels 2.6.38 
and 3.0.

When running "amixer -D hw:handset" for this device under 2.6.38, the 
attached file is returned. Under 3.0, the dB information is missing. 
This can't be intentional, can it?

-- 
David Henningsson
http://launchpad.net/~diwic

--------------000103050607070003070802
Content-Type: text/x-log;
 name="mixer38.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mixer38.log"

Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 148 [58%] [-20.13dB] [on]
  Front Right: Playback 148 [58%] [-20.13dB] [on]
Simple mixer control 'PCM Capture Source',0
  Capabilities: enum
  Items: 'Mic' 'Line' 'IEC958 In'
  Item0: 'Mic'
Simple mixer control 'Line',0
  Capabilities: pvolume cvolume pswitch pswitch-joined cswitch cswitch-joined penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 255 Capture 0 - 128
  Front Left: Playback 0 [0%] [0.00dB] [off] Capture 1 [1%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [0.00dB] [off] Capture 1 [1%] [0.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined cvolume cvolume-joined pswitch pswitch-joined cswitch cswitch-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: Playback 0 - 255 Capture 0 - 128
  Mono: Playback 191 [75%] [35.81dB] [off] Capture 0 [0%] [0.18dB] [off]
Simple mixer control 'IEC958 In',0
  Capabilities: cswitch cswitch-joined penum
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]

--------------000103050607070003070802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000103050607070003070802--
