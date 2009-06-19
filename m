From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: RFC: Jack-detection control elements on HD-audio
Date: Fri, 19 Jun 2009 14:34:29 +0200
Message-ID: <20090619123429.GB5785@tango.0pointer.de>
References: <s5hk538ejj4.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0906191048150.3983@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A935D244D8
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 14:34:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0906191048150.3983@eeebox2.perex-int.cz>
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

On Fri, 19.06.09 10:54, Jaroslav Kysela (perex@perex.cz) wrote:

Heya,

> > yet another thing I've worked recently on is a bit more generalized
> > framework for jack-sense reporting for HD-audio.  This supersedes the
> > existing jack-sense reporting via the input layer.  In addition, it
> > gives the corresponding control elements.
> >
> > For example, you'll have "Jack HP-Out" (or a bit more verbose like
> > "Jack HP-Out at Ext Rear") control via control API as well as other
> > mixer controls.  This can notify when a jack is plugged/unplugged.
> > But, another big win is that you can read the current pin sense just
> > by reading this element.
> 
> Before definining such extension, I would really see to define standard 
> control names in Documentation/ControlNames.txt file. It seems to me that 
> most new drivers does not follow suggested naming. The document should be 
> reviewed, of course.

Oh yes, please!

I have recently reworked PA to control the mixer a bit more
comprehensively, including doing input source selection stuff and
suchlike. For that I made a little survey on all current drivers how
they name things. Was a bit disappointing, for example for "Input
Source"/"Capture Source" we have at least
options by these names:

Analog
Analog Inputs
AOUT
Aux
AUX
Aux0
Aux1
Aux2
Aux3
Aux In
AUX IN
Cam Mic
Digital Mic
Digital Mic 1
Digital Mic 2
D-Mic
Docking-Station
Dock Mic
e-Mic
E-Mic
ExtMic
Ext Mic
FM
Front Mic
Front Microphone
iMic
i-Mic
Input1
Input2
Int DMic
Internal Mic
Internal Microphone
IntMic
Int Mic
Line
LineIn
Line In
Line-In
Line/Mic
Mic
Mic1
Mic2
Mic/Line
Microphone
Rear Mic
TV Tuner
Unknown1
Unknown2
Video

Shouldn't be too difficult to agree on standard names for most of
these.

I'll post abit more about my findings later.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
