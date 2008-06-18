From: Jacob Ole Juul Kolding <dacobi@juvul.com>
Subject: Re: Listing raw midi devices "The Right Way"?
Date: Wed, 18 Jun 2008 17:43:45 +0200
Message-ID: <1213803825.3771.25.camel@nixbox>
References: <48591B5A.9070808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zentipede.dk (unknown [81.161.181.194])
	by alsa0.perex.cz (Postfix) with ESMTP id CA4F82444D
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 17:43:50 +0200 (CEST)
In-Reply-To: <48591B5A.9070808@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-06-18 at 16:27 +0200, Clemens Ladisch wrote:
> Jacob Ole Juul Kolding wrote:
> > I already found a code example that reads raw midi packages form a
> > specified device but I need to have a complete list of ALL raw midi
> > capable devices and ports on the system.
> >
> > What is the "Right Way" for an app to build such a list?
> 
> See the source code of amidi.
> 
> You probably should be using the sequencer instead of the raw MIDI
> interface, in which case look at the source code of arecordmidi.
> 

I'm not sure if sequencer is to high level, 
all i need is a way to capture all incoming midi events
which then will be placed in an existing database system.

Currently in OS X and in windows I have a callback that reads each 
midi event for each port as a list of 3 bytes which are then added to a 
C++ STL vector for later processing.

How could something similar be done with alsa?

/Jacob Kolding
> HTH
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
