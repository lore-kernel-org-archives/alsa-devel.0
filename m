From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: alsa rtctimer not compiled when having rtc as a module
Date: Thu, 4 Apr 2002 05:38:24 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020404053824.0d7f468f.coding@reduz.com.ar>
References: <20020403065236.773322f9.coding@reduz.com.ar>
	<Pine.LNX.4.33.0204041001510.891-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.33.0204041001510.891-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Apr 2002 10:02:23 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> On Wed, 3 Apr 2002, Juan Linietsky wrote:
> 
> > On Tue, 02 Apr 2002 16:15:04 +0200
> > root <root@iua.upf.es> wrote:
> > 
> > > 
> > > Hello,
> > > 
> > > I noticed that the alsa rtctimer is not compiled when you have
> > > the RTC in your kernel as a module. The problem is in 
> > > alsa-kernel/core/Makefile, where CONFIG_RTC is tested for y
> > > and not for m.
> > > 
> > > Maarten
> > > 
> > 
> > talking about this.. if alsa uses RTC, then i cant use it on other
> > programs while alsa does? are we talking /dev/rtc? (int 8)
> 
> It's right, access to RTC timer is exclusive, but you can still use ALSA 
> timer API to access RTC timer.

Ahh that's fine then. I just hope ALSA doesnt suffer from the horrible
timer inconsistence problems i experienced with the OSS timers, which i couldnt keep in tempo. I'll give it a try, thanks!!

Juan Linietsky
