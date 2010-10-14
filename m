From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 14:33:29 +0600
Message-ID: <4CB6C059.8060708@gmail.com>
References: <4CB68FC7.2060601@canonical.com> <4CB69FA4.9030702@gmail.com>
	<4CB6B5F3.9000700@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F50E103A3F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 10:33:29 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1884937ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 01:33:29 -0700 (PDT)
In-Reply-To: <4CB6B5F3.9000700@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I would say that advertising this pin correctly to the driver is the
> first step.
That's true.

> Trying to make the auto-parser treat this pin better would
> be a second step, separate from this patch.
Definitely. But changing autoconfiguration behavior for this particular 
case requires extensive testing to prove that changes made for subwoofer 
code haven't affected any other systems with no subwoofer at all (and I 
don't have enough hardware to do it myself). As I've said, I know no 
reliable way to determine that particular pin is connected to a 
subwoofer - it appears like just another speaker pin.

> Making a new model (if that
> is what you call a "preset") would work as well, and might be easier for
It's not mine :-) The struct to store all model parameters is called 
alc_config_preset. Anyway, I meant this very thing.

> this particular case, while improving the auto-parser would be better in
> the long run.
That's true. In fact, they are not mutually exclusive: adding new models 
will have the benefits I've outlined in the last message, while having 
auto-parser treat subwoofer correctly means broader support for new 
machines.

Valentine
