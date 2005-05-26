From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Thu, 26 May 2005 00:58:41 -0700
Message-ID: <20050526005841.08a8aae0.akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<200505252243.21092.tomlins@cam.org>
	<20050525204107.722504bd.akpm@osdl.org>
	<1117093392l.17165l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1117093392l.17165l.0l@werewolf.able.es>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: tomlins@cam.org, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> On 05.26, Andrew Morton wrote:
> > 
> > (Added alsa-devel to cc)
> > 
> > Ed Tomlinson <tomlins@cam.org> wrote:
> > > 
> > > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
> > > 
> 
> Me too. As beep-media-player ends playing a mp3 track, oops !

hm, OK, you're also on x86_64.  What sound card and driver?

> Decoded below, for if it gives additional info:

Actually, no, ksymoops removes info.  Please just send the kernel's oops
output directly.  (Make sure that CONFIG_KALLSYMS=y).



-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
