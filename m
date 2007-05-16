From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: ICE1712/1724 HW mixing?
Date: Wed, 16 May 2007 18:05:22 -0400
Message-ID: <75b66ecd0705161505g4263ff8bp63eb6933d98359e8@mail.gmail.com>
References: <464A5D6A.9020104@gmail.com>
	<200705160927.40433.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 9662A243C2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 00:05:24 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so688173nzf
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2007 15:05:23 -0700 (PDT)
In-Reply-To: <200705160927.40433.gineera@aspect135.co.uk>
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
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 5/16/07, Alan Horstmann <gineera@aspect135.co.uk> wrote:
> Hardware mixing of 10 inputs and 10 outputs is provided.  In the
> notes, it is probably worth mentioning Envy24control, a mixing/control tool
> dedicated to this chipset?
>

I don't think it has "hardware mixing" by ALSA's definition, which is
that multiple applications can open the same hw:x device and the
hardware will mix all the streams together.

Lee
