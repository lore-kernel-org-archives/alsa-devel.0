From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: ASoC, TWL4030 Register defaults
Date: Thu, 20 Nov 2008 07:55:07 -0800
Message-ID: <5e088bd90811200755gd372e24jc805e158c91ebe25@mail.gmail.com>
References: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
	<20081120112304.GB4539@sirena.org.uk>
	<ef0d8a250811200351x3d18ea1fm58e9dac3613aeea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FA9024403
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 16:55:10 +0100 (CET)
Received: by hs-out-0708.google.com with SMTP id x43so279879hsb.0
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 07:55:09 -0800 (PST)
In-Reply-To: <ef0d8a250811200351x3d18ea1fm58e9dac3613aeea9@mail.gmail.com>
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
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 3:51 AM, naveen krishna ch
<naveenkrishna.ch@gmail.com> wrote:
> On Thu, Nov 20, 2008 at 4:53 PM, Mark Brown <broonie@sirena.org.uk> wrote:

>> As I said in reply to your first mail I'd really like to see some sort
>> of explanation as to why you are making these changes - are the defaults
>> in the existing driver wrong?  There seem to be an awful lot of changes
>> here and there's no discussion in the patch as to what they mean.
>
> The existing driver does the default settings for only one input device
> (Line in) and one output device (Headset out).
> The CODEC supports 5 output devices and 4 input devices.
>
> The default values given by the drivers author are according to his custom
> requirements, expanding them to the CODEC's ability these values can be
> modified.
>
> What all this patch is doing is setting the default playback and capture
> volumes of various input and output devices to reasonable values.

These seem like reasonable default values for features the driver
previously did not use.

Couldn't verify that there are no side effects by build & run testing
since the patch wouldn't apply for me.

Steve
