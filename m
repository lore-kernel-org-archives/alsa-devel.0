From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: intel8x0 - copy function
Date: Fri, 25 Apr 2008 12:12:36 +0530
Message-ID: <827ad74d0804242342g68415172tcb43acb92a8cf9f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by alsa0.perex.cz (Postfix) with ESMTP id EE0C22471F
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 08:42:37 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so4118759wxc.23
	for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2008 23:42:36 -0700 (PDT)
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
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am using Intel8x0 driver for my sound card.  During data transfer from
user to driver, I am trying to collect the buffer. I have implemented .copy
function and also disabled the mmap.

If I disable the mmap in .info structure, i get an error that the device is
in use. If i try getting the debug messages; It fails in
snd_pcm_common_ioctl1 for  SNDRV_PCM_IOCTL_HW_REFINE.

Can anyone please guide me on to the right path of implementing what I want
to do.

-- 
-Harsha
