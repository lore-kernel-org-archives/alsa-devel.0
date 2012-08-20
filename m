From: James Warden <warjamy@yahoo.com>
Subject: Can module snd-aloop (virtual looback device) be made
	clock slave of a real audio device ?
Date: Mon, 20 Aug 2012 02:51:55 -0700 (PDT)
Message-ID: <1345456315.34107.YahooMailNeo@web39304.mail.mud.yahoo.com>
Reply-To: James Warden <warjamy@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm10.bullet.mail.ac4.yahoo.com (nm10.bullet.mail.ac4.yahoo.com
 [98.139.52.207]) by alsa0.perex.cz (Postfix) with SMTP id 85888265DB0
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 11:22:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello alsa-devel's,

A while back, I had written a rather hackish method to hook up the ALSA virtual loopback device to jack (jackaudio.org) via Jack clients alsa_in / alsa_out so that non jack-aware applications that can however use ALSA devices "directly" (via alsa-lib) can have their audio stream redirected to jack (see my rather lengthy prose at http://alsa.opensrc.org/Jack_and_Loopback_device_as_Alsa-to-Jack_bridge).

There are a few advantages in this method (depends on your use-cases of course). But it could be improved (or so I think) by removing the following drawbacks:

The alsa_in/out jack clients are resampling the audio stream to synchronize with the device that jack is using. The resampling, done by libsamplerate, takes some CPU power. Since many users are using my recipe on laptops, this is not always welcome. 

Because snd-aloop is a virtual device, couldn't it be made a clock slave of the h/w device that jack is operating on ? This would in principle remove the need for resampling. I could imagine that the module could be passed an option at loading time (e.g. modprobe snd-aloop clock-master=<real h/w device index> or something like that)


Since I have no clue as to the kernel code required to implement / extend snd-aloop, I would like some opinions about this.


Thanks for any hints.

J.
