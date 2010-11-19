From: David Shirley <tephra@gmail.com>
Subject: Re: nvidia initial sound being skipped
Date: Fri, 19 Nov 2010 20:53:36 +1100
Message-ID: <AANLkTiktzi1j6_XjXAU_8g0OP+VOrx13kDuqz+8E592w@mail.gmail.com>
References: <AANLkTikH529TdvgfZX7bYvQVEHuj+1zTJS2YwjKc1yp_@mail.gmail.com>
	<AANLkTikOc5uwbn4OsKqpvrHUkBzg4k5Wf6YVLNwGm6wH@mail.gmail.com>
	<4CE630BC.6030402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A451610382C
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 10:53:38 +0100 (CET)
Received: by bwz8 with SMTP id 8so3766468bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 01:53:36 -0800 (PST)
In-Reply-To: <4CE630BC.6030402@ladisch.de>
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

Yeah it could be that. How would u setup a dmix to play silence?

Thanks
D.
On 19/11/2010 7:07 PM, "Clemens Ladisch" <clemens@ladisch.de> wrote:
> David Shirley wrote:
>> > I am using an nvidia MCP78 to connect to a Denon 1910 AVR via HDMI.
>> >
>> > I was using Kernel 2.6.32.21 and noticed that the initial few seconds
>> > of my songs was being chopped off.
>>
>> I just want to say I upgraded to kernel 2.6.36 today and still miss
>> the first 0.5seconds or so of the sound output.
>> ...
>> both HDMI and SPDIF exhibit the same problem.
>
> Apparently, your receiver needs even more time to detect that some
> sound is playing; there's nothing that the computer could do about it.
>
> Try playing some silence before starting playing music. (This requires
> a software mixer like dmix or PulseAudio.)
>
>
> Regards,
> Clemens
