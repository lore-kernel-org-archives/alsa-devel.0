From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: hardware-dependent features
Date: Mon, 12 Nov 2007 11:56:36 -0500
Message-ID: <75b66ecd0711120856o6cdf9c6co72da76ac4ea993f4@mail.gmail.com>
References: <20071112131350.GA25885@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C5F2243A3
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 17:56:38 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so984562rvb
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 08:56:36 -0800 (PST)
In-Reply-To: <20071112131350.GA25885@buzzloop.caiaq.de>
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
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 12, 2007 8:13 AM, Daniel Mack <daniel@caiaq.org> wrote:
> Hi,
>
> some of the devices the caiaq driver supports have special hardware
> features such as switchable ground lift, input impedance selection or
> other, hardware-specific features. On both Windows and MacOSX there are
> special tools to set those features but the ALSA driver still lacks
> support for them which I want to change soon. However, I couldn't find a
> generic way to do that. I was thinking about a sysfs entry which is
> attached to the sound card instance but didn't find a driver which did
> similar things.

Use the ALSA mixer API.

Lee
