From: Raymond <rayau@netvigator.com>
Subject: Re: Mo' better modem support
Date: Tue, 06 Sep 2005 16:37:34 +0800
Message-ID: <431D554E.8050500@netvigator.com>
References: <s5h64tfs8wm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64tfs8wm.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org


ASUS L8400B notebook equipped with au8810 chip and there is a Win9x 
Aureal audio/modem driver for the notebook

http://usa.asus.com/download/notebook/nb-l8400b.htm

Is this kind of softmodem supported by ALSA ?

http://www.tomshardware.com/mobile/20010202/l8400b-09.html


Takashi Iwai wrote:
> Hi,
> 
> I've played a bit the ac97 modem yesterday, and found out the
> following problems:
> 
> 1. Off-Hook switch needs manually turned on
> 
>    Shall we add a hook in pcm.modem definition for this control?
> 
> 2. All controls have index 1, thus the appearance on alsamixer looks
>    strange
> 
> 3. There is no way to detect the modem driver from sysfs or so.
> 
>    Espeically, hda-intel driver supports both audio and modem by a
>    single driver, and the modem support doesn't appear even on proc
>    file explicitly.
> 
> Well, 2 is a minor problem, and we can live with that.
> But others should be improved...
> 
> 
> Any ideas?
> 
> Takashi
> 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
