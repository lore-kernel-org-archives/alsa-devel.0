From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Jackd dies with snd-usb-usx2y (DRIVER NT error)
Date: Tue, 15 May 2007 16:11:00 -0400
Message-ID: <75b66ecd0705151311s101694dbmc12dc8e10ef5e09b@mail.gmail.com>
References: <8e4fc8270704260313h31424b42jf41f7a374613d354@mail.gmail.com>
	<8e4fc8270705151257i4c11cf53q8128599fe500bf32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 1955424892
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 22:11:01 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so267680nzf
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 13:11:00 -0700 (PDT)
In-Reply-To: <8e4fc8270705151257i4c11cf53q8128599fe500bf32@mail.gmail.com>
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
To: Michael Bourgeous <sts.nitrogen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/15/07, Michael Bourgeous <sts.nitrogen@gmail.com> wrote:
> chrt -v -f 70 jackd -d alsa -dhw:1,2 -p 64 -n 2 # also tried defaults,

You should be using jackd -R -d alsa etc. rather than chrt.

> chrt -v -f 25 zynaddsubfx

No need to use chrt, jackd will take care of realtime priority.

> ----------
> [12546.132286] ALSA [...]/usx2yhwdeppcm.c:94: activ frame status -70.
> Most propably some hardware problem.
> ----------

Sounds like a hardware problem.  Try a different USB port.  Make sure
you aren't using a USB hub.

Lee
