Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BA8C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:14:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A25520A8B
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NW5d4VJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A25520A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 389BC1725;
	Tue, 17 Nov 2020 23:13:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 389BC1725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605651261;
	bh=Jr3Zqi+PoTd+EIM1nRUTbZgtIUT1Im7mc4jDEVVaRr8=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NW5d4VJ9StcMjtREYCHdF4blTMcrMcv02qh/0uPpImP0W8Y2z7vkpQcDUpfPCFQ2D
	 tv8SfP+POg1VOqNxZTc4I7+bW2WwqyMJ+eIEzkAtrr5Iwl3eZnfj4Bf908aTn2Wwp9
	 AhPtU6nt+bQBqhJV2cn1LSt/7anULpPptfwMTpRU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4BF2F801ED;
	Tue, 17 Nov 2020 23:13:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE185F801F5; Tue, 17 Nov 2020 23:13:28 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1FCDF800E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 23:13:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1FCDF800E2
IronPort-SDR: 7oVowNyhN/W77a3ozv+x2IhM9ssEULEZOgMj1k12prOtE9aFeIj7a+/0dwEHl2eIi8pvyB83E2
 Juj6sLy7bKHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="232637022"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="232637022"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 14:13:15 -0800
IronPort-SDR: wK9WlU/dhd75lwf24juvR4Tdg1cfRvKHh4IzZ9okj9Ly5jgz+YwfrFcuKblfFM9ZFAFtZwHydx
 U2mBGMTWWwpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="544230314"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
 by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 14:13:14 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 22:13:13 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Tue, 17 Nov 2020 22:13:13 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Thread-Topic: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Thread-Index: AQHWuUTISKj33SVxVku5O7g0f1ygmanF+0XggABMLQCAAASUgIAEnFAQgAAmMgCAAVQSgIAAh8aQ
Date: Tue, 17 Nov 2020 22:13:13 +0000
Message-ID: <0286c6975f24432082f609d45adaa14c@intel.com>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <0a0854d1ddaf4f9b81ef5569a7d501a5@intel.com>
 <20201113164946.GD4828@sirena.org.uk>
 <2cf7075b-bd51-21a5-2058-3a98e6c488a7@redhat.com>
 <d462c890495e4dda8698b5ba5eb50066@intel.com>
 <f62abcd8-b67f-774b-61b5-e08cfc3d2cc7@linux.intel.com>
 <s5h1rgst6z4.wl-tiwai@suse.de>
In-Reply-To: <s5h1rgst6z4.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: Hans de Goede <hdegoede@redhat.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
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

On 2020-11-17 3:04 PM, Takashi Iwai wrote:
> On Mon, 16 Nov 2020 18:47:22 +0100,
> Pierre-Louis Bossart wrote:
>>
>>> Explicit 'ifs' asking whether we're dealing with SOF or other solution
>>> is at best a code smell. I believe this is unnecessary complexity added
>>> to the code especially once you realize user needs to play with module
>>> parameters to switch between solutions. If we assume user is able to
>>> play with module parameters then why not simply make use of blacklist
>>> mechanism?
>>
>> Been there, done that. We don't want to use either denylist of kernel
>> parameters.
>>
>> denylists create confusion for users, it's an endless stream of false
>> errors and time lost in bug reports.
>>
>> The use of the kernel parameter is ONLY for expert users who want to
>> tinker with the system or debug issues, the average user should not
>> have to play with either denylists or kernel parameters.
>=20
> I guess Cezary mean the modprobe blacklist?  This was used in the
> early stage of ASoC Skylake driver development, but in the end, it's
> more cumbersome because user needs to change multiple places.  The
> single module parameter was easier to handle.
>=20

Thanks for joining the discussion, Takashi.

If the switch of solution for atom-based products is imminent, why add
code which becomes redundant soon after?

Yes, indeed I meant the modprobe blacklisting as it solves the problem
without addition of any code. Doubt alsa-driver entries are scattered in
/etc/modprobe.d/ so switching between one solution to another via
blacklist becomes as easy as changing 'options intel-dsp-config
<param>=3D=3D<value>' entry.

In regard to catpt, solution is even simpler: just remove
sound/soc/sof/intel/bdw.c as that code is not valid & recommended
anyway and linux kernel is not place for such. There shouldn't be really
any options for not recommended stuff. Leave the selection explicit.

>>> And last but not least: intel-dsp-config is (as already stated) a mean
>>> for solving the HDA-runtime-driver-selection problem. Mixing it with
>>> ACPI devices is another layer of confusion.
>>
>> Why? Who said it was PCI only? We already take care of DMIC,
>> SoundWire, Google Chromebooks, open platforms, why not ACPI? It's just
>> one API to be used when more than one driver can register to the same
>> device.
>=20
> Well, currently intel-dsp-config sits in sound/hda, which isn't really
> intuitive.  Though, Intel driver file paths are already fairly
> scattered, so it doesn't matter too much :)
>=20
> I don't mind to move it to another directory, but which one...?
> x86 might match, but shuffling the place won't help for maintenance.
>=20
> I personally find this move good, at least it makes things easier for
> distros.  There are small details like the above, but technically
> seen, I see no big problem.

Well, if non-Intel guys see the localization of code counter-intuitive
then how about those who play with it daily..
The new "sof-parent" checks won't make maintaining any easier and I
believe there are easier solutions as written above.

Czarek

