From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 05/10] ALSA: usb-audio: use endianness
	macros
Date: Sun, 31 Mar 2013 18:06:12 +0200
Message-ID: <51585EF4.7090907@ladisch.de>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-6-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0B207261719
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 18:06:21 +0200 (CEST)
In-Reply-To: <1364745152-1762-6-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Eldad Zack wrote:
> Replace the endianness conversions with the kernel-wide swabbing macros.

> +	u32 data;
> +	data = cpu_to_le32(rate);

cpu_to_le32() returns not u32 but __le32.
Please use that to make sparse happy.


Regards,
Clemens
