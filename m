From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] El Cheapo: Works, but some open questions still.
Date: Thu, 09 Dec 2004 13:10:39 -0500
Message-ID: <1102615839.21390.8.camel@krustophenia.net>
References: <1102567773702.timo.sivula.1129.qHy8HBgpm3EHdIbzvfsntQ@luukku.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1102567773702.timo.sivula.1129.qHy8HBgpm3EHdIbzvfsntQ@luukku.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Timo Sivula <timo.sivula@luukku.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-12-09 at 06:49 +0200, Timo Sivula wrote:
> Lee Revell kirjoitti 09.12.2004 kello 02:31:
> 
> > No.  You need to get into the driver and figure out what's going on.
> > Add some printk()s to the driver to measure the delay in starting the
> > devices.
> 
> Help! I am comfortable removing a couple of crystals from a souncard and soldering in some wire, but adding one line of text in a source code file makes me very insecure. 
> 
> Could you give me some hands on advice on how to do this? Which file? Where exactly do I insert the text, etc...
> 
> My software competence is, ahem, somewhat limited.

Heh, you might just have to learn :-).  I had never hacked the kernel or
even done any serious C programming when I went to implement
multichannel support for the emu10k1 driver.  Now, several months and a
1000 line patch later it (almost) works.

The best way to start is to take this guide:

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/

and go through the guide, step by step, with the source code for your
driver in hand.

Sorry there's no easy way.  If you want to do something this tricky
that's never been done I think you will have to bite the bullet and try
to grok the soruce code.

To examine the start times, look at the trigger callback.  This is all
explained in Takashi's driver guide.  Just grep for printk and see how
the current drivers use it for debugging.  

I can't really give you any specific help because I an not familiar with
the driver or hardware you are using. 

Lee


  



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
