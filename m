From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 6/6] ARM: mvebu: update mvebu_v7_defconfig
 for Armada 370 audio
Date: Thu, 6 Nov 2014 22:17:32 -0500
Message-ID: <20141107031732.GC3698@titan.lakedaemon.net>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-7-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F4C82654D5
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 04:17:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1414512524-24466-7-git-send-email-thomas.petazzoni@free-electrons.com>
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

On Tue, Oct 28, 2014 at 05:08:44PM +0100, Thomas Petazzoni wrote:
> Now that the Armada 370 DB audio complex is represented fully in
> Device Tree using the simple-card DT binding, this commit updates
> mvebu_v7_defconfig to no longer select the Armada 370 DB audio machine
> driver, and instead select the appropriate audio controller and codec
> drivers.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to mvebu/defconfig with Andrew's Ack.

thx,

Jason.
