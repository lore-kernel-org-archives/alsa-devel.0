From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [RFC] Channel mapping API (take 2)
Date: Fri, 07 Sep 2012 12:16:14 +0300
Message-ID: <1347009374.4213.29.camel@laptop>
References: <s5hhard23jb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 49B2826168B
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 11:16:17 +0200 (CEST)
In-Reply-To: <s5hhard23jb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

One additional wish for the channel map API: functions for converting
between snd_pcm_chmaps and (machine-readable) strings. If channel map
information is added to UCM, the UCM code will have to parse the channel
map specifications, or if they are exposed as unfiltered strings to
applications, then applications will have to do the parsing. In either
case, having readily available functions to do the parsing would be
useful. Applications may also want to convert the chmap into a string
for logging purposes, for example.

-- 
Tanu
