From: Fons Adriaensen <fons@linuxaudio.org>
Subject: Re: hdsp rpm support
Date: Wed, 18 Jan 2012 10:26:58 +0000
Message-ID: <20120118102658.GA5351@linuxaudio.org>
References: <1326877559.24738.84.camel@yoyo4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.linuxaudio.org (bukvic.music.vt.edu [198.82.152.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 34F29244B4
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 11:27:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326877559.24738.84.camel@yoyo4>
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

On Wed, Jan 18, 2012 at 10:05:59AM +0100, Roman Haefeli wrote:

> I would like to know current state of the RME HDSP RPM support. There
> was a thread [1] in 2008 on this list about the issue and things looked
> promising back then. However, I'm still unable to upload the firmware
> with alsa-driver from git on my Ubuntu 11.04 (32bit) machine with a
> 2.6.38 kernel. I posted a detailed description of the issue on the
> alsa-user list here [2].

It seems that the developer of the driver - Adrian Knoth - has
two versions: one that works for me, and one that works for
another user. 

AFAICS, the problem is with the code that identifies the card
as an RPM, Multiface or Digiface, and that triggers ths HW into
accepting the firmware. Once past this point everything works
perfectly, including switching the phone preamps etc.

I've use it with both Cardbus and ExpressCard.

One more user would probably help...

Ciao,

-- 
FA

Vor uns liegt ein weites Tal, die Sonne scheint - ein Glitzerstrahl.
