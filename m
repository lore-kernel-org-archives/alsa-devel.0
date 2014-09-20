From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Sat, 20 Sep 2014 15:31:01 +0600
Message-ID: <541D4955.6040708@gmail.com>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>	<541A5BCD.2040105@canonical.com>
 <s5hlhph8jt5.wl-tiwai@suse.de> <541A8FA2.7090406@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
 <541C31EE.4020101@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992A81C@satlexdag05.amd.com>
 <541C6C23.1040403@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992AB48@satlexdag05.amd.com>
 <541CC506.601@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A7B19265647
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 11:31:04 +0200 (CEST)
Received: by mail-la0-f54.google.com with SMTP id ge10so4282383lab.41
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 02:31:04 -0700 (PDT)
In-Reply-To: <541CC506.601@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Takashi Iwai <tiwai@suse.de>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

20.09.2014 06:06, David Henningsson wrote:
>  From the audio driver's point of view, if you have 1 audio pin, then
> that's one display. Presence detect, as well as ELD information, should
> reflect the status of that one display.
>
> How to multiplex that against several audio capable monitors is tricky,
> but it's something you have to solve on the video driver side.
> I'm not sure how other video drivers have solved that, or if AMD/ATI is
> the only manufacturer who has cards with this hw design (i e fewer audio
> pins than audio capable outputs).

A similar problem exists for Intel on Haswell, and here is how they 
solved it.

They have three HDMI outputs, but only two audio pins. Audio can be 
routed to any two of the three connected monitors. This is done by 
opening the following PCMs: hdmi:0,0, hdmi:0,1 and hdmi:0,2, with 1:1 
correspondence to the physical outputs. I.e. the driver pretends that 
there are three subdevices. However, only two of them (any two) can be 
opened simultaneously. The third one gives -EBUSY on attempts to open it.

-- 
Alexander E. Patrakov
