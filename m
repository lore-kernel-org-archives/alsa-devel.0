From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Wed, 14 Nov 2018 11:30:21 +0000
Message-ID: <20181114113021.GZ16508@imbe.wolfsonmicro.main>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
 <1542134957-2395-2-git-send-email-james.schulman@cirrus.com>
 <20181114093111.GX16508@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E04267AB9
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 12:30:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181114093111.GX16508@imbe.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 14, 2018 at 09:31:11AM +0000, Charles Keepax wrote:
> On Tue, Nov 13, 2018 at 12:49:17PM -0600, James Schulman wrote:
> > Add device tree documentation for Cirrus Logic CS35L36
> > speaker amplifier
> > 
> > Signed-off-by: James Schulman <james.schulman@cirrus.com>
> > ---
> > +	cirrus,irq-config {
> > +		cirrus,irq-drive-select = <0x01>;
> > +		cirrus,irq-polarity = <0x00>;
> > +		cirrus,irq-gpio-select = <0x01>;
> > +		cirrus,irq-output-enable = <0x01>;
> > +		cirrus,irq-src-select = <0x01>;
> > +	};
> 
> This block is not documented in the rest of the document and
> looks like things that should really be controlled through other
> means. Presuming this is legacy and just needs removed?

Seems they are used by the driver so I guess best to document
them as a first step and we can review them from there.

Also looks like documentation is also missing for:

dcm-mode-enable
boost-ind-nanohenry

Thanks,
Charles
