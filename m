From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: programming with dmix ?
Date: Thu, 19 Jun 2003 22:14:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306192213320.1930-100000@pnote.perex-int.cz>
References: <20030619184036.62520.qmail@web40904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030619184036.62520.qmail@web40904.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alex Kuang <alex_sfu@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Jun 2003, Alex Kuang wrote:

> Hi there,
> 
> Just wondered how I can apply the cool feature - dmix
> - to my own program to mix sounds? for example, after
> I compile my small c++ program, I can run it one at a
> time:
> 
> ./a.out TestMusic.wav
> 
> The thing's that how I can mix sounds when I run:
> 
> ./a.out TestMusic01.wav &
> ./a.out TestMusic02.wav &
> ./a.out TestMusic03.wav &
> 
> Thank you very much,

Simply use different pcm name as argument to snd_pcm_open().
Replace 'default' with 'plug:dmix'.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
