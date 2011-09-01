From: Daniel Mack <daniel@zonque.org>
Subject: Re: A debug version of the ALSA lib?
Date: Thu, 1 Sep 2011 10:50:33 +0200
Message-ID: <CACTFLAPNhWX6t00du=CtCMnR2adjsbMKK3v=HMmc8ivJMv7h8Q@mail.gmail.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5393124765
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 10:50:35 +0200 (CEST)
Received: by ywt32 with SMTP id 32so1236286ywt.38
	for <alsa-devel@alsa-project.org>; Thu, 01 Sep 2011 01:50:33 -0700 (PDT)
In-Reply-To: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olivier Guillion - Myriad <olivier@myriad-online.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 1, 2011 at 10:37 AM, Olivier Guillion - Myriad
<olivier@myriad-online.com> wrote:
> To be able to go further, I'd need a debug version of the ALSA library,
> including variable names and source lines, which could let me find more easily
> what goes wrong and when.
>
> Is it possible to build such a library from the alsa-lib-1.0.24.1 sources?
> Or should I download and install another specific package?

The sources are the same. Whether you'll get a library with debug
symbols depends on the compile time options when building the lib. And
depending on your distribution, you might also be able to install the
debug-enabled version by choosing the -dbg package derivat.


Daniel
