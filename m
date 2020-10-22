Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF9C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:09:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C0821531
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y3ooCAHD";
	dkim=pass (2048-bit key) header.d=kernelim-com.20150623.gappssmtp.com header.i=@kernelim-com.20150623.gappssmtp.com header.b="FYw8O83B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C0821531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelim.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B131217EB;
	Thu, 22 Oct 2020 20:08:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B131217EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603390186;
	bh=nbRfSvy+pYGZSjRaCFpItFBsZOJNHYpmquF44vYGz60=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3ooCAHDFFe3JkosKuaxKerwojf88HpL5wWamLyPiO2osxFc66Ah59vk5ikZi9ngj
	 VvaaRWScMhhxFIq3AQN1oEgWled63DLum1Nd6GN2Yk3MEZKfI932mVg8Q4jLnveUGH
	 oC1h9taXJxGgdUjOninzl1WZiR1ye8hR2Y9ar/OY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43C22F800CE;
	Thu, 22 Oct 2020 20:08:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBA0DF804A9; Thu, 22 Oct 2020 20:08:54 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F353F800CE
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 20:08:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F353F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernelim-com.20150623.gappssmtp.com
 header.i=@kernelim-com.20150623.gappssmtp.com header.b="FYw8O83B"
Received: by mail-ej1-x635.google.com with SMTP id dt13so3621238ejb.12
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernelim-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Q6gC804KOl2Mhj3UPRne+V3K0d0I7sE+DeFb51FufRo=;
 b=FYw8O83BGjh9CGsRNIwnC3cIct2W3mNw0VLJE2bMFyE+g1tza1IJPHuTprY/KQ4+vN
 /aID45aVRgIy3LWe+PLRFRO6V5GhLTy/GNmVDN108QNkxXfWlCabSmky57tUlabIAo2y
 bGOs5TsLgr3tkymb3UB/hU2Tffs96Sy/Vikk//pp4VRPXloMIjCohV0Oek/yfT8L4Ntr
 l6YSEV2CbZCywm3NXkTDZ/KikdaZzHstxR7NkOu7N6XjOVamB8nAg3Xw+1IKUfV65MTM
 5zD5tajGDaqRB8MJnf8Uxi9rfV9XiOjiEDod4LsHEMZrcNAOhX+PlOgKpKDMosPkZ7Al
 06Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q6gC804KOl2Mhj3UPRne+V3K0d0I7sE+DeFb51FufRo=;
 b=rFiDgoivDh1wm94Cv3pyhNiXEEURynxZUL71LyJN84VN0qT8lOX0in7ig2/ZX4OCFf
 6MRmKgu2SqghRgJ3JxINi5E12bhpyt8IQRHzpYU42Sw3jm2WCQ+ohtj2EllchyY9GDd/
 WV2Ewjxdiy3J91Ah//KlS886wsuU03Z0BVSTZlUBon/cY6iQMTN0lSBx2y6yfhw3MR9k
 vHRtZ6R73HMKHgY0SagJQeas/B3BkigqwkhD6UU6gZYfnq14PJu+iIWZyWQj0jQ+0pfE
 xOg79/BrO2wmc/AFREHaB2mESBA/mEMebVLCH2lt6LLXWviFVOngP0f8pqK1kbW9DbO1
 1YCQ==
X-Gm-Message-State: AOAM5324GLwxw0R7KIW2YKJODenUOpcpaI1iLJgS69MW66l1XuGu4+kb
 s43wN0Q1JByAeR6iJ8VOQeXQfA==
X-Google-Smtp-Source: ABdhPJwFj3csxzLVJzowZNlvmB7bUj7/qbkF6X1e4XwQRbTlUhGIBpwseFvhpb0THHc1ChHwDTAQRA==
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr3487859ejd.250.1603390126050; 
 Thu, 22 Oct 2020 11:08:46 -0700 (PDT)
Received: from gmail.com ([77.124.42.64])
 by smtp.gmail.com with ESMTPSA id cw15sm1247503ejb.47.2020.10.22.11.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 11:08:45 -0700 (PDT)
