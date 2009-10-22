From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Exemple of source code for capture without using
	callback
Date: Thu, 22 Oct 2009 20:47:45 +0100
Message-ID: <ad2655cb0910221247y215abdb9sc5f4c2bb967d3846@mail.gmail.com>
References: <26289049-EACA-4DC6-A396-E2AF4EB6F2E9@gmail.com>
	<ad2655cb0910220740k5ef0f931j7f0ec48cb5d01cec@mail.gmail.com>
	<4AE074DB.4030600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D7F424142
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 21:47:47 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id d23so2712353fga.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2009 12:47:46 -0700 (PDT)
In-Reply-To: <4AE074DB.4030600@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, brunal2496 gmail <brunal2496@gmail.com>
List-Id: alsa-devel@alsa-project.org

2009/10/22 Clemens Ladisch <clemens@ladisch.de>:
> James Courtier-Dutton wrote:
>> 2009/10/20 brunal2496 gmail <brunal2496@gmail.com>:
>> > I've read everywhere that using callback is a bad method to use the
>> > alsa drivers.
>>
>> This is wrong. callback is the best method.
>
> But _not_ the snd_async_add_pcm_handler function, which is evil.
> (This is the only ALSA PCM function that mentions "callback" in its
> documentation, so these are often confused.)
>
> The 'good' callback method means that the audio driver informs the
> application when its wants to have new audio data, not the other way.
>
Yes, to clarify, not that call.
A poll() that then does the callback is the preferred method.
