From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Tue, 21 Jun 2011 13:38:12 +0200
Message-ID: <4E0082A4.2030201@canonical.com>
References: <s5hvcw04k50.wl%tiwai@suse.de>	<4E006BEC.7010202@canonical.com>
	<s5hei2n4fdq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id ED0F324498
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 13:38:14 +0200 (CEST)
In-Reply-To: <s5hei2n4fdq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, alex.baldacchino.alsasub@gmail.com, haraldwelte@viatech.com, lydiawang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

On 2011-06-21 13:01, Takashi Iwai wrote:
>> There are no input jack devices either (i e those we're debating in the
>> other thread).
>
> I haven't tracked this fully yet; can anyone give a short summary
> and alsa-info.sh output of the affected system?

I mean, there are no calls to snd_hda_input_jack_* from patch_via.c yet.

You should have received alsa-info in a private email by now.

>> On the input side I notice a minor thing: "Front Mic Playback Volume"
>> has an unneccessary index on it. Well, the Front mic is actually an
>> internal mic, but that's BIOS lying to us, I guess.
>
> Fixed now in topic/via-cleanup branch.
> Also the smart51 detection and some output-path initializations were
> fixed.

Btw, I have not tested the smart51 / independent HP stuff.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
