From: Roman Haefeli <reduzent@gmail.com>
Subject: Re: hdsp rpm support
Date: Mon, 01 Oct 2012 01:04:02 +0200
Message-ID: <1349046242.2195.6.camel@yoyo5>
References: <1326877559.24738.84.camel@yoyo4>
 <20120118102658.GA5351@linuxaudio.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id D642B2616C8
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2012 01:04:05 +0200 (CEST)
Received: by mail-wi0-f173.google.com with SMTP id hm4so1508837wib.2
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2012 16:04:05 -0700 (PDT)
In-Reply-To: <20120118102658.GA5351@linuxaudio.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mit, 2012-01-18 at 10:26 +0000, Fons Adriaensen wrote:
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

How are you able to switch the phone preamps? Even in the git version of
hdspconf, there is no mentioning of the RPM at all. To me it looks there
isn't any support at all in hdspconf for HDSP RPM. Do you have some
unofficial version of hdspconf that _does_ support the RPM?

OTOH, hdspmixer seems to recognize the card correctly, once the firmware
is loaded. 
 
> I've use it with both Cardbus and ExpressCard.
> 
> One more user would probably help...

I am on Ubuntu 12.04 now, and since I still couldn't make the firmware
get loaded in linux, I decided to install Windows XP (again) just for
this task. 

Roman
