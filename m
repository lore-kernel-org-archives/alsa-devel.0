From: pl bossart <bossart.nospam@gmail.com>
Subject: ALSA and MediaController
Date: Tue, 17 May 2011 12:48:59 -0500
Message-ID: <BANLkTikWAZAh-1Bm=8n0=2-fJjnA6R4mrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B7168245E8
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 19:48:59 +0200 (CEST)
Received: by ewy6 with SMTP id 6so231836ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2011 10:48:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

During the ALSA/Embedded audio workshop two weeks ago we talked about
using the MediaController API (merged in 2.6.39) to provide userspace
with a graph-like representation of the transforms implemented in
firmware or hardware.
Two main applications were mentioned:
- volume control, at the moment in PulseAudio we get a flat list of
volume controls and we use a convoluted mixer logic to figure out if
'pcm playback volume' is done before or after 'master playback
volume'.
- tuning applications. With literally dozens of controls exposed in
embedded solutions, a flat list is going to be very hard to use. It
would make sense during the device tuning steps to figure out which
controls is located where to better understand its impacts. This would
help create UCM configuration files as well.

At the moment the Media Controller does not provide means to set any
values/parameters in a media_entity. We would need to cross-reference
each media_entity with ALSA controls and use the existing control
get/set interfaces. This raises 2 main questions:
- Is the list of ALSA controls is completely defined after the card
initialization step? Or do we have cases where ALSA controls are
created dynamically after the init? I tend to believe the former is
true but want to verify this with others on the mailing list. It's my
understanding that only connections may be changed in such a graph.
- Laurent suggested a new ioctl to export media_entity information to
userspace, as a binary buffer containing a list of TLV
(Type-Length-Value) field. However it looks like there's already an
ELEM_BYTES control type. It might make more sense to expose this
information using native ALSA controls, but again feedback from smart
people on this list would be welcome.

Thanks,
-Pierre