Date: Thu, 22 Oct 2020 21:08:42 +0300
From: Dan Aloni <dan@kernelim.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: on-board sound on ASUS TRX-40
Message-ID: <20201022180842.GA1337888@gmail.com>
References: <20201022081746.GA1118484@gmail.com> <s5hv9f2bp2c.wl-tiwai@suse.de>
 <20201022101852.GA1095612@gmail.com> <s5hmu0eblsw.wl-tiwai@suse.de>
 <20201022123347.GA1140455@gmail.com> <s5hft66bfpb.wl-tiwai@suse.de>
 <20201022125100.GB1140455@gmail.com> <s5hd01abep7.wl-tiwai@suse.de>
 <20201022154959.GC1140455@gmail.com> <s5htuum9r8z.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5htuum9r8z.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
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

On Thu, Oct 22, 2020 at 06:09:48PM +0200, Takashi Iwai wrote:
> On Thu, 22 Oct 2020 17:49:59 +0200,
> Dan Aloni wrote:
> > 
> > On Thu, Oct 22, 2020 at 02:57:56PM +0200, Takashi Iwai wrote:
> > > > > > Upon plugging or unplugging the headphone, the unitid of 11 matches the
> > > > > > unit in `trx40_mobo_connector_map`, although two events are happening -
> > > > > > two for plug and two for unplug. There's another event for '7', and
> > > > > > changing the second item of `static const struct usbmix_connector_map`
> > > > > > from 11 to 7 does not seem to affect it.
> > > > > 
> > > > > Well, then I'm afraid that it has yet another mapping of the units.
> > > > > You'd need to create the whole map from the topology, and rewrite the
> > > > > connector_map as well.
> > > > 
> > > > Would be helpful a USB trace from KVM, when running a Windows VM that
> > > > successfully manages this device following USB redirection? I can
> > > > produce this given instructions, if you have them handy.
> > > 
> > > The topology is found in lsusb -v output.  It's the connection among
> > > units.  More importantly, the maps only care about the certain units
> > > like input/output terminals and feature unit.  You can look at those
> > > and correct the corresponding unit ids.
> > 
> > It shows 6 triplelets of input terminal, feature unit, and output terminal,
> > and they are structured like this:
> > 
> >     IT[7]  -> FU[19] -> OT[13]
> >     Line-in             USB Streaming
> > 
> >     IT[8]  -> FU[20] -> OT[14]
> >     Rear Mic-In         USB Streaming
> > 
> >     IT[9]  -> FU[21] -> OT[15]
> >     Desktop Mic         USB Streaming
> > 
> >     IT[10] -> FU[22] -> OT[16]
> >     Headphone           Speaker
> > 
> >     IT[11] -> FU[23] -> OT[17]
> >     USB Streaming       Headphone
> > 
> >     IT[12] -> FU[24] -> OT[18]
> >     USB Streaming       SPDIF interface
> > 
> > Not sure how to make sense of that to a usbmix_name_map array and/or
> > usbmix_connector_map array combination that works. My trials so far
> > have not yielded a good result.
> 
> Could you show the patch you've tried?  Fitting the above into two
> tables should be straightforward.

Well I have almost zero familiarity with the code base, so it's really
not trivial to me. I still have gaps. Please explain:

- Maybe I conflated UnitId and TerminalId, when analyzing `lsusb -v`,
  are these both referring to units?
- I assume bSourceId refers to another descriptor UnitId, is that right?
- Out of the 18 possible entries in `usbmix_name_map` in this case how
  it is decided to omit certain input and output terminals? Should all
  feature units are necessarily described?
- What is the purpose of `usbmix_connector_map` array, and how to decide
  to add entries to this array? Is it done relative to `usbmix_name_map`
  omissions?
- Is there a tool that can better describe the topology based on `lsusb
  -v` output?
- Seems that `mixer_maps.c` compensates for knowledge not obtained from
  `lsusb -v`, or all of it can be obtained?

Thanks.

-- 
Dan Aloni
