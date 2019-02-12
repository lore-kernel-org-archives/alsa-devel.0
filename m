From: sylvain.bertrand@gmail.com
Subject: Re: right way to enumerate pcm devices
Date: Tue, 12 Feb 2019 20:33:24 +0000
Message-ID: <20190212203324.GA1399@freedom>
References: <20190212123333.GB6441@freedom>
 <s5hr2cd3z9b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A34E2673E2
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 21:34:15 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id v26so46646wmh.3
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 12:34:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5hr2cd3z9b.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 12, 2019 at 02:36:00PM +0100, Takashi Iwai wrote:
> The entries without hints are filtered out as default.
> i.e. a user-defined entry appears, too, if it contains the hints.
> 
> You can change the behavior by setting defaults.namehint.showall,
> too.

Hi again,

I am listing the pcm devices, and for the USB mic of my webcam, I get input
(IOID=Input) pcm devices for surroundX/frontspeakers/IEC958, which are
actually output pcm devices.
Why those output pcm devices are hinted as input devices?? Is this expected?
Bug? If not, how am I supposed to select the proper input pcm devices the
right(tm) way ?

regards,

-- 
Sylvain
