From: "Simon Dunn" <sdunn@mpc-data.co.uk>
Subject: softvol plug-in dependancies?
Date: Sat, 10 May 2008 20:59:28 +0100
Message-ID: <op.uaye5g1khpbl6d@derby>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from molson.mpc-data.co.uk (cvs.mpc-ogw.co.uk [81.2.99.171])
	by alsa0.perex.cz (Postfix) with ESMTP id BF1DF244BA
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 21:59:25 +0200 (CEST)
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

Hi Guys

The softvol plug-in, are there any pre-requisites or dependancies
to using this?  I've tried various entries in the /etc/asound.conf
configuration file all with the same result.

I can see the control in alsamixer, once I've run the speaker-test
through it, but cannot adjust any settings.  Trying to run 'alsactl
store 0' results in this error :

.
alsactl: control.c:2437: snd_ctl_elem_value_get_integer: Assertion `idx <  
sizeof
(obj->value.integer.value) / sizeof(obj->value.integer.value[0])' failed.
Aborted
.

Curiously using amixer the device is listed but its properties are
displayed like this

.
Simple mixer control 'PCM Vol',0
   Capabilities: volume
   Playback channels: Front Left - Front Right - Rear Left - Rear Right -  
Front C
enter - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? - ?  
- ? -
? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
   Capture channels: Front Left - Front Right - Rear Left - Rear Right -  
Front Ce
nter - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? - ? -  
? - ?
  - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
   Limits: 0 - 0
   Front Left: 0 [0%]
   Front Right: 0 [0%]
   Rear Left: 0 [0%]
   Rear Right: 0 [0%]
   Front Center: 0 [0%]
   Woofer: 0 [0%]
   Side Left: 0 [0%]
   Side Right: 0 [0%]
   Rear Center: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]
   ?: 0 [0%]

Any clues as to what's going on here would be much appreciated before
I have to start dissecting the library.

TIA for any hints
Simon

-- 

Simon Dunn, Software Engineer
MPC Data Limited
e-mail: sdunn@mpc-data.co.uk
web: www.mpc-data.co.uk
tel: +44 (0) 1225 710600
fax: +44 (0) 1225 710601
ddi: +44 (0) 1225 710631

MPC Data Limited is a company registered in England and Wales with company  
number 05507446
Registered Address: County Gate, County Way, Trowbridge, Wiltshire, BA14  
7FJ
VAT no: 850625238

The information in this email and in the attached documents is  
confidential and may be legally privileged. Any unauthorized review,  
copying, disclosure or distribution is prohibited and may be unlawful. It  
is intended solely for the addressee. Access to this email by anyone else  
is unauthorized. If you are not the intended recipient, please contact the  
sender by reply email and destroy all copies of the original message. When  
addressed to our clients any opinions or advice contained in this email is  
subject to the terms and conditions expressed in the governing contract.
