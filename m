From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Wed, 30 Jan 2013 11:30:07 +0100
Message-ID: <5108F62F.9080503@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <5107CA3E.9000104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 94F21261718
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 11:30:07 +0100 (CET)
In-Reply-To: <5107CA3E.9000104@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 29.1.2013 14:10, Jonas Petersen wrote:
> 
> If I switch 'Multi Track Internal Clock' to 'IEC958 In', the whole
> system goes crazy. Not instantly, but when I start alsamixer it locks up
> (only alsamixer, it can not be killed -9 then). When doing 'ps -aux' it
> locks up somewhere in the middle of the list.
> This is all with a signal going in the spdif input.
> When I reboot (still with signal), the login screen locks up. I can move
> the mouse, but I can not input the password. Also the background image
> does not load (which normally does). I can switch to another terminal
> (e.g. ctrl-alt-f1) and log in. But it will hang sooner or later.
> No way switch back the 'Multi Track Internal Clock' to a fixed rate.
> Only if I disconnect the signal from the spdif input and reboot, then I
> can switch it back and bring the system back to reason. Pew...

Thanks a lot for the description. I faintly recall I have heard about
this problem once (but never got hold of the reporter to solve). I will
take a look, and most likely ask you for more troubleshooting as I do
not have the card available. Thanks a lot.

Pavel.
