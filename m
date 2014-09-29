From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH v3] ES938 support for ES18xx driver
Date: Mon, 29 Sep 2014 23:58:04 +0200
Message-ID: <20140929215804.GA20023@rhlx01.hs-esslingen.de>
References: <1412027079-15876-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412027079-15876-1-git-send-email-linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 29, 2014 at 11:44:39PM +0200, Ondrej Zary wrote:
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
> Changes in v3:
>  - constify buf argument to snd_rawmidi_kernel_write
>  - remove double if from probe
>  - spelling fix
> Changes in v2:
>  - debug message when ES938 detected
>  - reworked sysex messages to use structs
>  - ktime instead of jiffies for timeout
> ---

Nice!

Reviewed-by: Andreas Mohr <andim2@users.sf.net>

Andreas Mohr
