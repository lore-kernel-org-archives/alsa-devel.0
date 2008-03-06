From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: snd_pcm_open device names
Date: Thu, 06 Mar 2008 13:13:51 +1300
Message-ID: <200803061313.51242.linux@audioscience.com>
References: <47CF2DE2.3010506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F072243A2
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 01:09:25 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXA004OT8FM3E40@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 06 Mar 2008 13:09:22 +1300 (NZDT)
In-reply-to: <47CF2DE2.3010506@googlemail.com>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 06 March 2008 12:33:54 Reiner wrote:
> with
> snd_pcm_open (handle, "default", SND_PCM_STREAM_PLAYBACK, 0)
> I can open a device twice
> with
> snd_pcm_open (handle, "plughw:0,0", SND_PCM_STREAM_PLAYBACK, 0)
> the 2. call fails with error -16.
>
> The docu says:
> The default device is equal to plug plugin with hw plugin as slave.

Probably the doc is in error. The default device these days is usually asym 
(dmix+dsnoop) which allows the multiple opens.

--
Eliot
www.audioscience.com
