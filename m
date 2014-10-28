From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 00/11] Add AXD Audio Processing IP driver
Date: Tue, 28 Oct 2014 12:55:37 +0100
Message-ID: <544F8439.4080402@ladisch.de>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Qais Yousef wrote:
> AXD Audio Processing IP performs audio decoding, encoding, mixing, equalisation,
> synchronisation and playback.

What exactly do you mean with "synchronisation" and "playback"?

> It doesn't fit in alsa subsystem but I Cced them to confirm.

... because those two words sound like something that a sound card could do.

> I added it to drivers/char as this is the best location I could think of at the
> moment.

drivers/misc?


Regards,
Clemens
