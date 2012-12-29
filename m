From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk for Focusrite
	Scarlett 18i6
Date: Sat, 29 Dec 2012 13:38:39 +0100
Message-ID: <0618809b-1133-400a-bf57-430574b4c87e@email.android.com>
References: <20121109202023.60f6dcdc@martins.ozlabs.org>
 <s5hvcdavwoy.wl%tiwai@suse.de> <20121113193803.2e0d7c4a@martins.ozlabs.org>
 <s5hzk2lvpxh.wl%tiwai@suse.de>
 <CACckToUXjebb23w1AqM3zB2fwWHmLHJwEiySsuEKDKnVdLmC0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 327FC261615
 for <alsa-devel@alsa-project.org>; Sat, 29 Dec 2012 13:38:53 +0100 (CET)
In-Reply-To: <CACckToUXjebb23w1AqM3zB2fwWHmLHJwEiySsuEKDKnVdLmC0A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Martin Schwenke <martin@meltin.net>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Grant Diffey wrote:
>Last week on #alsa  I found yet another person who's having
>problems with snd-usb-audio not supporting UAC2 Feature units.

This is an extension unit. The driver not handling it is yet another bug.

>Worse still the relevant part of the descriptor is incomplete according to
>lsusb

lsusb might be as error-free as snd-usb-audio, and in any case an
incomplete descriptor for some random mixer control should be no
reason to refuse working with the device altogether.

>So while we could submit another quirk for this to ignore the mixer for
>now. and this would probably make the device "work"  without access to
>the feature unit is it sensible?

The sensible thing to do is to review the entire new descriptor parsing
code to remove all invalid and overzealous error cases.


Regards,
Clemens
