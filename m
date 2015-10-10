From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001 MIDI
Date: Sat, 10 Oct 2015 14:16:56 +0100
Message-ID: <1787556.aGiPR74l1T@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 566DD26044B
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 15:16:59 +0200 (CEST)
Received: by wicgb1 with SMTP id gb1so2249662wic.1
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 06:16:59 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id i10sm7982268wjz.41.2015.10.10.06.16.57
 for <alsa-devel@alsa-project.org>
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 10 Oct 2015 06:16:57 -0700 (PDT)
In-Reply-To: <1481883.Y22cmGKEIB@kamdesktop>
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

Forking this thread to focus on MIDI issues

This device has a single USB MIDI Interface on Interface 3, with 2 alternate 
settings, each with 2 endpoints as follows:

Interface 3
 - Setting 0
    - Endpoint 3 OUT Bulk Data
    - Endpoint 4 IN Bulk Data
 - Setting 1
    - Endpoint 3 OUT Interrupt data
    - Endpoint 5 IN Interrupt data

My evaluation is that this is a new style of MIDI Interface from others 
previously encountered. Comparing, for instance, with the Roland V Synth GT 
which seems to have the following Interface layout:

Interface 2
 - Setting 0
    - Endpoint 3 OUT Bulk Data
    - Endpoint 4 IN Bulk Data
 - Setting 1
    - Endpoint 3 OUT Bulk data
    - Endpoint 4 IN Interrupt data

The major difference is that the GT.001 has Interrupt Transfer modes for both 
IN and OUT.

Looking at snd_usbmidi_switch_roland_altsetting this sets the alternate 
setting so that the interrupt input endpoint is used. This routine looks for a 
pair of endpoints where the OUT endpoint is Bulk transfer, and the input is 
Interrupt transfer, and sets the mode accordingly. I've modified this to 
support Interrupt Xfer in both directions, and this seems to work (although my 
changes aren't read for publication yet as they are rather experimental and 
messy, and probably break the existing detection.

I'll try to fix this code and submit a patch.

Cheers,

Keith
