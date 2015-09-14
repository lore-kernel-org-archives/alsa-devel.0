From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 05/10] ALSA: axd: add buffers manipulation files
Date: Mon, 14 Sep 2015 10:11:58 +0100
Message-ID: <55F68F5E.3050609@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-6-git-send-email-qais.yousef@imgtec.com>
 <20150826184323.GE28760@sirena.org.uk> <55DF1CDD.6040109@imgtec.com>
 <20150829094711.GZ12027@sirena.org.uk> <55E5774A.8070808@imgtec.com>
 <20150903123232.GX12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150903123232.GX12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/03/2015 01:32 PM, Mark Brown wrote:
> On Tue, Sep 01, 2015 at 11:00:42AM +0100, Qais Yousef wrote:
>> On 08/29/2015 10:47 AM, Mark Brown wrote:
> Please delete unneeded context from replies, it makes it easier to find
> the new content you have added.  Please also leave blank lines between
> paragraphs, it makes it much easier to read messages.


Sorry about that and for the delayed response. I added one more blank line now, hopefully this looks better.

  

>> to the driver that it can reuse it, there's no guarantee that this returned
>> buffer is in the same order it was sent.
> If that's the case I'm not sure the code is correct - it seemed to have
> assumptions that the buffers were going to be retired in the order.


What this code is trying to do is the same as what vring do. I'll move 
this driver to be rproc based which hopefully should make things simpler 
and trim all of this out and address your other review comments as well.

I didn't write an rproc driver before, if there's anything that you 
think I need to be aware of when writing an rproc based *ALSA* driver 
I'd appreciate pointing it out.

Thanks,
Qais
