From: Rob Duncan <rduncan@tesla.com>
Subject: Re: Miscellaneous ioplug questions
Date: Tue, 14 Aug 2018 09:25:15 -0700
Message-ID: <dw77em36vgq5jo.fsf@tesla.com>
References: <dw77emtvo3pee8.fsf@tesla.com> <s5ha7pueqzk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0019bd01.pphosted.com (mx0a-0019bd01.pphosted.com
 [148.163.151.57])
 by alsa0.perex.cz (Postfix) with ESMTP id F156426770B
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2018 18:25:18 +0200 (CEST)
In-Reply-To: <s5ha7pueqzk.wl-tiwai@suse.de>
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
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>> - Should the poll FD be made writeable as soon as data is available, or
>>   only when at least avail_min is available?
>
> The latter.  Again, ioplug emulates the hardware driver, so the poll
> should behave same as the hardware driver does.
> (Though, admittedly, not all plugin implementations follow this
> strictly....)

So, the poll FD must be readable while there is at least avail_min in
the buffer, and must NOT be readable if there is less than avail_min.
Is that right?

To labor the point a bit, if exactly avail_min becomes available the
poll FD must be made readable.  If a single frame is now transferred, so
the buffer has (avail_min - 1) available, what must the state of the
poll FD be?

A couple more questions:

If we are configured to do blocking operations must the read and write
callbacks always transfer the full requested size, or can they do
partial transfers?

On the other hand, what if we are configured to do non-blocking
operations?

Or does the caller guarantee not to request a transfer larger than what
the ioplugin reports as available?

Thanks,

Rob.
