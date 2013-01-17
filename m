From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH 03/19] ALSA: ymu831: add B-DSP driver
Date: Thu, 17 Jan 2013 14:58:45 +0900
Message-ID: <20130117145845.317d17da2d88013b71780062@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116172832.7339f01ca4557727fdc3883f@linux-mips.org>
 <s5hfw21pctq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo.iij4u.or.jp (mo11.iij4u.or.jp [210.138.174.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BF1B264E96
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 06:58:51 +0100 (CET)
In-Reply-To: <s5hfw21pctq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Jan 2013 12:49:37 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 16 Jan 2013 17:28:32 +0900,
> Yoichi Yuasa wrote:
> > 
> > +static void bdsp_check_sin_control_sel(struct aec_bdsp_info *bdsp, u8 *data)
> > +{
> > +	u32 addr;
> > +	u32 size;
> > +
> > +	addr = htonl(*(u32 *) data);
> > +	size = htonl(*(u32 *) (data + 5));
> 
> It's an unaligned access. 

The size is unaligned.
I'll add a comment.

> And normally we use cpu_to_xxx() or
> xxx_to_cpu() macros for endian conversions.

I'll update them.

Thank you for your comment.

Yoichi
