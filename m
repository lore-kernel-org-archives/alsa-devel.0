From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Tue, 12 Oct 2004 11:25:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20041012112521.pochini@shiny.it>
References: <s5his9h4a3u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5his9h4a3u.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 11-Oct-2004 Takashi Iwai wrote:

>> 8 new files... And I'm not sure it looks better than before.
>>
>> http://xoomer.virgilio.it/g_pochini/ea-0.9.0.tar.bz2
>
> Well, I'm also not sure :)
> Choose as you like for the initial release.  We can clean up later
> on.

Hm, I reverted them excepted the _gml one because it avoid
duplicated code.


>> > About the firmware: since the recent 2.4 kernel also includes
>> > request_firmware(), it's the easiest way to go, I believe.
>> >
>> > I'll rewrite the firmware code later for other drivers.  I'll likely
>> > keep the old implementation of ALSA firmware loader for the cases that
>> > no kernel fw-loader is configured or the driver is built in kernel.
>> >
>> > If you finish them, please send me the patch.
>>
>> I've not written the firmware loader yet. I'll do it during the week end.

I wrote the fw loader stuff, but I kept the possibility to compile
the driver with embedded fw because Mona and Laya24 need it. I'll
change it later. The code is here as usual:

http://xoomer.virgilio.it/g_pochini/ea.html

It has been tested on my Gin24 only.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
