From: Gabriel Beddingfield <gabrbedd@gmail.com>
Subject: Re: alsa/asoundlib.h file not found
Date: Tue, 6 Sep 2011 06:09:27 -0500
Message-ID: <CAPbw_hzv7z7jcHe-XaLAwmXevk9K154DiKUKEVVktDFRNRVeMw@mail.gmail.com>
References: <CAODvfaHhEHp5aYQ2CkeLTZvOVLP+8Ncq8VCpDtOeTPE4N0Fg8Q@mail.gmail.com>
	<4E65F701.9070304@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1654124678
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 13:09:28 +0200 (CEST)
Received: by wyh21 with SMTP id 21so4613771wyh.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Sep 2011 04:09:27 -0700 (PDT)
In-Reply-To: <4E65F701.9070304@ladisch.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Appalayagari Sreedhar <sreecha01@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 6, 2011 at 5:33 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Appalayagari Sreedhar wrote:
>> main.c:2:23: error: asoundlib.h: No such file or directory
>
> This means that alsa-lib is not installed correctly.

On Debian/Ubuntu, install a package called libasound2-dev
On SuSe, you can probably `zypper install -C 'pkgconfig(alsa)'` (I
think the -C is correct... for "capabilities")
On Fedora, it's `yum install 'pkgconfig(alsa)'`

-gabriel
