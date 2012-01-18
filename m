From: Roman Haefeli <reduzent@gmail.com>
Subject: Re: hdsp rpm support
Date: Wed, 18 Jan 2012 11:54:00 +0100
Message-ID: <1326884040.18308.6.camel@yoyo4>
References: <1326877559.24738.84.camel@yoyo4>
	<20120118102658.GA5351@linuxaudio.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 41E8A103AB6
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 11:54:03 +0100 (CET)
Received: by wera13 with SMTP id a13so2181600wer.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 02:54:03 -0800 (PST)
In-Reply-To: <20120118102658.GA5351@linuxaudio.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fons Adriaensen <fons@linuxaudio.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Fons

I'm glad to hear about people having success with this issue.

On Wed, 2012-01-18 at 10:26 +0000, Fons Adriaensen wrote:
> On Wed, Jan 18, 2012 at 10:05:59AM +0100, Roman Haefeli wrote:
> 
> > I would like to know current state of the RME HDSP RPM support. There
> > was a thread [1] in 2008 on this list about the issue and things looked
> > promising back then. However, I'm still unable to upload the firmware
> > with alsa-driver from git on my Ubuntu 11.04 (32bit) machine with a
> > 2.6.38 kernel. I posted a detailed description of the issue on the
> > alsa-user list here [2].
> 
> It seems that the developer of the driver - Adrian Knoth - has
> two versions: one that works for me, and one that works for
> another user. 
> 
> AFAICS, the problem is with the code that identifies the card
> as an RPM, Multiface or Digiface, and that triggers ths HW into
> accepting the firmware. Once past this point everything works
> perfectly, including switching the phone preamps etc.

I can confirm this. When I upload the firmware with Windows, I can fully
use the card and a recent 'hdspmixer' shows me the correct number of
channels. However, the culprit seems to be uploading the firmware. 

> I've use it with both Cardbus and ExpressCard.

Good to hear.

May I ask kindly for the 'other' version of the driver, which I would be
happy to test?

> 
> One more user would probably help...

I'm willing to test and report back (as much as I can as a non-dev).

Roman
