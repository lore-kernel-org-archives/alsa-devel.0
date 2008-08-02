From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: amixer and mono
Date: Sat, 2 Aug 2008 19:20:51 -0400
Message-ID: <75b66ecd0808021620v18ee3cc5h4828770d33ef57f1@mail.gmail.com>
References: <9e4733910808011432x232cec34t282aec253053a073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 51B6A103842
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Aug 2008 01:20:53 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1232797rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 02 Aug 2008 16:20:51 -0700 (PDT)
In-Reply-To: <9e4733910808011432x232cec34t282aec253053a073@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 1, 2008 at 5:32 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The device's master volume control controls all channels through one
> value. The device really is stereo. You use biquads if you want to
> process the channels differently.
>
> What do I do about this?

Nothing.  The mono refers to the control, not the underlying audio stream.

Lee
