From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Thu, 20 May 2010 09:01:37 +0100
Message-ID: <AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9418C103991
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 10:01:39 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3004170fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 20 May 2010 01:01:37 -0700 (PDT)
In-Reply-To: <201005191834.57919.vand2@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sebastian H." <vand2@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19 May 2010 17:34, Sebastian H. <vand2@gmx.de> wrote:
>
> Hello everyone
>
> I'm working on an ALSA-Mixer application for C++/Qt4 and stumbled over
> volume and decibel mapping for sliders.
> My question: Is there always an 1 to 1 mapping from volume to decibel and vice
> versa or can there be decibel values in between two volume steps?
>

There should be a one to one mapping.
If the hardware has 200 steps on the volume scale, and those 200 steps
are published to the user.
With the dB scale, there will still be the same 200 steps in the dB scale.
The dB information simply helps the user interface convert each step
into a dB value.
