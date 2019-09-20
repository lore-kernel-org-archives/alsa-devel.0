Return-Path: <SRS0=YPxo=XP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF08C49ED7
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:24:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA686208C0
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tUEr1Ska"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA686208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F4131667;
	Fri, 20 Sep 2019 13:23:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F4131667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568978668;
	bh=Cd0tMnQHmVDFp/8XCF/txgMuq1+dU7FQeaYn8v3A9Ts=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tUEr1Ska4wVHbrp0Of1Gt9CRB3NngEp+RNWYR3jaCSwlxoX85PdNKycMNmNXG5xHI
	 sQ4hHJjdN1MluCARlvQcStS5JxC4gADBqS1ZDF+KrveZ25ol7+HWbaS5onrkaynlSI
	 oxpKTNaDUyhi3Yd+6HEdjVaepgmjz1efknEAc8pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04739F804FF;
	Fri, 20 Sep 2019 13:23:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A1E4F80519; Fri, 20 Sep 2019 13:23:37 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DCCFF80096
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 13:23:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DCCFF80096
Received: from mail-ot1-f72.google.com ([209.85.210.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1iBH0f-0002aO-Eo
 for alsa-devel@alsa-project.org; Fri, 20 Sep 2019 11:23:33 +0000
Received: by mail-ot1-f72.google.com with SMTP id c26so1429841otn.2
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 04:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iV27nI8Jtkumr2nEeO8gy6V9pQ8fT+/smrbZCaOLJgg=;
 b=rDCI4/bEexcNq8wsypvM6F+a7g2Nb28sq4HaPOMreXkMBXzuZS+18SXuWvpLP3dkho
 GDegLtr4xwQPADMb2Q6p8fOJYE7qK6LBpiOTs5UxmRBMYPzxpQsQ7ghHOXXeMElZ8efD
 3/7wNzNi9VMpcGUNoqmrnoG4jnx/VT6wOlsFbq4ikI+8vGwlYGgNibJT/LFVj6L+B+7L
 LCsmg3IDfFfvC0KbzjjVqgXZw6t/JBL9WaOZm+YOX95+WJpa2SjlrmTViU/jsc91WnPl
 /7wc7HsNURsRs9bgjG2tc+vIyK/UrAdSoNU2Z8e9OZhspgUFj+WoUZAgfBM+m3YXwArH
 08Kw==
X-Gm-Message-State: APjAAAVuG8OSHzq6THKP/KWmFDokBgpvtKsMrSaTYpHxhZoRpraGSGG4
 MkIyJGFirjlVI+iTYZloMpxa9BqxVpGPqQlvhbcg9H0NTfkbikc56Prh5q4wrlCf2ZepfvrYyhm
 u6Bh2rizMFSsgCSQAFX5q4DyKvZL5RbcE8Jzq0MG6x9WnvWbyB1bo99D2
X-Received: by 2002:aca:d9c3:: with SMTP id q186mr2385462oig.53.1568978612396; 
 Fri, 20 Sep 2019 04:23:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGE0CXP73wztiKAwRdZskwBr2gJgJJW4tcjb56ypIA/roYner5Ad1WU7kgluJgxuZoVUwvadLKzGua+CFsLXU=
X-Received: by 2002:aca:d9c3:: with SMTP id q186mr2385434oig.53.1568978612029; 
 Fri, 20 Sep 2019 04:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190909114129.GT103977@google.com>
In-Reply-To: <20190909114129.GT103977@google.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 20 Sep 2019 13:23:20 +0200
Message-ID: <CAAd53p4mc0tgCBiwfZRowr4os_bqDP+7Ko=d+do8OW2aH1Whzg@mail.gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/2] PCI: Add a helper to check Power
 Resource Requirements _PR3 existence
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Bjorn,

I didn't find your reply in my mailbox earlier.

On Mon, Sep 9, 2019 at 1:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Maybe:
>
>   PCI: Add pci_pr3_present() to check for Power Resources for D3hot

Ok, this is a good title.

>
> On Tue, Aug 27, 2019 at 09:47:55PM +0800, Kai-Heng Feng wrote:
> > A driver may want to know the existence of _PR3, to choose different
> > runtime suspend behavior. A user will be add in next patch.
>
> Maybe include something like this in the commit lot?
>
>   Add pci_pr3_present() to check whether the platform supplies _PR3 to
>   tell us which power resources the device depends on when in D3hot.

Ok.

>
> > This is mostly the same as nouveau_pr3_present().
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pci.c   | 20 ++++++++++++++++++++
> >  include/linux/pci.h |  2 ++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 1b27b5af3d55..776af15b92c2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5856,6 +5856,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
> >       return 0;
> >  }
> >
> > +bool pci_pr3_present(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > +     struct acpi_device *parent_adev;
> > +
> > +     if (acpi_disabled)
> > +             return false;
> > +
> > +     if (!parent_pdev)
> > +             return false;
> > +
> > +     parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> > +     if (!parent_adev)
> > +             return false;
> > +
> > +     return parent_adev->power.flags.power_resources &&
> > +             acpi_has_method(parent_adev->handle, "_PR3");
>
> I think this is generally OK, but it doesn't actually check whether
> *pdev* has a _PR3; it checks whether pdev's *parent* does.  So does
> that mean this is dependent on the GPU topology, i.e., does it assume
> that there is an upstream bridge and that power for everything under
> that bridge can be managed together?

Yes, the power resource is managed by its upstream port.

>
> I'm wondering whether the "parent_pdev = pci_upstream_bridge()" part
> should be in the caller rather than in pci_pr3_present()?

This will make the function more align to its name, but needs more
work from caller side.
How about rename the function to pci_upstream_pr3_present()?

>
> I can't connect any of the dots from _PR3 through to
> "need_eld_notify_link" (whatever "eld" is :)) and the uses of
> hda_intel.need_eld_notify_link (and needs_eld_notify_link()).
>
> But that's beyond the scope of *this* patch and it makes sense that
> you do want to discover the _PR3 existence, so I'm fine with this once
> we figure out the pdev vs parent question.

Thanks for your review.

Kai-Heng

>
> > +}
> > +EXPORT_SYMBOL_GPL(pci_pr3_present);
> > +
> >  /**
> >   * pci_add_dma_alias - Add a DMA devfn alias for a device
> >   * @dev: the PCI device for which alias is added
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 82e4cd1b7ac3..9b6f7b67fac9 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2348,9 +2348,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
> >
> >  void
> >  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
> > +bool pci_pr3_present(struct pci_dev *pdev);
> >  #else
> >  static inline struct irq_domain *
> >  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> > +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
> >  #endif
> >
> >  #ifdef CONFIG_EEH
> > --
> > 2.17.1
> >
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
