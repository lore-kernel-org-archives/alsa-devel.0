From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Ideas for the softvol plugin
Date: Thu, 11 Jan 2007 15:54:55 +0100
Message-ID: <45A64FBF.5070503@ingomueller.net>
References: <70a871c80701092048v23fbf0d8yc40d434eab023506@mail.gmail.com>
	<70a871c80701101406y3f8293e9sd57b1d4c5ba9b166@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80701101406y3f8293e9sd57b1d4c5ba9b166@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I have some ideas about features that could be added to the softvol
plugin, that I want to discuss with you.

1) A mute/unmute function. I think this is the most easy job.

2) Ability to replace an existing control. I have no idea whether it is
possible to realize this, but this would be very usefull (see below).

3) Multi channel capabilities. This is just a vague idea. The aim is to
be able to control e.g. front, rear and center/lfe channels seperately
from each other. Maybe like this:

pcm.softvol {
    type softvol
    slave {
        pcm "hw:0,1"
    }
    controls [
        {
            name "SoftFront"
            affects [ 0 1 ]
        }
        {
            name "SoftRear"
            affects [ 2 3 ]
        }
        {
            name "SoftCenterLfe"
            affects [ 4 5 ]
        }
    ]
}

All the three suggestions aim to solve one frequent problem (it occured
with EVERY sound card I ever had (~5) and forums are full of them): The
volume control elements don't control the volume like they are supposed
to. E.g. I've seen so many people whose Master control only affects the
volume of the front channels. With the above changes, one could just
rebuild a software based volume control system without having to worry
whether the hardware controls are supported or not.

Right now, one can create a softvol device, create a control named
"Softmaster" and make every application use this device. AFAIK, there's
is no mute function. I don't need to explain why this would be usefull.
What can't be done is name this control "Master" (unless this control
doesn't exist yet). Many media applications have a function to control
the volume, but most of them just control the master volume, so ones
"Softmaster" would not be touched by them.

Well the multichannel capabilities are not that important. It's just an
idea, like I said. With some cards, I was able to realize the same
functionality with softvol in combination with the multi plugin, on
other I wasn't. I just think that this would be the cleanest way to do it.

Finally, I wanted to mention, that I am not a developper of any sort,
but as I user, I am always trying to improve things (see my work on the
alsa wiki). I hope some of you think about my suggestions anyway!

Greets, Ingo

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
