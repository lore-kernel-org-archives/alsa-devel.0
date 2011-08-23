From: Stephen Warren <swarren@nvidia.com>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Tue, 23 Aug 2011 08:51:36 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>
References: <4E53C32E.9020801@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id CF14A243B6
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 17:51:41 +0200 (CEST)
In-Reply-To: <4E53C32E.9020801@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Tuesday, August 23, 2011 9:12 AM:
> Since modern HDMI cards often have more than one output pin and thus
> input device, we need to know which one has actually been plugged in.
> 
> This patch adds a name hint that indicates which PCM device is connected
> to which pin.
> 
> To do that, the jack creation has been deferred to build_controls, i e,
> after the PCM devices have been created.
> 
> Would be great to have Stephen look through this patch quickly before
> it's committed.

Structurally, I think this looks OK. The only question I have is the 
string format:

"HDMI/DP (pcm %d)", pcmdev

* Is there a 1:1 mapping between the internal pcmdev numbers and what
alsa-lib presents to clients? Thinking about ALSA device numbering, it's
like "hw:1,3", so includes the card number too; should that be in the
string?

* Would it be better to make the string completely generic - i.e. not
include "HDMI/DP", but rather something like "ALSA PCM %d", or even
"ALSA PCM hw:%d,%d" so that the same format could be used for non-HDMI/
DP PCMs in the future?

-- 
nvpublic
