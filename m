From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 15:14:59 +0200
Message-ID: <4E54F953.2060209@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>	<4E53959A.7090702@amlie.name>	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>	<4E53A748.4070404@amlie.name>	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>	<4E53AAE4.2070303@amlie.name>	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>	<4E54B1A5.5080507@amlie.name>	<CACTFLAPkyYNxRkd=9R12U8_dBbkJQZ=LSXr9a8au_Kfc5R78fQ@mail.gmail.com>	<4E54CF09.90001@amlie.name>
	<CACTFLAPMg75au0VX_rAF3dLRsSyX8Wex+LFj7pfPXygvZrR7qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy4-pub.bluehost.com (oproxy4-pub.bluehost.com
	[69.89.21.11]) by alsa0.perex.cz (Postfix) with SMTP id E491624676
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 15:15:23 +0200 (CEST)
In-Reply-To: <CACTFLAPMg75au0VX_rAF3dLRsSyX8Wex+LFj7pfPXygvZrR7qw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 08/24/11 12:29, Daniel Mack wrote:
> Ok - can you play around with these commands and add them to the MIDI
> driver? The stubs are all there now, and  I think all that's missing
> is the termios call and maybe write_latency_timer(). I could prepare
> another patch, but I think it's faster if you just try around which
> command sequence helps :)

I have tried to replicate the control messages to the best of my
ability, but I'm still getting no MIDI events. The actual values in the
stream may still be wrong (as per Clemens' email), so is there anywhere
I can hook into to see if I get any USB activity *at all*?

-- 
Kristian
