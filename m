Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB3C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:27:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22ABA20774
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fR4hjDA7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5llm/So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ABA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B24617D9;
	Mon,  5 Oct 2020 13:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B24617D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601897246;
	bh=wjAYzEnxCupvwO3008P6IPO8eluRFwah9be7sJikHkk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fR4hjDA7El+GmSiMXFN1myO2iQhbPNy2CK4LD8mkxRGLip0eqKzbhvd72iT4UJ4oN
	 X4UUmeznMCFmFFiOYTdy5CEsqKC3ckWqjIGb38wBg4ztsbwmItC2PxxMVRlZDF8I1Q
	 P9f76FDILCc5aKB5S+JmBkUIr4Mn3HnxoLdfm2vQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A954F8025A;
	Mon,  5 Oct 2020 13:26:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3373FF80260; Mon,  5 Oct 2020 13:26:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA9CDF800C9
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 13:26:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA9CDF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V5llm/So"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BEAB02064C;
 Mon,  5 Oct 2020 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601897185;
 bh=wjAYzEnxCupvwO3008P6IPO8eluRFwah9be7sJikHkk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V5llm/SoGIyGmL6iPKP1BW2LXs+devmeovz+lMyntS+Xy0h4OMQsnx89sTRXdrWyE
 oWcHCbAvA29RUlD4lQntmB4daDqIeW9QfOsFqQWmsm3fkahVOalgxoPozcr7bwp70w
 TX9SAQ23EIlt2EiHjHKH6rYe46gN43Vbo9MA1g4I=
Date: Mon, 5 Oct 2020 13:27:11 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Subject: Re: [PATCH 2/6] ASoC: SOF: Introduce descriptors for SOF client
Message-ID: <20201005112711.GB401816@kroah.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20200930225051.889607-3-david.m.ertman@intel.com>
 <20201001130245.GB2378679@kroah.com>
 <f3fa8df9fc8bcd789167f61b6c9d4df66b9b85c1.camel@intel.com>
 <20201002045357.GA34005@kroah.com>
 <ad38db14921dc5afb424db1ecac53053f15bb753.camel@intel.com>
 <20201003090201.GC114893@kroah.com>
 <8e0bb7b90d689f98fc2dd861b4444fda9b36bab8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0bb7b90d689f98fc2dd861b4444fda9b36bab8.camel@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "parav@nvidia.com" <parav@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "Ertman, David M" <david.m.ertman@intel.com>
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

On Mon, Oct 05, 2020 at 02:35:09AM +0000, Sridharan, Ranjani wrote:
> On Sat, 2020-10-03 at 11:02 +0200, gregkh@linuxfoundation.org wrote:
> > On Fri, Oct 02, 2020 at 05:07:13PM +0000, Sridharan, Ranjani wrote:
> > > On Fri, 2020-10-02 at 06:53 +0200, gregkh@linuxfoundation.org
> > > wrote:
> > > > On Thu, Oct 01, 2020 at 10:16:00PM +0000, Sridharan, Ranjani
> > > > wrote:
> > > > > On Thu, 2020-10-01 at 15:02 +0200, Greg KH wrote:
> > > > > > On Wed, Sep 30, 2020 at 03:50:47PM -0700, Dave Ertman wrote:
> > > > > > > From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > > > > > 
> > > > > > > A client in the SOF (Sound Open Firmware) context is a
> > > > > > > device that needs to communicate with the DSP via IPC
> > > > > > > messages. The SOF core is responsible for serializing the
> > > > > > > IPC messages to the DSP from the different clients. One
> > > > > > > example of an SOF client would be an IPC test client that
> > > > > > > floods the DSP with test IPC messages to validate if the
> > > > > > > serialization works as expected. Multi-client support will
> > > > > > > also add the ability to split the existing audio cards
> > > > > > > into multiple ones, so as to e.g. to deal with HDMI with a
> > > > > > > dedicated client instead of adding HDMI to all cards.
> > > > > > > 
> > > > > > > This patch introduces descriptors for SOF client driver
> > > > > > > and SOF client device along with APIs for registering
> > > > > > > and unregistering a SOF client driver, sending IPCs from
> > > > > > > a client device and accessing the SOF core debugfs root
> > > > > > > entry.
> > > > > > > 
> > > > > > > Along with this, add a couple of new members to struct
> > > > > > > snd_sof_dev that will be used for maintaining the list of
> > > > > > > clients.
> > > > > > > 
> > > > > > > Reviewed-by: Pierre-Louis Bossart <
> > > > > > > pierre-louis.bossart@linux.intel.com>
> > > > > > > Signed-off-by: Ranjani Sridharan <
> > > > > > > ranjani.sridharan@linux.intel.com
> > > > > > > Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> > > > > > > Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> > > > > > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > > > > > > ---
> > > > > > >  sound/soc/sof/Kconfig      |  19 ++++++
> > > > > > >  sound/soc/sof/Makefile     |   3 +
> > > > > > >  sound/soc/sof/core.c       |   2 +
> > > > > > >  sound/soc/sof/sof-client.c | 117
> > > > > > > +++++++++++++++++++++++++++++++++++++
> > > > > > >  sound/soc/sof/sof-client.h |  65 +++++++++++++++++++++
> > > > > > >  sound/soc/sof/sof-priv.h   |   6 ++
> > > > > > >  6 files changed, 212 insertions(+)
> > > > > > >  create mode 100644 sound/soc/sof/sof-client.c
> > > > > > >  create mode 100644 sound/soc/sof/sof-client.h
> > > > > > 
> > > > > > As you are creating new sysfs directories, you should have
> > > > > > some
> > > > > > documentation for them :(
> > > > > Hi Greg,
> > > > > 
> > > > > We are not adding any sysfs entries in this series. 
> > > > 
> > > > You added directories in sysfs, right?
> > > Hi Greg,
> > > 
> > > We are not adding any sysfs directories.
> > 
> > Really?  Then what does creating these new devices do in sysfs?  If
> > nothing, then why are they being used at all?  :)
> > 
> > > The only change in the /sys directory will be the new ancillary
> > > devices created in the /sys/bus/ancillary/devices directory ie
> > > snd_sof_client.ipc_test.0 and snd_sof_client.ipc_test.1.
> > 
> > That is what I was referring to.
> > 
> > > In the following patches, we're adding debugfs entries for the ipc
> > > test clients but no other sysfs changes.
> > > 
> > > Is it required to add documentation for these as well?
> > 
> > Why would you not document them?  If you don't do anything with these
> > devices, then why even use them?  debugfs does not require sysfs
> > entries, so I fail to see the need for using this api at all here...
> Hi Greg,
> 
> Pardon my ignorance here a bit. Typically, when registering platform
> devices, we've not added any documentation to highlight how they are
> used. Of course thats no excuse for not doing this right.
> 
> But just to clarify so that we can fix this properly in the next
> version, are we expected to add documentation for the directories added
> in the /sys/bus (ie /sys/bus/ancillary, /sys/bus/ancillary/devices,
> /sys/bus/ancillary/drivers etc) and also for the devices and drivers
> added by the SOF driver?

You are using a brand-new interface, which is designed to represent
things in the driver model and sysfs properly, and yet your usage
doesn't actually take advantage of the driver model or sysfs at all?

That implies to me that you are using this incorrectly.

greg k-h
