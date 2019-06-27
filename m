From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] ASoC: madera: Read device tree
	configuration
Date: Thu, 27 Jun 2019 08:15:54 +0800
Message-ID: <20190627001554.GH527@kroah.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
 <20190626153611.10170-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53ED9F8071F
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 02:16:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190626153611.10170-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, rafael@kernel.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-acpi@vger.kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 26, 2019 at 04:36:11PM +0100, Charles Keepax wrote:
> Read the configuration of the Madera sound driver from device tree using
> the new device tree helper function.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Note this patch depends on patches that are currently going through Mark's
> tree so probably best if this one also goes through there.

No objection from me for him to take the previous one with this one in
his tree.

thanks,

greg k-h
