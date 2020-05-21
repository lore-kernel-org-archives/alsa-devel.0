Return-Path: <SRS0=YV0t=7H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8C1C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 09:27:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24352071A
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 09:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dKKMKkYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24352071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 932B4165D;
	Mon, 25 May 2020 11:26:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 932B4165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590398819;
	bh=pJJV9kNf6aeWKze5YyYkTmezPyIEzMsN210lrHSgqXY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dKKMKkYZX1DnJzYWVuMO3hqgywHHnvfOHEsfFc4O5PmhinJpRQVa5T6rSu+v4m2qq
	 unos4FERPusNCBuLcKXPAuBILtqdjmuSxwExu/78yI+9YOIMyoatTjxYhvNenOnGlP
	 8kzc5BdAKtijS2rraTh1zAgibQZKM/h9Z0XTyPhY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E1BDF8021E;
	Mon, 25 May 2020 11:25:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A341F801D8; Thu, 21 May 2020 12:38:39 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B605F800E1
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2020 12:38:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B605F800E1
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49SR102ZPLz9v0p5;
 Thu, 21 May 2020 12:38:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id w7Io9G7iWYwQ; Thu, 21 May 2020 12:38:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49SR101Nj3z9v0DQ;
 Thu, 21 May 2020 12:38:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B51A38B786;
 Thu, 21 May 2020 12:38:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id H7PeBhUHP4Cr; Thu, 21 May 2020 12:38:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AF188B778;
 Thu, 21 May 2020 12:38:26 +0200 (CEST)
Subject: Re: [PATCH 0/2] powerpc: Remove support for ppc405/440 Xilinx
 platforms
To: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>
References: <cover.1585311091.git.michal.simek@xilinx.com>
 <CAK8P3a2mKPRFbRE3MWScr9GSiL4cpLg0wqv1Q28XDCZVPWgHfg@mail.gmail.com>
 <20200327131026.GT1922688@smile.fi.intel.com>
 <20200327131531.GU1922688@smile.fi.intel.com>
 <CAK8P3a1Z+ZPTDzgAjdz0a7d85R62BhUqkdEWgrwXh-OnYe6rog@mail.gmail.com>
 <20200327141434.GA1922688@smile.fi.intel.com>
 <b5adcc7a-9d10-d75f-50e3-9c150a7b4989@c-s.fr>
 <87mu7xum41.fsf@mpe.ellerman.id.au>
 <bac9af641140cf6df04e3532589a11c2f3bccd2f.camel@kernel.crashing.org>
 <87pncprwp9.fsf@mpe.ellerman.id.au>
 <5782f9a42ad8acd8b234fa9c15a09db93552dc6b.camel@kernel.crashing.org>
 <871roykwu6.fsf@mpe.ellerman.id.au>
 <CAK8P3a1XmeeP7FKfNwXZO8cXyJ_U_Jr0kjOaGZ6F=7OcoZ+0nw@mail.gmail.com>
 <87zha17otl.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <33b873a8-ded2-4866-fb70-c336fb325923@csgroup.eu>
Date: Thu, 21 May 2020 12:38:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87zha17otl.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2020 11:25:08 +0200
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Sasha Levin <sashal@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 YueHaibing <yuehaibing@huawei.com>, Michal Simek <michal.simek@xilinx.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 Matt Porter <mporter@kernel.crashing.org>, DTML <devicetree@vger.kernel.org>,
 Andrew Donnellan <ajd@linux.ibm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>,
 Mark Brown <broonie@kernel.org>, git@xilinx.com,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Allison Randal <allison@lohutok.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Michal Simek <monstr@monstr.eu>,
 Wei Hu <weh@microsoft.com>, Christian Lamparter <chunkeey@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Armijn Hemel <armijn@tjaldur.nl>, Rob Herring <robh+dt@kernel.org>,
 Enrico Weigelt <info@metux.net>, "David S. Miller" <davem@davemloft.net>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



Le 21/05/2020 à 09:02, Michael Ellerman a écrit :
> Arnd Bergmann <arnd@arndb.de> writes:
>> +On Wed, Apr 8, 2020 at 2:04 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>>> On Fri, 2020-04-03 at 15:59 +1100, Michael Ellerman wrote:
>>>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>>> IBM still put 40x cores inside POWER chips no ?
>>>
>>> Oh yeah that's true. I guess most folks don't know that, or that they
>>> run RHEL on them.
>>
>> Is there a reason for not having those dts files in mainline then?
>> If nothing else, it would document what machines are still being
>> used with future kernels.
> 
> Sorry that part was a joke :D  Those chips don't run Linux.
> 

Nice to know :)

What's the plan then, do we still want to keep 40x in the kernel ?

If yes, is it ok to drop the oldies anyway as done in my series 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=172630 ?

(Note that this series will conflict with my series on hugepages on 8xx 
due to the PTE_ATOMIC_UPDATES stuff. I can rebase the 40x modernisation 
series on top of the 8xx hugepages series if it is worth it)

Christophe
