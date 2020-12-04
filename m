Return-Path: <SRS0=L/cl=FI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC72C433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 16:27:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B8F22B3B
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 16:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B8F22B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CD201879;
	Fri,  4 Dec 2020 17:26:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CD201879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607099228;
	bh=MHHKkmoKjWu0cQa0MJSAx0XzbIRrcNJEsWUXYjQipb8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aCZfKVDTLorP0C3NrmB+nB63m0Vqq/hYF0vuWsoJgRNnQwdBsGAwaiIrmbhsymY2M
	 vcUovxvVOooQtJfX9b8ZZ9HIXil23AEEI3cIzXpK2V6r/9P4hFdlUc01kumTmyxv73
	 s1e745o+sGA6XR2My/C9AmODP8jRoabnE8Ql67Dc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCC50F800E2;
	Fri,  4 Dec 2020 17:26:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 179F4F80278; Fri,  4 Dec 2020 17:26:16 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38C08F800E2
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 17:26:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38C08F800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MLvlA35H"
Date: Fri, 4 Dec 2020 08:25:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607099160;
 bh=MHHKkmoKjWu0cQa0MJSAx0XzbIRrcNJEsWUXYjQipb8=;
 h=From:To:Cc:Subject:In-Reply-To:References:From;
 b=MLvlA35HN4ohV3iZow6D9YHeAHxFSJ3uPa6MbZFLdDwWj7Zyr58H/PSnExYJOqODJ
 EfJWAWip59iY29pTqqNIqPGFXN10Iia11P11c9xb/Ln6SHa9G+Slpdy60vJ2bligCR
 LW7Jh9uEV4sjc0I6m+IJY8uYG4cCeDZrLDhRVK65CeT/lLo3Yq3WouzIdZ25VmIhpK
 63d75Jb50lFlvPYXyXAfZ2Wdgh9YuYPRZM7gr+at0ocFyndIuSyVe6yz+X4ABBG3y7
 gJ+Z27Ur7XalOsKughxN9oyVa4LJLeGZdNlTKCS33IZ1vWueF3VN+GCIir5zUDkw9I
 j6zMFjspjvd3w==
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <20201204082558.4eb8c8c2@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201204125455.GI16543@unreal>
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
 <X8os+X515fxeqefg@kroah.com> <20201204125455.GI16543@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
 linux-rdma@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 Martin Habets <mhabets@solarflare.com>, lgirdwood@gmail.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org, jgg@nvidia.com,
 netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, davem@davemloft.net,
 linux-kernel@vger.kernel.org, Parav Pandit <parav@mellanox.com>
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

On Fri, 4 Dec 2020 14:54:55 +0200 Leon Romanovsky wrote:
> Thanks, pulled to mlx5-next
> 
> Jason, Jakob,
> 
> Can you please pull that mlx5-next branch to your trees?
> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git

Could you post a PR with a proper description and so on?

Thanks!
