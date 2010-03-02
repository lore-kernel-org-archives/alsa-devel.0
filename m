From: Wei Ni <wni@nvidia.com>
Subject: RE: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio
Date: Tue, 2 Mar 2010 18:44:45 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8E@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
	<s5hmxyrp311.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C068B2BA8C@HKMAIL01.nvidia.com>
	<s5heik3ujy0.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C068B2BA8D@HKMAIL01.nvidia.com>
 <s5hy6ibt36n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy6ibt36n.wl%tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'Pavel Hofman' <pavel.hofman@insite.cz>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'akpm' <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Ok, it's no problems.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, March 02, 2010 6:43 PM
To: Wei Ni
Cc: 'Pavel Hofman'; 'alsa-devel'; 'linux-kernel'; 'akpm'
Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio

At Tue, 2 Mar 2010 18:03:15 +0800,
Wei Ni wrote:
> 
> Yes, you are right. We should use quirk to set max codecs.

Also, could you split to two patches, one for extending max codecs for
the new controller and one for the new HDMI codec support?


thanks,

Takashi
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
