From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA hw sample rate conversion support
Date: Wed, 30 Mar 2011 15:27:59 +0200
Message-ID: <4D932FDF.2020907@ladisch.de>
References: <AANLkTikT+O+D1wQCVa0vsOQyMJcEHP9+9JEfCm=q+bho@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 65C5A24373
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 15:26:44 +0200 (CEST)
In-Reply-To: <AANLkTikT+O+D1wQCVa0vsOQyMJcEHP9+9JEfCm=q+bho@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aisheng Dong <dongas86@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Aisheng Dong wrote:
> Does ALSA core support hw sample rate conversion now?

Yes; this has always been supported for chips like Emu10k1.

> I wonder if current ALSA core provide interface to support hw sample
> rate conversion?

In your driver, set the ..._CONTINUOUS flag in the rates field (see the
section "Hardware Description" in the doc), and in the hw_params
callback, program the SRC according to the selected rate.


Regards,
Clemens
