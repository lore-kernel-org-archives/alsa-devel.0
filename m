From: Alan Young <Alan.Young@IEE.org>
Subject: Re: Improving status timestamp accuracy
Date: Tue, 19 Jul 2016 16:33:54 +0100
Message-ID: <578E4862.4050603@IEE.org>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
 <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
 <57566D64.1050400@gmail.com> <577FC0C4.1060508@IEE.org>
 <93b0b35f-5b8d-6ba3-c7db-fb534e66d31c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C276267DF1
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 17:33:57 +0200 (CEST)
Received: by mail-lf0-f45.google.com with SMTP id b199so17794962lfe.0
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 08:33:57 -0700 (PDT)
In-Reply-To: <93b0b35f-5b8d-6ba3-c7db-fb534e66d31c@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 15/07/16 21:13, Pierre-Louis Bossart wrote:
> in update_delay() you apply a delta between the last timestamp and the 
> current one and modify the runtime->delay.
>
> Immediately after, in update_audio_tstamp() runtime->delay is used as 
> well to compute audio_frames which in turn is used to find the 
> audio_tstamp, on which another delta between current tstamp and last 
> timestamp is applied.
>
> Overall it looks like you are correcting twice for the same delay?
>
In update_audio_tstamp() it either usedruntime->delay, if 
runtime->audio_tstamp_config.report_delay is true, or applies a delta - 
not both.

> Even if this was correct, you would want to make sure the delta is 
> positive to keep audio timestamps monotonous. 

Hmm, maybe. In what circumstances could the delay ever be negative?
