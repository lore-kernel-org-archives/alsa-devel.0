From: =?UTF-8?B?0KDQsNC00L7RgdC70LDQsiDQndC10L3Rh9C+0LLRgdC60Lg=?=
 <stalliondrift@gmail.com>
Subject: A bug in the alsa project
Date: Sat, 23 Feb 2019 11:06:52 +0200
Message-ID: <09c70d81-aeb3-36aa-3cc0-0b7c354a4862@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6C07F80771
 for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2019 10:06:55 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id i12so4835385wrw.0
 for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2019 01:06:55 -0800 (PST)
Received: from [192.168.0.101] ([188.126.4.208])
 by smtp.gmail.com with ESMTPSA id n6sm3352847wrt.23.2019.02.23.01.06.53
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 01:06:53 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

*Hi. I think I found a bug in the ALSA project which doesn't seem to be 
kernel related, since it occurs with all kernels I've tried so far. It's 
about the area where one can select the output - Stereo, 2.1, 4.0 and so 
on. I have a 2.1 audio system - 2 speakers and a subwoofer (Microlab 
M-300U). If I choose 5.1 Analog Output, the subwoofer works great and 
the audio has great bass for music. However, if I choose anything else 
that is not 5.1 (that includes the output for my system - 2.1), the 
subwoofer stops working and the output sounds like I'm using cheap 
speakers for $1. This is part 1 of the bug. Part 2 is that when I'm 
watching movies using the 5.1 Output, some of the movie sounds are 
missing because ALSA transfers them to the non-existing speakers. It's 
also interesting that with 5.1 Analog Output listening to music 
(Audacious) the sound is perfect - no missing parts and stuff, the 
problem happens only when I'm watching movies. I tried different media 
players but it's the same with all of them.*

*If there's any additional information I could give you, such as 
hardware info, please let me know.*
