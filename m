Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E7FC5DF9C
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:02:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7237602A3;
	Mon, 24 Aug 2026 20:02:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7237602A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787594567;
	bh=b1ICaw58VK9nC40S3Rnx119D/N/7WS8E1ehXYJmQLqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YhLiKKBBWPDHWNYDHoBgWwIeiaB/aoJGHwNsbMLAQyk0XrUY+OG0bwN1WDJArpJvB
	 TCW3mlfdelKDkZXgqxvgihIMlmadP7OaoeadZumkAhY0fEnVv+HVRhdeopDX/vwhqR
	 y/yuEtuev8MD/UHnNwq42asJk54JFYLZ3nIEqAoc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76D77F805FC; Mon, 24 Aug 2026 20:02:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DE0BF805FF;
	Mon, 24 Aug 2026 20:02:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5DE1F805A8; Mon, 24 Aug 2026 20:02:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787594524;
	b=RVfppTS5loTDegl0KxxS7AXnURtGJmIrxy3JZoYRBCBZiqRVLNc85VqtgTmojmJbZmzW
	 0YiWZTvNYv1fcTmfhvYQLxIITAbmGUHuAzut9bJQYpVwWwtEQb0V5crMrbClW3m+ll1dB
	 +AznSuHBj8Yfmd2KIl++eXjklV1IfTvLJeYxhG9BbsmE4IyvNOATNH11zQgSTcmwM4sZa
	 /9Vvqwl93wIDrhmhqtKn2h4F3B+Bx9QrXpizDsqmeRJrfdGvsl44tkzUzRBJUqMfNrEvF
	 QmuLPSFAZ5M94NWCWREQZozH2Kie8+cckKYcVyumOYQ679aHQL/ZexDjDGy3F8th6Gg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787594524;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=b1ICaw58VK9nC40S3Rnx119D/N/7WS8E1ehXYJmQLqc=;
	b=Ygre6mN3XQRbCVrYt8c2ypmiFZ3pVY1V++T74CwWdNU3HESjs1S0hqarmkyGQ+unl3sZ
	 nWNWlsNUz1uATevnOlWfAgrSdfqVEi2nMEr8uZNqBPQuo4MUPRcL4a2em9+prJFnxeh/K
	 GfnwG4Zi5tzx8db4i+IZKpBR8qZfSMDp2gorrOV6ovQ1edawqWdYCHL9/6iemEUQ92DXV
	 TmKih7Qm1UeC9S+KDoXgpaZQAsgf6i5Am8gFO99JtCmJXtKUzYxA+aZBy52H6K0EE9ATQ
	 cdA9Ve4Htj/osF81k5yzzM1iIgzgfDyPcRsCkWKS6XO3T0ft52ov6G44eE65mX/86lA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gEFAffaY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0646BF80075
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 20:02:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0646BF80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gEFAffaY
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7f42ef0b693so2540926a34.2
        for <alsa-devel@alsa-project.org>;
 Mon, 24 Aug 2026 11:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787594521; cv=none;
        d=google.com; s=arc-20260327;
        b=K6QPifGpeskKJL1dt9AlzTCxw/yROmI9T2RoDaUv56k16rK/kI45Wg5QXHgHPPfAqW
         R3n6JzXFrx6gXFg/Qyqj/YodGysLUIVxnxgsVisksWm9Gfh+tfUBn6MNLpxQBUEdChLw
         3ZslC93k0Kh96VNjH2Yqath7e2hkGT7g7Yc0qfMoyb6r16IWB1iQunszzUwq473edOy6
         w2bPqtLdzejQyqSaJqLX8jZtDLf8U3SdzLGR40KndVSu5G2TOP2LQgumBAoTfT+WM7dj
         zaD6SegKaE7rZNtIOsZ/JQHuwDAnPX7SmP14nkT/S0stWWMM94T1KnUTMlfJAFqsKgXP
         jx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aec6PFmwjcVtBVb7qV+fwlfid5BWmwQ0jfYGb+9bMFw=;
        fh=KoInqMEZriL8X0m4mrJMSMyMy6ZH5jAZXSwsP5xkdlE=;
        b=g0zIlbbHrsOsfWG2q+MuKfjVYMdU9eOFGlbZcAdWiq65KvITRop7kmGAi9seyfOK38
         cbiR+MhMyT6UhiEV+j00d+nD9WVZowAC1QYkvotMHgewpYL0x2gATJGtsYT4vP8czDyH
         1bgodevppoyxjpS7aV19OiozwHIEj22C6a+Hh6xFlqJS/zF337NqjDYEdaSTAKtkXSZb
         yeJUJ8ev9UIHWAASt+32OB+yusJ7hz5C8uQWxgBuTbS0xCOKea3kaS8cDgeE6JSn0hhx
         7mN5Pb1hCPGsyuFITOS6UebvMPtsoA+/sAkiL1ewhP2GtyOzC+lU7JWMZoARSrAaGeHE
         lJLg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787594521; x=1788199321;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aec6PFmwjcVtBVb7qV+fwlfid5BWmwQ0jfYGb+9bMFw=;
        b=gEFAffaYQbrZ6jN1UGs9PjhJl6rlSlKK3KppFdhSMFk2X6ztMEUge7HJNFxXDlas81
         uI0beeFLl7jb1n9eNnUXB3cp/iJsjfZymICXScaiF/AkMmdNknR9UtF3GwkpeSiY89tR
         4amIcuJkfnnjkeQSijtmHYR/obIkp+XT20prSFH5jrk/zQSNNEaUJ7IXMUXYtIp0N/0t
         jhmGueB3CCf+Q8TUNSl6gNLADRAuR/eH6CrhImbZZ2mwJFYJuCWUe0VrxwybIC+IqesW
         ymAq5qMiO2SpxLJHiOf1vAW+YrB9IF7byHml9N3mJHwDCZqgTIiYkX9u3zkatIxlQphR
         k1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787594521; x=1788199321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aec6PFmwjcVtBVb7qV+fwlfid5BWmwQ0jfYGb+9bMFw=;
        b=nFMCTWERXF4m/q7jsOCmrOzY1H9//tSwcZSULio2MnnuwufCNsWRbyOItyycNPQzCn
         Wxuo0AyOldvgdAcIWCUmHkeBiiZ6GwaILLyFV/slRNA153sRUyU+EAMm/A4NMLWP0lQ3
         hi33UzuLuObvxHEma8kUNE79kiA9mKJYegQ9MaHUD+peh8pZP8ZXRyrfFSWJ9RVozV1y
         c4FunSrm49caWD1rzPADRJix+7SvkibxNJxcHML7O/HwGlzTDkPTpRs+HLYDyfHMFvIN
         S/j1eLpPTIwEjWvJsyGJyJXyTOSr0gmeOtxx1OKUopeJO4cbBQ8VtNfJEzh++fFkg3g3
         w9qw==
