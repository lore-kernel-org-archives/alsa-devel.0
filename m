From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: alsa rtctimer not compiled when having rtc as a module
Date: Wed, 3 Apr 2002 06:52:36 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020403065236.773322f9.coding@reduz.com.ar>
References: <E16sP3w-0006Zx-00@bitone.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <E16sP3w-0006Zx-00@bitone.upf.es>
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

On Tue, 02 Apr 2002 16:15:04 +0200
root <root@iua.upf.es> wrote:

> 
> Hello,
> 
> I noticed that the alsa rtctimer is not compiled when you have
> the RTC in your kernel as a module. The problem is in 
> alsa-kernel/core/Makefile, where CONFIG_RTC is tested for y
> and not for m.
> 
> Maarten
> 

talking about this.. if alsa uses RTC, then i cant use it on other programs while alsa does? are we talking /dev/rtc? (int 8)
