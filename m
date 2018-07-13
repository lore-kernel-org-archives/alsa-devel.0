From: Rob Duncan <rduncan@tesla.com>
Subject: Bug in snd_pcm_ioplug_avail_update()?
Date: Fri, 13 Jul 2018 15:10:29 -0700
Message-ID: <dw77em7elyg52i.fsf@tesla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0019bd01.pphosted.com (mx0a-0019bd01.pphosted.com
 [148.163.151.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 2631826771A
 for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2018 00:10:34 +0200 (CEST)
Received: from pps.filterd (m0127434.ppops.net [127.0.0.1])
 by mx0a-0019bd01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6DM7LUp007908
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 15:10:32 -0700
Received: from external-smtp.teslamotors.com ([209.11.133.121])
 by mx0a-0019bd01.pphosted.com with ESMTP id 2k7442r3xr-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 15:10:31 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It seems to me that there's something wrong in
snd_pcm_ioplug_avail_update() for capture IO plugins.

Once a bunch of conditions are met it makes this call:

	__snd_pcm_mmap_begin(pcm, &areas, &offset, &size);
	result = io->data->callback->transfer(io->data, areas, offset, size);
	if (result < 0)
		return result;

This transfers size frames from the IO plugin, which in general is not
all the available data: it's limited by the amount of contiguous space
in the mmap.

However, the function returns like this:

	avail = snd_pcm_mmap_avail(pcm);
	if (avail > io->avail_max)
		io->avail_max = avail;
	return (snd_pcm_sframes_t)avail;

But this is all the available data in the IO plugin, without considering
the contiguous space limitation. This means that there is now
uninitialized data in the mmap, and some data still in the IO plugin
that has yet to be transferred.

I'm running into this misbehaviour with a rate conversion plugin pulling
data from an IO plugin.  I get chunks of old data showing up later in
the stream, I think because the mmap buffer is not being fully written
to.

I suspect that this avail mismatch tricks snd_pcm_rate_avail_update()
into thinking that it can grab an integral number of periods of data
from the mmap, which is not the case.

But I'm quite tangled up trying to follow the control flow here so I
could certainly be mistaken.  I'd appreciate any insight into what might
be going wrong.

Thanks,

Rob.
