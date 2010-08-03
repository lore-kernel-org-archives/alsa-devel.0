From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Wrong channel order with multichannel HDMI on
	NVIDIA MCP7A
Date: Tue, 3 Aug 2010 23:57:23 +0300
Message-ID: <201008032357.23360.anssi.hannula@iki.fi>
References: <201007251951.39362.anssi.hannula@iki.fi>
	<201008032332.45997.anssi.hannula@iki.fi>
	<AANLkTi=rUCUo+JG8R6RFrbG25Zpa_6AAHfbzBYjsBmOc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 39BD124441
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 22:57:29 +0200 (CEST)
In-Reply-To: <AANLkTi=rUCUo+JG8R6RFrbG25Zpa_6AAHfbzBYjsBmOc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

(restored CC)

Kirjoitit tiistai, 3. elokuuta 2010 23:40:13:
> On Tue, Aug 3, 2010 at 1:32 PM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
> > pl bossart kirjoitti tiistai, 3. elokuuta 2010 23:15:28:
> >> > Well, this is one of my looong-standing TODOs.
> >> > Originally I wanted to implement a new API to get/set the
> >> > channel-mapping, mainly for HDMI.
> >> > But, I've been recently too busy for other tasks (I can spend little
> >> > time for ALSA), thus it's pending forever.
> >> 
> >> You would only need an API to get the channel mapping. The HDMI sink
> >> will report its speaker configuration through a CEA code (section 7.4
> >> of the spec), and if we parsed the EDID info we could present the
> >> relevant channel order to user-space apps.
> > 
> > I'm not sure I see how that will help with the problem of this thread,
> > though, i.e. NVIDIA MCP7A hdmi codec apparently assuming audio being fed
> > in windows channel order instead of alsa channel order.
> 
> You can in theory specify the channel order in the InfoFrame (CA
> field). If you had access to a register to program this, you would no
> longer be tied to alsa or windows or whatever order. You would just
> provide ALSA with the channels in the order you configured with the CA
> code.

The CA field is programmable, but the channel orders are predefined and no 
arbitrary channel formats are possible (see patch_hdmi.c or the related CEA 
spec).

The nvhdmi MCP7x codec driver tries to specify a channel order by using the 
channel_id field in AC_VERB_SET_CHANNEL_STREAMID for the 4 slave digital 
converters, but it doesn't seem to have any effect (at least on hardware I 
have; confirmed by swapping the channel_ids around with no effect).

-- 
Anssi Hannula
