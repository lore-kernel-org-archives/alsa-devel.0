From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Sat, 20 Sep 2014 12:37:24 +0300
Message-ID: <541D4AD4.7040500@iki.fi>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>	<541A5BCD.2040105@canonical.com>
 <s5hlhph8jt5.wl-tiwai@suse.de> <541A8FA2.7090406@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
 <541C31EE.4020101@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992A81C@satlexdag05.amd.com>
 <541C6C23.1040403@canonical.com> <541C73C8.3040606@gmail.com>
 <541CBDB0.4020408@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.tpnet.fi (webmail.tpnet.fi [62.106.63.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 49173265647
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 11:37:25 +0200 (CEST)
In-Reply-To: <541CBDB0.4020408@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

20.09.2014, 02:35, David Henningsson kirjoitti:
> 
> 
> On 2014-09-19 20:19, Alexander E. Patrakov wrote:
>> 19.09.2014 23:47, David Henningsson wrote:
>>> If audio_enabled quickly changes to off and then on when there is a mode
>>> change, it might make sense to *not* wake up the audio driver in this
>>> case, as I assume that the audio capabilities on the HDMI TV will not
>>> change just because the video mode changes.
>>
>> Unfortunately, they will. Some low-resolution video modes just don't
>> have enough pixel clock to transfer the 7.1 audio signal at 192 kHz. See
>> the table on page 105 (shown as 121 in some readers) of
>> http://www.microprocessor.org/HDMISpecification13a.pdf , section "7.3.3
>> Video Dependency".
> 
> Ok, I stand corrected. I wonder what the least ugly thing to do would be 
> if the user is currently running audio when this happens, e g, if the 
> user is running a game with background music, and goes to "video 
> settings" and switches mode.
> 
> But if such thing would audio glitch anyhow, like it seems maybe we 
> should let the audio_enabled signal pass through to the audio side to 
> indicate a short disconnection. It's just not going to be that fun 
> if/when we implement reprobing the HDMI device on plug in. And also the 
> risk of the audio stream switching to somewhere else, like going from 
> HDMI to analog.

Note that I don't think this case is currently handled by any other
driver either. The HDMI audio driver doesn't know what video mode is
currently in use and what audio modes to disallow.

The EDID and therefore reported capabilities of the TV do not change.

-- 
Anssi Hannula
