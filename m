From: "Nathan Schulte" <reklipz@gmail.com>
Subject: Re: [snd-bt87x] Prolink PixelView PlayTV
Date: Tue, 29 Apr 2008 00:15:04 -0500
Message-ID: <a221c0100804282215q6491f41bo2ea6f8787ad22e24@mail.gmail.com>
References: <27da43c40804271746h3992cea5rd4626ec6b8776ec3@mail.gmail.com>
	<s5hlk2yi7qh.wl%tiwai@suse.de> <4815ADF4.1080208@ladisch.de>
	<27da43c40804280606i321d4166mf933f65f67ab5c56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 16AB8245E4
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Apr 2008 07:15:05 +0200 (CEST)
Received: by rv-out-0506.google.com with SMTP id g37so2561126rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2008 22:15:04 -0700 (PDT)
In-Reply-To: <27da43c40804280606i321d4166mf933f65f67ab5c56@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I recently purchased an ECS A740GM-M Motherboard which has an IDT 92HD202
integrated audio chipset.

Alsa is recognizing it as a SigmaTel 9221 A2. It is similar to the SigmaTel
chipsets, but I cannot get spdif to work. After looking at the sigmatel
hda-intel patch, it seems that spdif out is limited to two channels.

What I'm wondering is this; is there any need to write a new driver to get
this chip working? And if so, where should I start, or has someone already
started?

I'm willing to take this on, but I don't know where to start. Any advice
would be helpful!

-Nate
