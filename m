From: Frank Barknecht <fbar@footils.org>
Subject: Re: SoundCard compatibility question
Date: Fri, 21 Mar 2003 13:55:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030321125557.GA2346@fliwatut.scifi>
References: <002101c2ef22$0f249f20$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <002101c2ef22$0f249f20$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Pete Barnard hat gesagt: // Pete Barnard wrote:

> I have just installed Red Hat Linux 7.3 on my pc at work and will be
> installing the ALSA drivers.  However, the sound card is described
> as a "SoundMax integrated Audio" (I don't really know much about
> this card and cannot find it on the ALSA soundcard matrix).   I have
> read that it is a SoundBlaster compatible card but I haven't had
> this confirmed.  Does anybody have any suggestions as to how I would
> get ALSA to work with this card? for example, what lines do I need
> to put in the /etc/modules.conf file? and what options do I need to
> type when I do a ./configure for the drivers? Are there any external
> drivers that I need to download etc?

With a lot of cards, and most onboard chipsets, it is important to
know, which chipset is used. You can try to find this out with
"lspci". It prints a long list that you should search for Multimedia
or Audio adapters. Then look for a module called somehow like it and
try to modprobe it. 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
