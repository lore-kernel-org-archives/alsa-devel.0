From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [pulseaudio-discuss] Using UCM with PulseAudio
Date: Mon, 23 Jul 2012 09:33:27 +0300
Message-ID: <1343025207.2904.12.camel@laptop>
References: <1339728813.5228.48.camel@localhost>
 <1339762287.3007.127.camel@laptop> <1343014720.6131.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id A5FB3260308
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 08:33:28 +0200 (CEST)
In-Reply-To: <1343014720.6131.21.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: lrg@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, pulseaudio-discuss@lists.freedesktop.org, jankovac503@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-07-23 at 09:08 +0530, Arun Raghavan wrote:
> 3. Devices that have a loopback path in hardware/DSP (this is a request
> I've seen, but I'm not aware of hardware that does this)

Isn't this very common with desktop hardware? For example, my laptop's
sound card has a playback volume and mute control for the "Mic" element,
which supposedly could be used for looping the mic audio to the speakers
or headphones inside the hardware.

The N9 hardware also has several possibilities for loopbacks. We used
one for the sidetone in calls (sidetone means playing back your own
voice back to you, and it's a mandatory feature in mobile phones,
AFAIK).

-- 
Tanu
