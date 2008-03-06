From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: snd_pcm_open device names
Date: Thu, 6 Mar 2008 13:36:28 -0500
Message-ID: <75b66ecd0803061036r3332dc92t67ba25cedacd515f@mail.gmail.com>
References: <47CF2DE2.3010506@googlemail.com>
	<200803061313.51242.linux@audioscience.com>
	<47D03928.3040902@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 86FB02433B
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 19:36:30 +0100 (CET)
Received: by qb-out-0506.google.com with SMTP id q12so2164083qba.12
	for <alsa-devel@alsa-project.org>; Thu, 06 Mar 2008 10:36:28 -0800 (PST)
In-Reply-To: <47D03928.3040902@googlemail.com>
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
To: Reiner <reiner1210@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 6, 2008 at 1:34 PM, Reiner <reiner1210@googlemail.com> wrote:
> Thanks! But if I try "asym" open fails, where can I see what "default"
>  is? There is no ~/.asoundrc and in /etc there is only asound.state.
>  By the way I'am looking for a function to adjust the volume of the
>  stream, any idea

There is no per stream volume control in ALSA.  This should be handled
by the application, or a sound server like Pulseaudio.

Lee
