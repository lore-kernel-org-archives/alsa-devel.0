From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC PATCH 1/11] expose sound device topology
	information
Date: Tue, 04 Sep 2012 20:02:57 +0200
Message-ID: <50464251.7030601@ladisch.de>
References: <503BF48E.1090100@ladisch.de> <s5hehmh233w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6329B265285
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2012 20:03:59 +0200 (CEST)
In-Reply-To: <s5hehmh233w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> The media controller API <linux/media.h> allows prividing routing
>> information, but its implementation does not quite fit the sound
>> drivers:
>> * it allows reconfiguration of links, but not in a way that would be
>>   useful for ALSA selector controls

I didn't mention why:  it is not possible to enable two links to a sink
pad, and neither can one change the state of two links atomically;
therefore, an enum control with exactly one active input cannot be
modelled.  (It might be possible to change the media controller API to
allow this.)

Mute controls _could_ be modelled by disabling links, but with all other
mixer control types not represented in the media controller API, this
doesn't appear to be very useful.

> But what about multiple codecs on a single control device?  Can they
> be represented well?

The driver has to choose the entity IDs so that they don't conflict;
something like busnumber<<20 | codecaddress<<10 | nodeid.
The USB audio driver will have this problem if there are multiple audio
control interfaces, so I guess it will have to include the interface
number.


Regards,
Clemens
