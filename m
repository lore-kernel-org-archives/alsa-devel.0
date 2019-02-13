From: sylvain.bertrand@gmail.com
Subject: Re: right way to enumerate pcm devices
Date: Wed, 13 Feb 2019 22:43:13 +0000
Message-ID: <20190213224313.GA1152@freedom>
References: <20190212123333.GB6441@freedom> <s5hr2cd3z9b.wl-tiwai@suse.de>
 <20190212203324.GA1399@freedom> <s5hpnrwciie.wl-tiwai@suse.de>
 <20190213141328.GA358@freedom> <20190213222518.GA974@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CA1267978
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 23:44:07 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id t200so4191191wmt.0
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 14:44:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190213222518.GA974@freedom>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 13, 2019 at 10:25:18PM +0000, sylvain.bertrand@gmail.com wrote:
> ...

Actually, I would just give a way to police the access to buffers. For
instance the user application would be in charge of handling the actual
mixing (I guess mmap-ed dma buffers).

-- 
Sylvain
