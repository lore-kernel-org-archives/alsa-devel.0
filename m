From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Maintaining sound card at a specific frequency
Date: Tue, 18 Jan 2005 13:22:23 -0800
Message-ID: <5bdc1c8b050118132267ade5f0@mail.gmail.com>
References: <1105938846.41eb499ec3527@www3.webhosting.cx>
	 <XFMail.20050118165036.pochini@shiny.it>
	 <s5hacr6wun5.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0501181822220.29107@denise.shiny.it>
	 <5bdc1c8b05011809454b58899c@mail.gmail.com>
	 <s5hk6qav7l7.wl@alsa2.suse.de>
Reply-To: Mark Knecht <markknecht@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6qav7l7.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Giuliano Pochini <pochini@denise.shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Jan 2005 20:51:48 +0100, Takashi Iwai <tiwai@suse.de> wrote:

> > Again, I think you're probably right about this issue for a completely
> > stand-alone system, but for a multi-PC system I think some sort of
> > plughw solution that resamples in software when necessary would work
> > better for me and Mozilla.
> 
> When the rate is locked in the system (as in my patch), plughw should
> work as you expected.
> 
> 
> Takashi
> 

Great! I hope we can find someone to test this out and get it into the
main Alsa flow. Then when it shows up through the Planet I'd be able
to test it out.

Thanks for your help,
Mark


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
