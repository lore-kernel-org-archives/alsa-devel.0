From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: hda: Is it ok to enable SND_HDA_I915 to support
 Haswell Gfx power well by default?
Date: Tue, 27 Aug 2013 11:38:11 +0200
Message-ID: <521C7383.2040901@canonical.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F8013274C1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A3B3262610
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 11:38:14 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8013274C1@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/27/2013 11:32 AM, Lin, Mengdong wrote:
> Hi Takashi and David,
> 
>  
> 
> Is it okay to enable SND_HDA_I915 by default?

I think it should be automatically enabled if the user has selected both
of snd-hda-intel and i915. And I thought it already was, but I haven't
checked so I might very well be wrong.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
