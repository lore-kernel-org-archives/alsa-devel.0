From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Tue, 18 Dec 2018 09:30:22 +0000
Message-ID: <20181218093022.GT16508@imbe.wolfsonmicro.main>
References: <1545072932-18474-1-git-send-email-james.schulman@cirrus.com>
 <1545072932-18474-2-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 37BF726782E
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 10:30:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1545072932-18474-2-git-send-email-james.schulman@cirrus.com>
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
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 17, 2018 at 12:55:32PM -0600, James Schulman wrote:
> +  - cirrus,irq-polarity : Selects the polarity of the selected interrupt output
> +  when in push-pull mode. Note - when the selected interrupt output is in
> +  open-drain mode, INT_POL_SEL must be set to 0.
> +
> +  0 = Active-low (Default)
> +  1 = Active-high
> +

Only outstanding comment from me is this guy I think. Is there a
reason you prefer not to specify it through the interrupt flags?

Thanks,
Charles
