From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC deprecated warning
Date: Thu, 30 Oct 2008 15:57:33 -0400
Message-ID: <9e4733910810301257t159c1b20t3a0414b55410dd7f@mail.gmail.com>
References: <9e4733910810301222v360ecf8aqbbead50759a2b844@mail.gmail.com>
	<20081030195107.GA13678@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id BA56C1037F3
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 20:57:34 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so735606rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 12:57:33 -0700 (PDT)
In-Reply-To: <20081030195107.GA13678@sirena.org.uk>
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
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 3:51 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Oct 30, 2008 at 03:22:31PM -0400, Jon Smirl wrote:
>> What's the status of this?
>
>> Could we have a Kconfig option of disabling deprecated APIs?
>> If I can get rid of this I'll have a warning free build.
>
> The API is removed in ALSA git, you can cherry pick the patch over if
> you want.  Otherwise I'd suggest taking it up with the people
> maintaining the compiler infrastructure - there's no way to warn on use
> of an API without also warning on the export of the API, which isn't
> ideal.

sysfs has a config attribute for including legacy APIs. If it isn't
set they compile out.

-- 
Jon Smirl
jonsmirl@gmail.com