X-Gm-Message-State: AFuF++nqrDnAkQtnjfFkq9AQ5ynBv8WJPj5U7+b0zML1sCR6poMFblA/
	jW2unmp99F5zv41ZQt+Kk8u9GezQDJR5zydH6oatRr543JCF3SiexNRYYippGaMR4mAMcG8tFXz
	yMcPqLIF8p0AjRMcKBR9Jfy5dLFLGlO4=
X-Gm-Gg: AR+sD10C4ke+3u6kU7EwCRly2+Fz7nSvIeCO8RuubmHuMZgQS14DancHhYhkXlCEM2V
	sE9f2N+DMpVzkQagypYl3eje6gKK89+94LHtSLi8emmZOLlDzd8ppzxehr+VWaiYNkD0ywO3mz0
	+IUTlazco1NYGfk1LLkzRfqNMeDKPMqig6l9zYj3W3jff/+BXuEyFzBHR9aG8ZCbK1E5Jqfb+yC
	tdKyeyGim2HEV34zXw/vtpyd7huEgWYeyx4HqS3dkRDzqZW70LbaZx5CrUjMRgJ5Vcxq6hIGx0d
	fc706lSpX1jZCFywFhOqe4Y46Bf3POOOJN9OMlNkFUxrlzG22ALlQ+WHdFH/7jTzScyanoCO7sZ
	HKRdaRmOZGI6fcZnGlsuiWCv7N14TBzyF
