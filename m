From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Thu, 3 Jun 2010 13:09:31 +0100
Message-ID: <AANLkTikR9yUpTan-21XgpET_jqvd7oygSfUwkE5OVKGu@mail.gmail.com>
References: <hu6v9i$v43$1@dough.gmane.org>
	<AANLkTinxNwLVdaB9yR508esg-gwQJv2bMHkrUqhtVYwe@mail.gmail.com>
	<20100603112110.GB24589@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6BE4B24415
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 14:09:31 +0200 (CEST)
Received: by fxm18 with SMTP id 18so34032fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 05:09:31 -0700 (PDT)
In-Reply-To: <20100603112110.GB24589@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Stuart Longland <redhatter@gentoo.org>
List-Id: alsa-devel@alsa-project.org

On 3 June 2010 12:21, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jun 03, 2010 at 08:09:36AM +0100, James Courtier-Dutton wrote:
>
>> ALSA is not set up to convert bitfields to dB values.
>
> ASoC (which is what he's actually using here) is - most controls are
> defined as bitfields in the register map.
>

I was approaching it from the user space/kernel space divide.
The user space does not handle bitfields for controls, it uses integers.
The driver must therefore present the controls within the hardware as
integers to user space.
I thought he was having problems because the translation was not being
done in the driver, so user space was handling the value wrongly.
