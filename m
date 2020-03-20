Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B825C4332B
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:56:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0112072D
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n8MCrw8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0112072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9B11886;
	Mon, 23 Mar 2020 14:55:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9B11886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584971767;
	bh=gjqhe5NDYWnd2SltHD55lQgF7NVCa2rNTAbhEe38jEc=;
	h=From:To:Subject:In-Reply-To:References:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n8MCrw8kfmpNb4Ktq0oXxp/Shn4NL31s9OOxgdxPfrHICC0K4r1e1/2TQDZHz0Odt
	 4XfByqmTZ/4roFR/X01WoC/juZn6vAm4/sQNqlJ9zboPLOKAJ/Z9takKOZHpnPxaO8
	 A7AvADp2ZCtFoKhIZMwmJMzXFSDaZV4OBQXTnEe4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D41E5F802FB;
	Mon, 23 Mar 2020 14:47:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCA15F8015B; Fri, 20 Mar 2020 21:32:32 +0100 (CET)
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33286F800C0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 21:32:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33286F800C0
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jFOJf-0003W5-B3; Fri, 20 Mar 2020 21:32:27 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id A95431039FC; Fri, 20 Mar 2020 21:32:26 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [patch 08/22] ACPI: Convert to new X86 CPU match macros
In-Reply-To: <CAHp75VcK3tL0YayjF=CSkSkHiOpg2zOV3rdkXQWJmLZ9fmevpg@mail.gmail.com>
References: <20200320131345.635023594@linutronix.de>
 <20200320131509.467730627@linutronix.de>
 <CAHp75VcK3tL0YayjF=CSkSkHiOpg2zOV3rdkXQWJmLZ9fmevpg@mail.gmail.com>
Date: Fri, 20 Mar 2020 21:32:26 +0100
Message-ID: <87bloqpy1x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-Mailman-Approved-At: Mon, 23 Mar 2020 14:47:38 +0100
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "maintainer:X86 ARCHITECTURE
 \(32-BIT AND 64-BIT\)" <x86@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>,
 Mark Gross <mgross@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Linux PM <linux-pm@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Iwai <tiwai@suse.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 linux-crypto <linux-crypto@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andy Shevchenko <andy@infradead.org>
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

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Fri, Mar 20, 2020 at 3:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> The new macro set has a consistent namespace and uses C99 initializers
>> instead of the grufty C89 ones.
>>
>> Rename the local macro wrapper to X86_MATCH for consistency. It stays for
>> readability sake.
>
>> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     NULL),
>> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        NULL),
>
>> -#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
>> +#define X86_MATCH(model)       X86_MATCH_INTEL_FAM6_MODEL(model, NULL)
>
> Maybe we can do a generic macro to avoid all these ', NULL' repetitions?

I opted for having the data argument everywhere to keep the macro maze
small. And we have enough places where data is actually used.

Thanks,

        tglx
