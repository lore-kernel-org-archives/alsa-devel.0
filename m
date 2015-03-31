From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: cygnus-audio: adding device tree
 bindings
Date: Tue, 31 Mar 2015 09:26:47 +0200
Message-ID: <551A4C37.5090903@metafoo.de>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com> <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, Lori Hikichi <lhikichi@broadcom.com>, linux-kernel@vger.kernel.org, bryeung@google.com, abrestic@google.com, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, pwestin@google.com, Anatol Pomazao <anatol@google.com>, olofj@google.com, Dmitry Torokhov <dtor@google.com>, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 03/31/2015 05:16 AM, Scott Branden wrote:
[...]
> +- ssp-port-id: The ssp port interface to use
> +	Valid value are 0, 1, 2, or 3 (for spdif)

How about using 'reg' as the property name here. It is the standard property 
name for identifying or assigning an address to a sub-node.
