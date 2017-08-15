From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Headphone and headset jack control naming
Date: Tue, 15 Aug 2017 10:26:19 +0300
Message-ID: <1502781979.2602.4.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 470A626683B
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 09:26:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

A user reported various audio problems with the Alienware 14 laptop in
the PulseAudio bugzilla. One of the problems is that the jack control
names that alsa reports are incorrect. However, I'm not sure what the
correct names would be, so I'd like to get that clarified (I will then
file a proper bug report in the kernel bugzilla).

The laptop has three physical jacks: headphone, headset and microphone.
In general, headset jacks have been so far represented by two jack
controls: "Headphone" + "Headset Mic" (or is "Headphone" + "Mic" more
common? I think I've seen both being used). However, in this case
there's also a headphone-only jack. Should we invent a new name for
headset outputs, so that the headphone and headset outputs can be
distinguished, or should there be two "Headphone" controls, or should
one of the controls (which one?) use the "Headphone2" name that is
already used by some hardware?

FWIW, currently the output jack control names on Alienware 14 are
"Headphone Front" for the headset jack and "Headphone Surround" for the
headphone jack, which I assume we all agree is incorrect. Furthermore,
there's no "Headset Mic" jack control, or any other control
corresponding to the headset mic. "Mic" control exists, but it
corresponds to the separate microphone jack.

-- 
Tanu

https://www.patreon.com/tanuk
