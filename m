From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Listing raw midi devices "The Right Way"?
Date: Wed, 18 Jun 2008 17:51:57 +0200
Message-ID: <48592F1D.7020902@ladisch.de>
References: <48591B5A.9070808@ladisch.de> <1213803825.3771.25.camel@nixbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8071224443
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 17:52:00 +0200 (CEST)
In-Reply-To: <1213803825.3771.25.camel@nixbox>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jacob Ole Juul Kolding <dacobi@juvul.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jacob Ole Juul Kolding wrote:
> On Wed, 2008-06-18 at 16:27 +0200, Clemens Ladisch wrote:
> > You probably should be using the sequencer instead of the raw MIDI
> > interface,
>
> I'm not sure if sequencer is to high level,
> all i need is a way to capture all incoming midi events
> which then will be placed in an existing database system.
>
> Currently in OS X and in windows I have a callback that reads each
> midi event for each port as a list of 3 bytes which are then added to a
> C++ STL vector for later processing.

If you actually want to get the raw MIDI bytes, using the raw MIDI
interface is The Right Way.


Regards,
Clemens
