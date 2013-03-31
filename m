From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 05/10] ALSA: usb-audio: use endianness
	macros
Date: Sun, 31 Mar 2013 19:30:56 +0200
Message-ID: <515872D0.6010400@ladisch.de>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-6-git-send-email-eldad@fogrefinery.com>
 <51585EF4.7090907@ladisch.de> <alpine.LNX.2.00.1303311909180.1963@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2EC3F2625CF
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 19:31:04 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1303311909180.1963@xoschi>
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
> On Sun, 31 Mar 2013, Clemens Ladisch wrote:
>> cpu_to_le32() returns not u32 but __le32.
>> Please use that to make sparse happy.
>
> BTW, sparse (0.4.3) didn't complain on my box.
> I'm just calling make C=1.

make C=1 CF=-D__CHECK_ENDIAN__


Regards,
Clemens
