From: David Shirley <tephra@gmail.com>
Subject: Re: nvidia initial sound being skipped
Date: Sat, 20 Nov 2010 15:15:37 +1100
Message-ID: <AANLkTikfGndjp4wdjREzijV0jdTD_B=Tib-OmxK3QWaX@mail.gmail.com>
References: <AANLkTikH529TdvgfZX7bYvQVEHuj+1zTJS2YwjKc1yp_@mail.gmail.com>
	<AANLkTikOc5uwbn4OsKqpvrHUkBzg4k5Wf6YVLNwGm6wH@mail.gmail.com>
	<4CE630BC.6030402@ladisch.de>
	<AANLkTiktzi1j6_XjXAU_8g0OP+VOrx13kDuqz+8E592w@mail.gmail.com>
	<4CE66020.9090905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E51CF1037EA
	for <alsa-devel@alsa-project.org>; Sat, 20 Nov 2010 05:15:37 +0100 (CET)
Received: by wyg36 with SMTP id 36so5154651wyg.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 20:15:37 -0800 (PST)
In-Reply-To: <4CE66020.9090905@ladisch.de>
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

OK that works!

But I am concerned about the loss of audio quality when using dmix..

Apart from the sample rate mismatch (and therefor resampling, which
can be avoided by using the correct rate in asound.rc) is there
anything else I should be worried about?

Cheers
D.

On 19 November 2010 22:31, Clemens Ladisch <clemens@ladisch.de> wrote:
> David Shirley wrote:
>> How would u setup a dmix to play silence?
>
> If you haven't create or modified /etc/asound.conf or ~/.asoundrc,
> dmix should be enabled by default. =A0(If PulseAudio is installed
> correctly, PA should be enabled by default.)
>
> Try this to play ten seconds of silence:
>
> =A0aplay -d 10 -t raw -f dat /dev/zero
>
> To play continuously, omit the "-d 10".
>
>
> Regards,
> Clemens
>
