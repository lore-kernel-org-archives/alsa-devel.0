From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need help with WM8960
Date: Tue, 18 Sep 2012 22:59:02 -0400
Message-ID: <20120919025902.GM8832@opensource.wolfsonmicro.com>
References: <5051160C.2010802@freescale.com>
 <20120913024245.GA4467@opensource.wolfsonmicro.com>
 <5051F0F4.5090205@freescale.com> <5051FF73.2030504@freescale.com>
 <505209D6.2080206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E153826514A
 for <Alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:59:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <505209D6.2080206@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 11:29:10AM -0500, Timur Tabi wrote:

> I just noticed that pdata->dres isn't actually used in the driver.  In

This was used in the original version of the driver when entering
standby from off but we stopped using it when we switched from having a
single startup sequence to having separate cap and capless sequences so
it's redundant now and could be removed.
