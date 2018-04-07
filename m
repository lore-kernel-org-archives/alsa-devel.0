From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 1/3] dell-led: Change dell-led.h to
	dell-common.h
Date: Sat, 7 Apr 2018 09:44:48 -0700
Message-ID: <20180407164448.GC11256@fury>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 49FEA266FA1
 for <alsa-devel@alsa-project.org>; Sat,  7 Apr 2018 18:44:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180308091023.9061-1-kai.heng.feng@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, tiwai@suse.com, platform-driver-x86@vger.kernel.org, pali.rohar@gmail.com, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 08, 2018 at 05:10:21PM +0800, Kai-Heng Feng wrote:
> This header will be used for more than just led. Change it to a more
> generic name.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2: Mario suggested to squash the HDA part into the same series.

Apologies for the silence on my end. I've reviewed all the comments, and
my understanding is we are awaiting a v3 from Kai-Heng. Is that correct?

Mario and Pali, thank you for working through the heuristics of platform
identification. I appreciate taking the time to look at the big picture,
or the scale impacts ("what if everyone did this?") - that leads to
better solutions. Of course, this is the platform driver subsystem, and
part of why we exist is to cover the quirks of today's systems, so we
can't spend too much time on what-ifs. I think your conclusions were
reasonable.

So I'm waiting for v3 from Kai-Heng - unless I've misunderstood the
conclusion of this thread.
-- 
Darren Hart
VMware Open Source Technology Center
