From: "Clemens Ladisch" <clemens@ladisch.de>
Subject: Re: Handling of the DXS controls in the via82xx driver
Date: Mon, 29 Mar 2010 14:56:11 +0200
Message-ID: <1269867371.6760.1367253675@webmail.messagingengine.com>
References: <4BAE8EF7.20204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5D20724387
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 14:56:13 +0200 (CEST)
In-Reply-To: <4BAE8EF7.20204@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Soeren D. Schulze" <soeren.d.schulze@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Soeren D. Schulze wrote:
> before my latest upgrade to Linux 2.6.32 (yes, sorry, it's Debian), I
> had four levers in my alsamixer: VIA DXS, VIA DXS 1, VIA DXS 2 and VIA
> DXS 3.  They controlled the hardware mixing when accessing the sound
> device multiple times.
> 
> Now they have disappeared.
> 
> As I'm not an ALSA developer, I don't realize the intended effect of
> this change,

Hiding these controls is an intended effect, because normal mixers
do not show application-specific controls that could go away or be
reset at any time.

> but the actual effect is that I cannot change the DXS volumes any
> more.

You can with the hwmixvolume tool in the alsa-tools package (version
1.0.23, not yet released).

> mplayer still controls the global PCM volume.  Well,
> in fact, there is one way.  While an mplayer is running, I can do:
> 
> amixer cset numid=47,iface=PCM,name='PCM Playback Volume' 24,24
> 
> When restarting mplayer, the volume is reset to 31,31 (maximum).

The old behaviour was considered buggy: these stream controls are
logically associated with a stream opened by an application, not with
a particular hardware stream.

> The bad thing about it is that 31,31 is a really bad setting for my
> poorly engineered sound card.  It distorts a lot.

If the card cannot handle any loud output, then all outputs from any
source must be restricted, so the logical place for lower volume would
be the "Master" or "PCM" controls.


Regards,
Clemens
