From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 1/2] ASoC: Add CS4271 codec support
Date: Fri, 08 Oct 2010 10:59:31 +1300
Message-ID: <4CAE42C3.4070204@bluewatersys.com>
References: <4CAD16A5.1090501@bluewatersys.com>
	<4CAE3FAC.6010508@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CF7A24402
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 23:59:01 +0200 (CEST)
In-Reply-To: <4CAE3FAC.6010508@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander <subaparts@yandex.ru>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 10/08/2010 10:46 AM, Timur Tabi wrote:
> Ryan Mallon wrote:
>> + * For setups with variable MCLKs, pass 0 as 'freq' argument. This will cause
>> + * theoretically possible sample rates to be enabled. Call it again with a
>> + * proper value set one the external clock is set (most probably you would do
>> + * that from a machine's driver 'hw_param' hook.
> 
> If you're going to copy/paste parts of my driver verbatim into yours, you should
> put something like this in the comments:
> 
> 	Based on the CS4270 driver by Timur Tabi <timur@freescale.com>
> 

Thanks. CC'ed Alexander, the driver author, who I stupidly left of the
reply list.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
