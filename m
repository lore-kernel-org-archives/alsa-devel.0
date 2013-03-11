From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH][RESEND] Add a USB audio quirk for the NuForce UDH-100
 device.
Date: Mon, 11 Mar 2013 09:32:12 +0100
Message-ID: <513D968C.1060905@ladisch.de>
References: <1362973920-4942-1-git-send-email-helstroom@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362973920-4942-1-git-send-email-helstroom@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Helstroom <helstroom@google.com>
Cc: perex@perex.cz, tiwai@suse.de, eldad@fogrefinery.com, damien@zamaudio.com, pete.leigh@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

David Helstroom wrote:
> Interface 1 does not exist

Then it doesn't need a quirk, does it?

> and Interface 0 should be ignored.

Why?

If the driver doesn't like something in interface 0, that bug should be
fixed.

What is the output of "lsusb -v" for this device?


Regards,
Clemens
