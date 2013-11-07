From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [ALSA UCM] Help me obtain complete document of alsa ucm
Date: Thu, 7 Nov 2013 16:55:08 +0800
Message-ID: <CAHa2TOYc5cVeQYJF6d7CKJC0YFh6zFvp0cF5awZ=a50=rzZXSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 38825260376
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 09:55:09 +0100 (CET)
Received: by mail-wi0-f175.google.com with SMTP id hm4so281515wib.2
 for <alsa-devel@alsa-project.org>; Thu, 07 Nov 2013 00:55:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,
When I develop ALSA UCM for my target platform.
I've stocked by lack syntax description.

I already know how to use some syntax of alsa ucm like "EnableSequence" and
"DisableSequence" in "SectionVerb".
So I can use alsa commands like

*alsaucm -c EVB set _verb HiFi set _enadev Headphones*

*alsaucm -c EVB set _verb HiFi set _disdev Headphones*
to enable or disable our Headphones devices.

In addition to, I add some setting like
*ATTRS{id}=="EVBsnd", RUN+="/usr/bin/alsaucm -c MB8AC0300 set _verb HiFi"*
*ATTRS{id}=="EVBsnd", RUN+="/usr/bin/alsaucm -c MB8AC0300 set _verb Record"*
in 90-alsa-ucm.rules file.

But I don't know how to correctly use some syntax (such as
"ConflictingDevice", "TransitionSequence", "Value" and so on) of alsa ucm.
I refer to Use Case Manager in ALSA document.
http://www.alsa-project.org/main/index.php/Use_Case_Manager
Unfortunately, it cannot resolve my questions.

Do you have more detail information about ALSA UCM syntax usage
documentation or example?
Thank you very much.

-Xavier Hsu-
