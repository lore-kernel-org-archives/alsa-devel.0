From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cs4265 : alsactl store and "C data buffer" fails
Date: Tue, 7 May 2019 08:08:14 +0200
Message-ID: <1c0e5dbe-d5d5-c505-3b62-77e5fab8ee3d@ladisch.de>
References: <bdc0a30f-c6f3-8ccb-f556-1d1a6a68f3b9@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A07FF807B5
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 08:08:16 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id ADA415583451
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 08:08:15 +0200 (CEST)
In-Reply-To: <bdc0a30f-c6f3-8ccb-f556-1d1a6a68f3b9@flatmax.org>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Flax wrote:
> When alsactl store is run with a cs4265 chip, the following error occurs (from https://github.com/Audio-Injector/Ultra/issues/25) :
>
> $ sudo alsactl store
> alsactl: get_control:256: Cannot read control '2,0,0,C Data Buffer,0': Input/output error

This sounds like a bug in cs4265_readable_register(); try replacing CS4265_SPDIF_CTL2
with CS4265_MAX_REGISTER.


Regards,
Clemens
