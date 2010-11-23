From: David Shirley <tephra@gmail.com>
Subject: Re: nvidia initial sound being skipped
Date: Tue, 23 Nov 2010 14:16:26 +1100
Message-ID: <AANLkTi=NPMY3r+=USgv4zeHTe1wjV2uzSGOS4v4fpxbv@mail.gmail.com>
References: <AANLkTikH529TdvgfZX7bYvQVEHuj+1zTJS2YwjKc1yp_@mail.gmail.com>
	<AANLkTikOc5uwbn4OsKqpvrHUkBzg4k5Wf6YVLNwGm6wH@mail.gmail.com>
	<4CE630BC.6030402@ladisch.de>
	<AANLkTiktzi1j6_XjXAU_8g0OP+VOrx13kDuqz+8E592w@mail.gmail.com>
	<4CE66020.9090905@ladisch.de>
	<AANLkTikfGndjp4wdjREzijV0jdTD_B=Tib-OmxK3QWaX@mail.gmail.com>
	<4CEA2183.1050408@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id EE8E124383
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 04:16:29 +0100 (CET)
Received: by fxm10 with SMTP id 10so664863fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 19:16:26 -0800 (PST)
In-Reply-To: <4CEA2183.1050408@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Does that mean that dmix/alsa doesn't introduce or loose any bits when
the input rate matches the output rate?

Cheers
D.

On 22 November 2010 18:53, Clemens Ladisch <clemens@ladisch.de> wrote:
> David Shirley wrote:
>> But I am concerned about the loss of audio quality when using dmix..
>>
>> Apart from the sample rate mismatch (and therefor resampling, which
>> can be avoided by using the correct rate in asound.rc) is there
>> anything else I should be worried about?
>
> x + 0 = x
>
>
> Regards,
> Clemens
>
