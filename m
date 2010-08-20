From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/3] asoc/multi-component: add support for
	the Freescale P1022 DS reference board
Date: Fri, 20 Aug 2010 07:45:49 -0500
Message-ID: <91F4F361-3F6A-4D4A-A754-EE571C8FC7E0@freescale.com>
References: <1282255900-20515-1-git-send-email-timur@freescale.com>
	<20100820111414.GJ13668@rakim.wolfsonmicro.main>
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 77E1810381A
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 14:44:27 +0200 (CEST)
Received: from mail97-tx2 (localhost.localdomain [127.0.0.1])	by
	mail97-tx2-R.bigfish.com (Postfix) with ESMTP id 9AE1F5C8262	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 12:44:24 +0000 (UTC)
Received: from TX2EHSMHS009.bigfish.com (unknown [10.9.14.235])	by
	mail97-tx2.bigfish.com (Postfix) with ESMTP id 7574819C004F	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 12:44:24 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o7KCiN7A013919	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 05:44:23 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o7KCwd0w007069	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 07:58:39 -0500 (CDT)
In-Reply-To: <20100820111414.GJ13668@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Aug 20, 2010, at 6:14 AM, "Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> +static struct device_node *get_node_by_phandle_name(struct device_node *np,
>> +	const char *name, const char *compatible)
>> +{
> 
> This and a few of the other functions look like they ought to be moved
> somewhere more generic - they don't look specific to this driver at all.

I'm planning on doing that, but I can't be sure that they'll be accepted as generic functions, so I put them here first.
> 
