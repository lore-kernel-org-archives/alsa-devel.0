From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: emu10k1 sample rates?
Date: Wed, 13 Oct 2004 16:34:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410131623560.16523@denise.shiny.it>
References: <S23465AbUJMNKr/20041013131047Z+4248@nic.funet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <S23465AbUJMNKr/20041013131047Z+4248@nic.funet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juhana Sadeharju <kouhia@nic.funet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 13 Oct 2004, Juhana Sadeharju wrote:

> This is the third time I ask these questions within a couple of
> years because I have not got the answer. So, please reply and
> explane very carefully.
>
> When I record from emu10k1 (e.g., from livedrive linein2)
> with sample rate 44100 Hz, then what sample rate the
> emu10k1 is running at?
>
> I have heard that emu10k1 runs only at rate 48000 Hz. Yes or no?

No, according the driver.  It can record at these rates (line 148 of
emu10k1/emupcm.c): 8000, 11025, 16000, 22050, 24000, 32000, 44100, 48000.
>From the mic it only supports 8KHz and from efx (what is it ?) only 48K.


> Specially I would like to know if Alsa is doing the conversion
> with software, e.g., by boldly skipping samples.

Yes, if you choose a frequency which is not supported. If you want to be
sure that no resampling is done, use the hw: device instead of plughw: .
In that case if the hw params are not supported you get an error (eg.
arecord -Dhw: -fcd xyz.wav).


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
