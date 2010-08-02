From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: underruns and POLLERR when copying audio frames
Date: Sun, 1 Aug 2010 20:02:36 -0700
Message-ID: <AANLkTikvuB2UXGRSQuarSLVtGP-zSM=mnzfRToArVkQ8@mail.gmail.com>
References: <4C4581D9.8020309@gmail.com> <4C45A77B.4070802@ladisch.de>
	<4C462827.10105@gmail.com> <4C469CAC.3030202@ladisch.de>
	<4C46C9DA.6010401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B52DD2442F
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 05:02:37 +0200 (CEST)
Received: by iwn39 with SMTP id 39so4112302iwn.38
	for <alsa-devel@alsa-project.org>; Sun, 01 Aug 2010 20:02:36 -0700 (PDT)
In-Reply-To: <4C46C9DA.6010401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> For now I will just add buffering and hope that the buffer is big enough
> =A0so that there will be no xruns for reasonable long amounts of time.
> In case I get troubles anyway, is there some kind of way to synchronize
> clocks between the ALSA stack running on one system with the stack on
> another system ?

You cannot 'synchronize' clocks. The only option is to generate the
relevant number of samples to compensate for the drift.
This can be done by adding/dropping samples, time stretching or
fractional resampling (by order of complexity).
You may want to try gstreamer for this type of use cases (gst-launch
alsasrc ! alsasink), the drift between incoming and outgoing samples
is tracked and some configurable resampling can be done. Or
module-loopback in PulseAudio if it's installed on your system.
