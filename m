From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] device property: Add new array helper
Date: Thu, 27 Jun 2019 08:15:30 +0800
Message-ID: <20190627001530.GG527@kroah.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C90B5F806F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 02:15:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
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

On Wed, Jun 26, 2019 at 04:36:10PM +0100, Charles Keepax wrote:
> It is fairly common to want to read an integer array property
> that is composed of an unknown number of fixed size integer
> groups. For example, say each group consists of three values
> which correspond to the settings for one input on the device
> and the driver supports several chips with different numbers
> of inputs.
> 
> Add a new helper function to provide this functionality, it
> differs for the existing helpers in that it allows reading a
> smaller number of values than the full array size and checks
> that the number of values read is a multiple of the group size.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/base/property.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 50 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
