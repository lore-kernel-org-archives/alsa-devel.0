From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: Splitting up the HDA-INTEL modules
Date: Wed, 16 Jan 2008 10:51:45 -0200
Message-ID: <5f52f6d70801160451p37a8c94ofbbbd2018f88531b@mail.gmail.com>
References: <478CFD32.50405@harddisk.is-a-geek.org>
	<5f52f6d70801151120y76407dd4s4c876643ddc8ba95@mail.gmail.com>
	<s5h1w8ivvd4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id A81DC24367
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 13:51:46 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so173075rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 04:51:45 -0800 (PST)
In-Reply-To: <s5h1w8ivvd4.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Marco Schuster <marco@harddisk.is-a-geek.org>
List-Id: alsa-devel@alsa-project.org

On Jan 16, 2008 9:54 AM, Takashi Iwai <tiwai@suse.de> wrote:

> It's a good question whether the setup should be the codec (driver)
> dependent or generic.  I tend to believe that we'll need some
> codec-specific workarounds, at least, to keep the same level of the
> driver support as now.
>
> In my earler development, I implemented some byte-code implementer in
> the driver so that it can be handled in a generic way.  The current
> codec specific implementation is interpreted to a byte-code in the
> user-space tool, and it runs on the driver.  Of course, this method
> adds an interpreter to the driver, and I'm also not sure whether this
> method is optimal.

I'll have a look at the current hda-tools and see how it works before
emmiting any opinion, I am aware that the codec configuration is more
complicated than it looks.
