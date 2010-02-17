From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: What is the required accuracy of audio sampling
	rate?
Date: Wed, 17 Feb 2010 12:52:57 +0000
Message-ID: <ad2655cb1002170452s617ada8du1de85aa3baa9c6fb@mail.gmail.com>
References: <e5baf3861002161558x1d36f74anf63c5db145762668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 406DA103856
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 13:52:58 +0100 (CET)
Received: by fxm1 with SMTP id 1so7710620fxm.4
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 04:52:57 -0800 (PST)
In-Reply-To: <e5baf3861002161558x1d36f74anf63c5db145762668@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yiliang Bao <yiliangb@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 16 February 2010 23:58, Yiliang Bao <yiliangb@gmail.com> wrote:
> Hi,
>
> I have a PCI-e audio card that does not give very accurate sampling rate
> (about -0.2% error, i.e., if I set the sampling rate to 8K, I got only 7984
> samples per second on average). It caused various synchronization problems
> in applications like gstreamer.
>
> Since there will be some difference from one clock domain to another, I am
> wondering if there is any defined tolerance on the sampling rate, and where
> the right place is to correct this kind of error. I would really appreciate
> if someone can point me to the related documents/links.
>

There is no defined tolerance on sampling rate.
Audio apps should be able to deal with a certain amount of error.
xine uses the system clock for its synchronization, and resamples the
audio output if the audio hardware is running at a different rate.
Other apps might use the audio clock and sync to that. In that case,
it might get the problems you describe.
Try playing your media in xine and see if the problem disappears.

Kind Regards

James
