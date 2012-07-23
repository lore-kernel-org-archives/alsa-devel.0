From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using MMAP feature
Date: Mon, 23 Jul 2012 12:38:27 +0200
Message-ID: <500D29A3.50204@ladisch.de>
References: <500CF994.5090901@seletech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C5FE526523D
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 12:38:26 +0200 (CEST)
In-Reply-To: <500CF994.5090901@seletech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alberto Villa <a.villa@seletech.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alberto Villa wrote:> Hello,
> I'm going to use the MMAP feature of ALSA.

Why do you need to do this?

> snd_pcm_mmap_begin(capture, &c_area, &c_offset, &c_frames);
>
> it keeps to return c_frames = 0: is it right ? what does this mean?

It means that there are no samples available at the moment.
(Or that you forgot to call snd_pcm_avail_update(), or that you
didn't set c_frames before the call.)


Regards,
Clemens
