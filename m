From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: nau8825: cross talk suppression measurement
	function
Date: Mon, 20 Jun 2016 13:00:12 +0300
Message-ID: <20160620100012.GK32247@mwanda>
References: <20160615123352.GA7136@mwanda>
 <57674C20.3080707@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 1183E265130
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 12:00:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57674C20.3080707@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: YHCHuang@nuvoton.com, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, broonie@kernel.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2016 at 09:51:28AM +0800, John Hsu wrote:
> Is it better to separate this function to two case, one locked with
> timeout and the other not? Do you have any suggestion about it?
> Thank you.

It should return the error code and the callers should handle it.  We
always have to know if we have the lock or not.

regards,
dan carpenter
