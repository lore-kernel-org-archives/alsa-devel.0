From: "Kaskinen, Tanu" <tanu.kaskinen@intel.com>
Subject: Re: [Intel-gfx] [PATCH 3/4] snd: add support for
 displayport multi-stream to hda codec.
Date: Fri, 26 Jun 2015 16:27:30 +0000
Message-ID: <1435336050.7153.62.camel@tkkaskin-mobl3.ger.corp.intel.com>
References: <1434513719-3580-1-git-send-email-airlied@gmail.com>
 <1434513719-3580-4-git-send-email-airlied@gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B895171@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txJyV_q8ihnqXzyKF8NLbYQ85iuggQHpwe18dPCFdbgLA@mail.gmail.com>
 <s5hpp4s9ceq.wl-tiwai@suse.de> <20150622125429.GW25769@phenom.ffwll.local>
 <s5h7fqv7u7s.wl-tiwai@suse.de> <1434979769.2503.32.camel@loki>
 <1434986474.6176.53.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5hioafeoj4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D49982614CD
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 18:27:37 +0200 (CEST)
In-Reply-To: <s5hioafeoj4.wl-tiwai@suse.de>
Content-Language: en-US
Content-ID: <038E70586CDAFE4E82325469658DADAE@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pulseaudio-discuss@lists.freedesktop.org" <pulseaudio-discuss@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Lu, Han" <han.lu@intel.com>, "airlied@gmail.com" <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-06-22 at 17:44 +0200, Takashi Iwai wrote:
> At Mon, 22 Jun 2015 15:21:16 +0000,
> Kaskinen, Tanu wrote:
> > PulseAudio (mostly) doesn't use the hw:X devices directly. Instead, it
> > uses logical names like "front", "hdmi", "iec958", etc. Speaking of HDMI
> > specifically, PulseAudio uses devices from "hdmi:X,0" to "hdmi:X,7".
> > With this new dynamic PCM system, do these logical names still work?
> 
> Unfortunately, this doesn't work for HDA as is, because of the
> terribly arcane secret.  For keeping the compatibility with the old
> config, there is a static mapping of the hdmi:x,y and hw:x,z.

Yes, the mapping is like this:

y = 0, z = 3
y = 1, z = 7
y = 2, z = 8
y = 3, z = 9
etc.

Now I'm wondering if this is HDA specific (your wording suggests that it
is)? For HDMI ELD information and jack detection support, PulseAudio has
been assuming this particular mapping. If other drivers have been using
a different mapping, then ELD and jack detection support has been and
continues to be broken for other drivers in PA.

-- 
Tanu
