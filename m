From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ALSA UCM
Date: Fri, 12 Nov 2010 16:42:20 +0000
Message-ID: <1289580140.3480.117.camel@odin>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
	<alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
	<1288897628.3277.99.camel@odin>
	<AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
	<1289046396.3318.53.camel@odin>
	<AANLkTina11GuK4jqP=DtD-OEjTiRtNa_yG0QKy7XDuxs@mail.gmail.com>
	<alpine.LNX.2.00.1011101608250.29422@eeebox2.perex-int.cz>
	<1289576480.3480.101.camel@odin>
	<alpine.LNX.2.00.1011121722090.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7216F10397A
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 17:42:23 +0100 (CET)
Received: by wyg36 with SMTP id 36so1233397wyg.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 08:42:23 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011121722090.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, abraham duenas <aduejazz@gmail.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-12 at 17:25 +0100, Jaroslav Kysela wrote:
> On Fri, 12 Nov 2010, Liam Girdwood wrote:
> 
> > On Wed, 2010-11-10 at 16:11 +0100, Jaroslav Kysela wrote:
> >> On Tue, 9 Nov 2010, abraham duenas wrote:
> >>
> >
> >>> I'm getting the expected error ONLY for the last element: listed in
> >>> the EnableSequence field:
> >>> e.g:
> >>> ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
> >>> 'name='DL2 Media Playback Volume' 90'
> >>> ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
> >>> 'name='MUX_UL10' 10'
> >>>
> >>> i'll keep on digging as time permits :)
> >>
> >> I fixed the sequence parser. It should work now ok. So the only missing
> >> part is to add the 'snd_ctl_*' backend for cset commands. The parsing
> >> functions for ctl strings are available in my ucm branch now:
> >
> > Is it the intention to reuse the cset functionality from amixer here ?
> 
> Yes, basically to avoid double ASCII syntax for same thing. I expect that 
> the amixer will be recoded to use parser functions implemented in 
> alsa-lib.

Ok, so with any luck this will mostly involve copy and pasting the cset
code from amixer and alsa-lib.

Thanks

Liam 
