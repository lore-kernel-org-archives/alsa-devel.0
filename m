From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 4/6] ARM: mvebu: remove conflicting muxing
 on Armada 370 DB
Date: Thu, 6 Nov 2014 22:15:42 -0500
Message-ID: <20141107031542.GB3698@titan.lakedaemon.net>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-5-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B990D2654D5
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 04:15:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1414512524-24466-5-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Tawfik Bayouk <tawfik@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 05:08:42PM +0100, Thomas Petazzoni wrote:
> Back when audio was enabled, the muxing of some MPP pins was causing
> problems. However, since commit fea038ed55ae ("ARM: mvebu: Add proper
> pin muxing on the Armada 370 DB board"), those problematic MPP pins
> have been assigned a proper muxing for the Ethernet interfaces. This
> proper muxing is now conflicting with the hog pins muxing that had
> been added as part of 249f3822509b ("ARM: mvebu: add audio support to
> Armada 370 DB").
> 
> Therefore, this commit simply removes the hog pins muxing, which
> solves a warning a boot time due to the conflicting muxing
> requirements.
> 
> Fixes: fea038ed55ae ("ARM: mvebu: Add proper pin muxing on the Armada 370 DB board")
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-db.dts | 24 ------------------------
>  1 file changed, 24 deletions(-)

Patches 5 and 6 applied to mvebu/dt with Andrew's Ack.

I didn't Cc this one to stable since it is only removing a warning.
Later on, if needed, someone can request it be backported and the Fixes
tag will assist with that.

thx,

Jason.
