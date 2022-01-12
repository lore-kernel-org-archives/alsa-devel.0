Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E149C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jan 2022 20:07:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A44B1ED8;
	Wed, 12 Jan 2022 21:07:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A44B1ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642018073;
	bh=ya/N5iS2hsQc3ayxGBVvBfqwiqsgzhMByeKRiFjm1ig=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c+5nVRQznVOfR0agcXewfviofGt8UXpLzZ0RuxFmPBTqwNoDCUWsPCZYRF3H1BzPk
	 jytBry3E3D5TITjH8cfJ6T7r7YSU26fn0RegIJpAS4el4jko69Jyzh9bzYaylKJ0J3
	 aYRXIGoanTyn2mu47C2nWEDvb5YnqvA/6qYNmE58=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1D81F8025E;
	Wed, 12 Jan 2022 21:07:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36F9DF8026A; Wed, 12 Jan 2022 21:07:02 +0100 (CET)
Received: from neo-zeon.de (neo-zeon.de [70.229.12.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12E22F80236
 for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2022 21:06:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12E22F80236
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=neo-zeon.de header.i=@neo-zeon.de
 header.b="wsOGnqtY"
Received: from neo-zeon.de (localhost [127.0.0.1])
 by neo-zeon.de (OpenSMTPD) with ESMTP id 9f1b631d;
 Wed, 12 Jan 2022 12:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=neo-zeon.de; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; s=1; bh=LsQgZUAtXz/CTWd
 vR+KQLZhrZLQ=; b=wsOGnqtYjqstNcf7G/2jAkEC5VZEL5+9SHA5IVcodgyQTje
 X676QXMnB6oKzRNX6sOBC//iyw3Le/JUTIZ2cMtnaCBm7gvWBQ8/Z4cGOpvShGxf
 p/1OYtuujlRWI93qlm8afXMHk6gt5kgsIM9ARZEjWKXQ+m3IagHUILEZ80Rc=
Received: by neo-zeon.de (OpenSMTPD) with ESMTPSA id 04d3b972
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Wed, 12 Jan 2022 12:00:07 -0800 (PST)
Message-ID: <3f042293-05de-d472-dd6e-ce5ca3a8331b@neo-zeon.de>
Date: Wed, 12 Jan 2022 12:00:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v6 08/10] ACPI / scan: Create platform device for CLSA0100
 and CSC3551 ACPI nodes
Content-Language: en-US
To: Lucas tanure <tanureal@opensource.cirrus.com>,
 Stefan Binding <sbinding@opensource.cirrus.com>,
 'Hans de Goede' <hdegoede@redhat.com>,
 "'Rafael J. Wysocki'" <rafael@kernel.org>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-9-tanureal@opensource.cirrus.com>
 <CAJZ5v0jTELqFeO6q6w_mYNo_yf1R9SX66RrEz0ZSe27w7E6kog@mail.gmail.com>
 <4b5506b1-20c6-3983-d541-86dc2388b2a7@redhat.com>
 <004001d7f5c6$7329d4d0$597d7e70$@opensource.cirrus.com>
 <e2d39d52-c139-a94a-94cc-88841d3638e3@opensource.cirrus.com>
From: Cameron Berkenpas <cam@neo-zeon.de>
In-Reply-To: <e2d39d52-c139-a94a-94cc-88841d3638e3@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "'moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...'"
 <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com,
 'Liam Girdwood' <lgirdwood@gmail.com>, 'Takashi Iwai' <tiwai@suse.com>,
 'Mark Gross' <markgross@kernel.org>,
 'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>,
 'Mark Brown' <broonie@kernel.org>,
 'Platform Driver' <platform-driver-x86@vger.kernel.org>,
 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
 'Len Brown' <lenb@kernel.org>
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

Hello,

Will this also include adding support for ID's matching CLSA0101?

Thanks,

-Cameron

On 1/12/22 05:05, Lucas tanure wrote:
> As the ic2-multi-instantiate patch chain is still being worked out, we 
> would like to submit a new chain for CLSA0100 id and a few fixes for 
> the HDA cs35l41 driver.
> And to avoid conflicts the ic2-multi-instantiate patch chain will wait 
> for this new patch chain to be merged.
>
> Thanks,
> Lucas Tanure 

