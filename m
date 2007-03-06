From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Hello/EMU 0404 USB driver
Date: Tue, 6 Mar 2007 18:23:25 -0500
Message-ID: <75b66ecd0703061523r152b9476lde29161fa57107f0@mail.gmail.com>
References: <45EDF4C7.30704@bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45EDF4C7.30704@bham.ac.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Martin Wilson <mpw473@bham.ac.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/6/07, Martin Wilson <mpw473@bham.ac.uk> wrote:
> Hi all,
>
> a EMU
> 0404 USB which is a very good card.  I would like to use something like
> Ubuntu studio instead of OSX for making music, however the sticking
> point is the driver for this particular piece of hardware.  Looking
> around forums it looks like I'm not the only one who has come across
> this problem, so I have the following questions...
> 1. What is the biggest obstacle for this driver becoming a reality?

If the device is class compliant (aka does not require a driver to be
installed on OSX or Windows) then it's very easy.  Otherwise it's very
hard without detailed hardware specs.

> 2. Do creative play nicely with releasing the specifics of how their
> hardware works?

Sometimes.  They've helped with the EMU1212 series and CA0106 (SBLive!
24 bit) but won't help with the X-Fi.

> 3. What is the best way to learn how to write drivers for sound cards
> (I've ordered the 'Linux Device drivers' book for an overview)?

Read "Writing an ALSA driver" and refer to the source code of existing
drivers such as snd-usb-audio.

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
