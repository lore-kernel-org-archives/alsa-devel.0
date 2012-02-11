From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: Bug report - patch_realtek.c - Laptop HP COMPAQ
	B1900 Series
Date: Sat, 11 Feb 2012 12:35:02 +1030
Message-ID: <20120211020502.GA25041@marvin.atrad.com.au>
References: <4F35C191.9080401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 046702451F
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 03:05:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F35C191.9080401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "joey.jiaojg" <joey.jiaojg@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, pshou@realtek.com.tw, kailang@realtek.com.tw, jwoithe@just42.net
List-Id: alsa-devel@alsa-project.org

Hi Joey

For future reference, please email reports like this to the alsa-devel list. 
The relevant developers are far more likely to respond to messages on the
list than they are to messages sent privately.

I have copied this to the list to maximise its distribution.

On Sat, Feb 11, 2012 at 09:17:05AM +0800, joey.jiaojg wrote:
> I'm reporting a bug related to ALSA and ALC260, which perhaps only
> you can solve. Appreciate if you can check.
> We got a lot of users using HP COMPAQ B1900 series which using ATI
> SB450 and ALC260 for linux systems like Debian, Ubuntu and etc. The
> problem is that there is no sound from speaker while enable
> model=will can hear from earphone. The problem and alsa-info.txt is
> reported here https://answers.launchpad.net/ubuntu/+source/alsa-driver/+question/186698,
> which thought be a bug of ALC260 driver bug.
> Hope you can check what we can do to solve it.

>From the above I am not entirely sure what the problem is.  You seem to be
talking about two separate conditions.  In the first (where I presume the
module is loaded without any parameters you say there's no sound from the
speaker.  Do other aspects of the card work correctly in this case?

The second situation is where "model=will" is specified as a module
parameter.  Here you say you can get audio from the headphone, but again
what about other aspects of the soundcard - do they work normally?

At a rough guess, it sounds like there are two underlying issues.  The first
is that this system requires some model-specific handing in order to map
chip outputs correctly.  The second is that if such model-specific details
are required then the driver preferrably would activate these automatically
without the need to specify "model=will".

Another possibility is that there is something about this laptop system
which is confusing the auto-probing of the alc260 codec code.

I'm not sure what is the best way of proceeding here.  I suspect other more
active developers will have a streamlined approach to help rectify the
trouble.  In the first instance I would tend to load the module with
"model=test" and experiment with the resulting alsamixer controls to
determine what chip outputs are connected to which pins.  However, this is
quite "old school" now - while it's the approach I used when getting my
system working, my impression is that its use has been mostly deprecated by
the automatic parser which is now present.

In the above-referenced launchpad report the question is asked about the
ALC260 datasheet.  This is readily available on the net.  I doubt it is all
that necessary now since I think the base infrastructure is pretty solid,
but if you do need it and have difficulty finding it please contact me
off-list.

Regards
  jonathan
