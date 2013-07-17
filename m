From: divya v <divyasslv@gmail.com>
Subject: Help in understanding SND_PCM_TSTAMP_ENABLE mode
	snd_pcm_htimestamp function
Date: Wed, 17 Jul 2013 00:10:39 -0700
Message-ID: <CACQjdxDywzxBgHg0v++m4L4NuuvAPt9qnw=9v3j+5fFxhNFjBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f42.google.com (mail-oa0-f42.google.com
 [209.85.219.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 782DC2651B0
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 09:10:40 +0200 (CEST)
Received: by mail-oa0-f42.google.com with SMTP id j6so2083517oag.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 00:10:39 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi,

I am looking for a method to maintain timestamps for every sample read or
written.
I noticed the *SND_PCM_TSTAMP_ENABLE mode. But the description mentions - ""
*pdate timestamp at every hardware position update"
Doe this mean that the when snd_pcm_htimestamp() is issued, we will get the
last hardware update timestamp or does it mean that it will fetch the
timestamp of that particular sample?

Thanks,
Divya
