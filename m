From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Click after draining
Date: Thu, 7 Oct 2004 20:58:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041007205801.6fb143ad.pochini@shiny.it>
References: <20040921221318.4e0c7c7f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040921221318.4e0c7c7f.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Sep 2004 22:13:18 +0200
Giuliano Pochini <pochini@shiny.it> wrote:

> With both the powermac driver and my echoaudio driver, playback ends with a
> "click". With properly choosen buffer/period/file sizes I can make the card
> play almost a whole period of old data before the substream is actually
> stopped. It seems that periods after the last one are not silenced, but I'm
> not having luck at findind the cause. This is not a recent problem.
> [...]

I reply myself to add that I asked about this issue at one of the
betatesters and he can hear the click also. It's not a mac-only problem...
Any ideas ?


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
