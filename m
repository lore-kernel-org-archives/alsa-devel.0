From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: ice1724: from 1.0.4 to 1.0.5a upgrading problem
Date: Fri, 16 Jul 2004 13:58:28 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.60.0407161349550.53564@kosh.hut.fi>
References: <200407141718.03846@goldspace.net> <s5h658qaf5b.wl@alsa2.suse.de>
 <200407141749.42615@goldspace.net> <s5h4qoaadzn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qoaadzn.wl@alsa2.suse.de>
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

>> To tell the truth, have not understood the word "yet": just now (with 1.0.4)
>> my receiver (as qjackctl) shows 96KHz (alsaplayer-jack-alsadriver-hw:0,1-spdif).
>> Does it mean some redesign was done for this driver since 1.0.4?
>
> The spdif doesn't support 96kHz without a special handling.
> It was a bug that 96kHz was accepted for that interface.

Does this affect all soundcards that use ice1712 driver?

About a year ago I synced two MAudio Delta cards (AP 2496 & 1010LT) 
through spdif and the rate was 96khz for the master card. I experienced 
some driver lockups and I had to do '/etc/init.d/alsa restart' after every 
recording to have 'fresh' start for new recording.

But other than that, sync worked fine.

(I remember that few months later some patch was sent to fix some spdif 
issue with ice1712, but I don't know if that would have fixed my problem, 
or was it due to this current situation)

Tommi


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
