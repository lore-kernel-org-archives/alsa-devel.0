From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Sat, 23 Oct 2004 16:15:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041023161530.605de269.pochini@shiny.it>
References: <s5his9h4a3u.wl@alsa2.suse.de>
	<XFMail.20041012112521.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20041012112521.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Oct 2004 11:25:21 +0200 (CEST)
Giuliano Pochini <pochini@shiny.it> wrote:

> I wrote the fw loader stuff, but I kept the possibility to compile
> the driver with embedded fw because Mona and Laya24 need it. I'll
> change it later. The code is here as usual:
>
> http://xoomer.virgilio.it/g_pochini/ea.html
>
> It has been tested on my Gin24 only.

Ok, external firmware should work for all cards. Expecially the Mona driver
was tricky because it needs to reload the firmware when switching between
single and double speed mode. This and the fact that request_firmware() can
sleep creates races conditions in the set_sample_rate, set_input_clock and
set_digital_mode pcm_digital_open functions. I had to add a mutex and to
reorder some code. I hope I didn't introduce new bugs...


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
