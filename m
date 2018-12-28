From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: Re: Coherence of status structure after SYNC_PTR
Date: Fri, 28 Dec 2018 14:28:24 -0200
Message-ID: <20181228162824.GA28189@localhost.localdomain>
References: <20181227172224.GA18933@localhost.localdomain>
 <20181228034549.GA22203@workstation>
 <20181228042124.GA30249@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by alsa0.perex.cz (Postfix) with ESMTP id C066E267A78
 for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2018 17:28:30 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id u47so19207209qtj.6
 for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2018 08:28:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181228042124.GA30249@workstation>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 28, 2018 at 01:21:24PM +0900, Takashi Sakamoto wrote:
> On Fri, Dec 28, 2018 at 12:45:49PM +0900, Takashi Sakamoto wrote:
> > I note that there're some levels of timestamp and autio timestamp.
> > Additionally, audio timestamp is updated only in any hardware/software IRQs,
> > thus it's not available with 'no-period-wakeup' runtime, FYI.
> 
> Oops. No, the audio timestamp can be updated in updating process of
> hardware pointer. A call of ioctl with SNDRV_PCM_IOCTL_STATUS and
> SNDRV_PCM_IOCTL_STATUS_EXT can return updated audio timestamp.

Thank you for the explanation!

Regarding the alsa-lib, pcm_hw, htimestamp():

Although not needed, adding a 'break' in the loop when
'mmap_status_fallbacked' is true would avoid another ioctl.

Cheers!

	pasquali
