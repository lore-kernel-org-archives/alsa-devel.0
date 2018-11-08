From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [RFC PATCH] cplay: Always write frag *
	fragment_size
Date: Thu, 8 Nov 2018 15:21:47 +0000
Message-ID: <20181108152147.GT16508@imbe.wolfsonmicro.main>
References: <1541427790-27876-1-git-send-email-daniel.baluta@nxp.com>
 <1541687863.3164.87.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A714D267AD3
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2018 16:21:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1541687863.3164.87.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "vkoul@kernel.org" <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 08, 2018 at 02:37:43PM +0000, Daniel Baluta wrote:
> Hi Vinod,
> 
> Just noticed that this patch is similar with this one for crecord
> 
> http://git.alsa-project.org/?p=tinycompress.git;a=commit;h=e8e36567438c
> 16a5121943205a0cd8c63924d0d8
> 
> So, I think we can remove the RFC tag :).
> 
> thanks,
> Daniel.
> On Lu, 2018-11-05 at 14:23 +0000, Daniel Baluta wrote:
> > cplay first writes frag * fragment_size and then
> > it only writes one fragment at a time.
> > 
> > This means for example than if the user supplied a buffer_size
> > it will only be used for the first write.
> > 
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> > I noticed this while investigating why cplay prints buffer_size as
> > 0 when not specified as command line argument to cplay.
> > 
> > I also noticed that cred always reads frag * frament_size, so I think
> > this patch should be OK, but marking it as RFC to get your thoughts.
> > 

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Yeah looks good to me.

Thanks,
Charles
