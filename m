From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 6/7] S3C64XX PCM: Defined PCM controller
	platform devices
Date: Sun, 8 Nov 2009 09:40:17 +0900
Message-ID: <1b68c6790911071640w56737014i29766e28bda009c3@mail.gmail.com>
References: <1257384907-18338-1-git-send-email-jassi.brar@samsung.com>
	<20091106165406.GG4938@sirena.org.uk>
	<1b68c6790911061921o39e2609fwa7112f21ff916216@mail.gmail.com>
	<20091107121427.GB3228@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187])
	by alsa0.perex.cz (Postfix) with ESMTP id E4440103885
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 01:40:18 +0100 (CET)
Received: by pxi17 with SMTP id 17so370714pxi.16
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 16:40:17 -0800 (PST)
In-Reply-To: <20091107121427.GB3228@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 7, 2009 at 9:14 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Nov 07, 2009 at 12:21:43PM +0900, jassi brar wrote:
>> On Sat, Nov 7, 2009 at 1:54 AM, Mark Brown
>
>> > Might be good to call the devices "samsung-pcm" rather than "s3c-pcm" or
>> > whatever the decision is on a common prefix to cope with the s5p CPUs.
>
>> Well, pcm_<version> wud be even better.
>> with 'samsung-pcm' we run out of a good option if the newer SoCs come with
>> different version of the PCM Controller.
>
> That'd be fine as well, though I don't see a problem with omitting the
> version just now and then adding a second file with a version appended
> if a second version does crop up.



Thanks for the feedback. I will wait for Ben's review of the patches
before making
final changes and re-submitting.
