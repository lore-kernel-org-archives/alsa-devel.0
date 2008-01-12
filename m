From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Sat, 12 Jan 2008 19:43:18 -0200
Message-ID: <5f52f6d70801121343k5cf3f147j75060eeb22c70458@mail.gmail.com>
References: <BAY109-W329D5BB94B8FE49792D1C4A9440@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by alsa0.perex.cz (Postfix) with ESMTP id CFBED2461F
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 22:43:20 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1126437rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 13:43:18 -0800 (PST)
In-Reply-To: <BAY109-W329D5BB94B8FE49792D1C4A9440@phx.gbl>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: De Fuuss <fuuss@hotmail.com>
Cc: Jiang zhe <zhe.jiang@intel.com>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2008/1/12 De Fuuss <fuuss@hotmail.com>:

> I reopened my shuttle case, closely inspected the motherboard and I think I found the issue. The onboard sound was factory set off (jumper), something which I must admit I did not check. However, I find it hard to imagine that XPC would sell their barebones with onboard sound off as a default. Even more weird, the headphones work when the onboard sound is "off".

I checked the Inspiron 530 hda routing and it seems that the front
channel sound is sent to all DACs. I get front speaker sound from all
output pins and they can be muted in the corresponding mixer amp-in.
This is weird, I'm starting to suspect that speaker-test is writing to
the wrong channels.
