From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix validation of firmware
 and coeff lengths
Date: Fri, 8 Dec 2017 09:36:19 +0000
Message-ID: <20171208093619.jtnuvjfmane4ezas@localhost.localdomain>
References: <20171207211928.btwtwlfci6f4hku2@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 66198266B67
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 10:36:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171207211928.btwtwlfci6f4hku2@xylophone.i.decadent.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: patches@opensource.cirrus.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 07, 2017 at 09:19:29PM +0000, Ben Hutchings wrote:
> The checks for whether another region/block header could be present
> are subtracting the size from the current offset.  Obviously we should
> instead subtract the offset from the size.
> 
> The checks for whether the region/block data fit in the file are
> adding the data size to the current offset and header size, without
> checking for integer overflow.  Rearrange these so that overflow is
> impossible.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

But you would probably be best to resend and include Mark Brown
in the To: field. He applies the Wolfson patches directly to his
tree and he might miss it since it just went to the list.

Thanks,
Charles
