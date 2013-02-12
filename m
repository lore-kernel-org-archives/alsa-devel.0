From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Xonar DG pci sound card driver incomplete
Date: Tue, 12 Feb 2013 17:53:29 +0100
Message-ID: <511A7389.7090403@ladisch.de>
References: <CAG=jzgDxD5ZB683bieoCHQFTehRmOMwnzgefmeSenRPFudY4RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG=jzgDxD5ZB683bieoCHQFTehRmOMwnzgefmeSenRPFudY4RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel kernel <kernel@kenobrien.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

kernel kernel wrote:
> Requesting guidance on how to implement the missing mic input support
> for this Asus Xonar card. I've downloaded the relevant datasheets but
> am unsure how to proceed.

Rip out the card, and look (or eletrically trace) how the CMI8788's
GPIOs and the CS4245's inputs/outputs are connected.

Test how to configure and set the GPIOs so that the mic works.
Also check the register configuration of the CS4245.


Regards,
Clemens
