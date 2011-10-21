From: Randell Jesup <randell1@jesup.org>
Subject: Use of _hint() functions and older machines
Date: Thu, 20 Oct 2011 23:28:37 -0400
Message-ID: <4EA0E6E5.1050600@jesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from r2-chicago.webserversystems.com
	(r2-chicago.webserversystems.com [173.236.101.58])
	by alsa0.perex.cz (Postfix) with ESMTP id A1672103A79
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 05:33:21 +0200 (CEST)
Received: from pool-173-49-141-165.phlapa.fios.verizon.net ([173.49.141.165]
	helo=[192.168.1.12])
	by r2-chicago.webserversystems.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <randell1@jesup.org>) id 1RH5rD-0003ko-Kb
	for alsa-devel@alsa-project.org; Thu, 20 Oct 2011 22:33:19 -0500
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

[ I initially posted this to the -users list, but it may be more 
appropriate here ]

At Mozilla, we're in the process of adding support for WebRTC 
(http://webrtc.org/), which is being standardized by the IETF (their 
part is 'rtcweb'), and the W3C.  This adds real-time audio and video 
(and data) communication to browsers, peer-to-peer over encrypted channels.

We have a sound library that can load either Pulse or Alsa.  However, 
for Alsa, it wants to look at snd_device_name_hint() and also 
_get_hint() and _free_hint().  It lazy-binds to libasound, so it will 
dlopen() it and then dlsym() all the symbols it uses; if any fail it 
unloads the lib and says it's not there.  It  uses the hint functions to 
build a device list, for example for presenting to the user.

I have two problems:

1) Firefox is build on machines configured with I believe Centos5, and 
I'm told the machines run Alsa 1.0.12, while the hints() functions were 
added in 1.0.14 (released June 2007).  Right now I can't build release 
or 'try' builds on the build servers because of this.

2) We'd like to run on older machines if possible, and official release 
builds are made on those servers.  On older machines, _hint() aren't 
available, so even if I make them optional to dlsym-loading, I would 
need some other method to get the information I assume using older, 
now-deprecated-or-gone interfaces.

Any suggestions?  Tips?

See 
http://code.google.com/p/webrtc/source/browse/trunk/src/modules/audio_device/main/source/linux/audio_device_alsa_linux.cc?r=347#2348 
for how they're used currently.

Thanks!

-- 
Randell Jesup
randell-ietf@jesup.org
