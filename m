From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What is the required accuracy of audio sampling
	rate?
Date: Wed, 17 Feb 2010 08:03:17 -0500
Message-ID: <9e4733911002170503w1d89c1abn1e6afcf8d56ccb1b@mail.gmail.com>
References: <e5baf3861002161558x1d36f74anf63c5db145762668@mail.gmail.com>
	<ad2655cb1002170452s617ada8du1de85aa3baa9c6fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C0A7103883
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:03:20 +0100 (CET)
Received: by pwi9 with SMTP id 9so969309pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 05:03:18 -0800 (PST)
In-Reply-To: <ad2655cb1002170452s617ada8du1de85aa3baa9c6fb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Yiliang Bao <yiliangb@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 7:52 AM, James Courtier-Dutton
<james.dutton@gmail.com> wrote:
> On 16 February 2010 23:58, Yiliang Bao <yiliangb@gmail.com> wrote:
>> Hi,
>>
>> I have a PCI-e audio card that does not give very accurate sampling rate
>> (about -0.2% error, i.e., if I set the sampling rate to 8K, I got only 7984
>> samples per second on average). It caused various synchronization problems
>> in applications like gstreamer.
>>
>> Since there will be some difference from one clock domain to another, I am
>> wondering if there is any defined tolerance on the sampling rate, and where
>> the right place is to correct this kind of error. I would really appreciate
>> if someone can point me to the related documents/links.
>>
>
> There is no defined tolerance on sampling rate.
> Audio apps should be able to deal with a certain amount of error.
> xine uses the system clock for its synchronization, and resamples the
> audio output if the audio hardware is running at a different rate.
> Other apps might use the audio clock and sync to that. In that case,
> it might get the problems you describe.
> Try playing your media in xine and see if the problem disappears.

The -0.2% error is cumulative, not random. After a three hour movie
your audio will be off by 20 seconds.

Best solution is the get the audio clock synched as closely as
possible to the video one. Any remaining error has to be dealt with in
software like xine does.


>
> Kind Regards
>
> James
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Jon Smirl
jonsmirl@gmail.com
