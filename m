From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Out of tree driver for hiface
Date: Wed, 07 Nov 2012 14:10:34 +0100
Message-ID: <509A5DCA.3070706@ladisch.de>
References: <CACckToVxqMdQx_ER+ErsyJech8EVx2k8U_Ps5qzymFL1bd3-FA@mail.gmail.com>
 <CACckToX+BVfTisKUZfkVe43ZE5S4k+QAwWwAhdzrb_YjwmP+QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 500D9264FEA
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 14:10:36 +0100 (CET)
In-Reply-To: <CACckToX+BVfTisKUZfkVe43ZE5S4k+QAwWwAhdzrb_YjwmP+QQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Grant Diffey wrote:
> <https://github.com/panicking/snd-usb-asyncaudio>
> Could ever be merged/incorporated into mainline?

Yes.

> Does it contain too much in common with snd-usb-audio requiring merging
> into that to go into mainline?

That device isn't the slightest bit compatible with any standard audio
device; merging with snd-usb-audio would not make sense.


Regards,
Clemens
