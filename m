Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B444C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:50:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B128C2078C
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QseRhGys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B128C2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50776169B;
	Tue,  9 Jun 2020 13:50:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50776169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591703451;
	bh=TR7BWkHZPKTqWbzOGU3jKxr3Mt5VPTsUorZndo5CcAk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QseRhGysyGgmpNPQUytjzwAY/U3VGueHr9WXd8iCLdqV6eAcxnHhwR9LC+f932zTw
	 N1cbQ7pTfO3bKqkBoubkGp+fmThBT+6gsBs+lu3mJVmWh1MEOXYtOpt0jJyOwYGzK6
	 egn35pvoAvtS/m2wgO1+jg0oCK5Z30jsNqX2enFo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDC6EF80124;
	Tue,  9 Jun 2020 13:50:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEA09F8028C; Tue,  9 Jun 2020 13:49:58 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3032F80124
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 13:49:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3032F80124
Received: by verein.lst.de (Postfix, from userid 2407)
 id 40B2D68AFE; Tue,  9 Jun 2020 13:49:55 +0200 (CEST)
Date: Tue, 9 Jun 2020 13:49:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
Message-ID: <20200609114955.GA2027@lst.de>
References: <20200609054306.GA9606@lst.de> <s5hsgf4irzt.wl-tiwai@suse.de>
 <20200609084305.GA21671@lst.de> <s5hlfkwip1h.wl-tiwai@suse.de>
 <20200609091727.GA23814@lst.de> <s5hh7vkio0n.wl-tiwai@suse.de>
 <20200609113123.GA547@lst.de> <s5h3674ii49.wl-tiwai@suse.de>
 <20200609114059.GA1228@lst.de> <s5hzh9ch38h.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzh9ch38h.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, x86@kernel.org, hpa@zytor.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>,
 hch@infradead.org, mingo@redhat.com, bp@alien8.de, Pavel Machek <pavel@ucw.cz>,
 David Rientjes <rientjes@google.com>, tglx@linutronix.de,
 Christoph Hellwig <hch@lst.de>
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

On Tue, Jun 09, 2020 at 01:45:34PM +0200, Takashi Iwai wrote:
> Yes, for the sound stuff, something below should make things working.
> But it means that we'll lose the SG-buffer allocation and the
> allocation of large buffers might fail on some machines.

We crossed lines there.  In general due to better memory compaction and
CMA we have better chances to get larger contiguous allocations these
days, so this might not be too much of an issue in practice.
