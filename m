From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: HBR support on DP]
Date: Mon, 4 Sep 2017 09:42:02 +0530
Message-ID: <20170904041157.GA16154@subhransu-desktop>
References: <20170901051204.GA28326@subhransu-desktop>
 <s5hpobasf78.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8462A266F0E
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 06:29:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpobasf78.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 01, 2017 at 03:47:55PM +0200, Takashi Iwai wrote:
> On Fri, 01 Sep 2017 07:12:05 +0200,
> Subhransu S. Prusty wrote:
> > 
> > Hi Takashi/All,
> > 
> > On skylake platforms HBR audio works fine through over HDMI1.4, but not over
> > DP ports. Looking for information if anyone is aware of if HBR audio was
> > ever enabled/tested over DP ports? Is there any specific setting to be done
> > to play over DP using aplay?
> 
> I don't know of the difference regarding HBR setup between HDMI/DP
> from HD-audio POV.  It's just a pin control bit.
> 
> I guess the difference is rather in i915 graphics side?

Not sure. Checking with graphics people as well.

Regards,
Subhransu

> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
