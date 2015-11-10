From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: damp: Reset dapm wcache after
 freeing damp widgets
Date: Tue, 10 Nov 2015 10:37:10 +0000
Message-ID: <20151110103710.GI2549@ck-lbox>
References: <1447075826-641-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 23ACF2606CA
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 11:52:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1447075826-641-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2015 at 03:30:26PM +0200, Jyri Sarha wrote:
> If there is anything in damp->path_source_cache or
> damp->path_sink_cache, it can not be valid after the widgets have been
> freed. Without this patch a repeated remove and load of a machine
> driver may cause NULL pointer reference in dapm_wcache_lookup() when a
> freed widget, not belonging to any list, is haunting in the wcache.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Reported-by: Felipe Balbi <balbi@ti.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
