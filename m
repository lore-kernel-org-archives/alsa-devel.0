From: Bankim Bhavsar <bankim.bhavsar@gmail.com>
Subject: Finding the buffer fill level
Date: Wed, 4 Feb 2009 15:40:20 -0800
Message-ID: <4eccebac0902041540u38b6b9fake9de02ac75be2a1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id D8D981037F2
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 00:40:21 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1243221yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 04 Feb 2009 15:40:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I'm using following as the reference to find buffer fill-level of the
playback channel

* WRITE_TO_READ:  the current fill level of the playback buffer
- buffer_size - snd_pcm_avail_update()

http://article.gmane.org/gmane.linux.alsa.devel/54017

Infact I use snd_pcm_hwsync() before calling snd_pcm_avail_update() (
I know I can use snd_pcm_avail() but thats only available 1.0.18
onwards)

I use snd_pcm_set_buffer_size_near() to configure the hw params and
save the returned value of bufffer_size to find the buffer fill level
later on. On some sound cards
( snd_pcm_avail_update()  > buffer_size) which shouldn't be the case!
This throws off our internal polling calculations.

Information about the Linux hosts and sound cards where we've seen this issue.

Ubuntu 8.10 x64 host with kernel version 2.6.27-11-generic
Alsa lib version 1.0.17a

1) **** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]

2) **** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC885 Analog [ALC885 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC885 Digital [ALC885 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Is this a known issue?

Let me know if you need more information. Or there is an alternative
approach/workaround?

Thanks,
Bankim.