X-Received: by 2002:a05:6830:4991:b0:7ee:37dc:59e1 with SMTP id
 46e09a7af769-7f4765d775emr21370237a34.16.1787594520467; Mon, 24 Aug 2026
 11:02:00 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CABXGCsPVLke4_j-FfGqTMN4tG88G5ckf13_xxKRe=j_w+sWTvQ@mail.gmail.com>
 <dc49d18f-4bc4-4d3a-9405-a43cad044e6c@perex.cz>
In-Reply-To: <dc49d18f-4bc4-4d3a-9405-a43cad044e6c@perex.cz>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 24 Aug 2026 23:01:48 +0500
X-Gm-Features: AcwNN1Wbkn5Qd9MdwWWCp_eRq-sy5VSgyUJ-jquu8pn2iuEb6Xa4KlOUhvAvlfM
Message-ID: 
 <CABXGCsO-9rpw=G1MiMOKyD9UZ6Wxh7tmSdRz3njaMR=AFMyKYQ@mail.gmail.com>
Subject: Re: UCM: two devices that exclude a third but not each other
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: GSS3EK2YL5JOECCEDI7R7TFF4BK3GU6I
X-Message-ID-Hash: GSS3EK2YL5JOECCEDI7R7TFF4BK3GU6I
X-MailFrom: mikhail.v.gavrilov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GSS3EK2YL5JOECCEDI7R7TFF4BK3GU6I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Aug 24, 2026 at 4:37=E2=80=AFPM Jaroslav Kysela <perex@perex.cz> wr=
ote:
>
> You can define multiple verbs one with stereo input and second with two m=
ono
> inputs (mics) - the most easy way is to use Variant blocks to not duplica=
te
> configurations.
>
> But it may make sense to describe this partial dependency directly with n=
ew
> list in the device configuration block (proposal). I am not sure if it wi=
ll
> work for the current pipewire code - could you check to comment
> verb_dev_list_check() function in alsa-lib and test ?
>
> Also note that your device naming does not follow UCM spec - see usecase.=
h
> header file [1]. E.g. generic inputs should be named as line. Labels on t=
he
> card should be in comments (for GUI).
>

I tried it. With the second pass of verb_dev_list_check() removed and
nothing else changed, PipeWire gives exactly the two configurations the
card should have:

    Default (Aux, BT, In12, LB12, LB34, LB56, LB78, Line1..Line5, OTG)
    Default (Aux, BT, In1, In2, LB12, LB34, LB56, LB78, Line1..Line5, OTG)

instead of the three it gives today, where each configuration offers
only one microphone. So the current ACP code copes with a partial
relation without any change on its side.

What I removed, for clarity -- only the second pass, the first stays:

static int verb_dev_list_check(struct use_case_verb *verb)
{
/* First pass: ensure bidirectional relationships */
...unchanged...

/* Second pass: complete other relationships for devices
* in group -- removed for this test.
*/
return 0;
}

Nothing else was touched: no changes to parse_device_list(), to
verb_dev_list_add(), or anywhere on the ACP side. I can send the diff
if it is useful.

One caveat about the tooling rather than the code, in case anyone
repeats this: alsaucm prints these lists in pairs, so a list holding a
single entry prints nothing at all and looks like a failure. It cost me
a while before I checked against a device whose list has two entries.

I will try the multiple-verbs form as well, since that is what the
profile can ship today, and it may turn out that a partial list is not
worth a format change if the verb form covers the same ground. If you
would still like the list, I am happy to write it.

And thank you for the naming correction. The card labels will move into
Comment and the devices will be renamed per the spec. Two of them have
no obvious name there and I would rather ask than guess: the card has a
USB-C port carrying audio to and from a phone, which the vendor calls
OTG, and eight loopback return channels that carry the card's own
mixes back to the host. Line with an index for both?

--=20
Thanks,
Mikhail Gavrilov.
