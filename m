From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Coherence of status structure after SYNC_PTR
Date: Fri, 28 Dec 2018 13:21:24 +0900
Message-ID: <20181228042124.GA30249@workstation>
References: <20181227172224.GA18933@localhost.localdomain>
 <20181228034549.GA22203@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 91B7C267AC8
 for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2018 05:21:32 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id z11so9584332pgu.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 20:21:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181228034549.GA22203@workstation>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 28, 2018 at 12:45:49PM +0900, Takashi Sakamoto wrote:
> I note that there're some levels of timestamp and autio timestamp.
> Additionally, audio timestamp is updated only in any hardware/software IRQs,
> thus it's not available with 'no-period-wakeup' runtime, FYI.

Oops. No, the audio timestamp can be updated in updating process of
hardware pointer. A call of ioctl with SNDRV_PCM_IOCTL_STATUS and
SNDRV_PCM_IOCTL_STATUS_EXT can return updated audio timestamp.


Regards

Takashi Sakamoto
