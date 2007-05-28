From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: async playback works despite error in snd_pcm_start.
Date: Mon, 28 May 2007 15:13:38 -0400
Message-ID: <975f530d0705281213y5a25112ew1257d4472d12faa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by alsa0.perex.cz (Postfix) with ESMTP id C311E24764
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 21:13:39 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id r21so1375584wxc
	for <alsa-devel@alsa-project.org>; Mon, 28 May 2007 12:13:38 -0700 (PDT)
Content-Disposition: inline
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

Hi,

I managed to write code to playback sound asynchronously -- however, this
code works (i.e data is read from .wav file and output to the playback
device) despite the snd_pcm_start giving a "file descriptor in bad state"
error..

can someone explain this please?
Thanks,
Ashlesha.
