From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: struct snd_pcm_hardware_t values
Date: Sun, 6 Aug 2006 20:56:14 +0000
Message-ID: <20060806205614.GB2929@trinity.fluff.org>
References: <d9def9db0608050609t3683aba9ja80690a8758098e1@mail.gmail.com>
	<d9def9db0608061138o100b5b78yead3623f655ec60b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from trinity.fluff.org (trinity.fluff.org [217.147.94.151])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6269B15C
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 22:56:21 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <d9def9db0608061138o100b5b78yead3623f655ec60b@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Markus Rechberger <mrechberger@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 06, 2006 at 08:38:53PM +0200, Markus Rechberger wrote:
> I did some more investigation uppon this
> >     .buffer_bytes_max = (32*1024),
> this one seems to be clear now, I set it to the max
> transfer_buffer_size of 1 URB
> >     .period_bytes_min = 64,
> this one not .. in my case I set it to transfer_buffer_size/2
> >     .period_bytes_max = 2048,
> this one is again transfer_buffer
> >     .periods_min = 1,
> I set this one to 2 (people in IRC cleared me up about this one)
> >     .periods_max = 255,
> no idea again..
> 
> So what I get now is:
> http://lost-souls.mercuryserver.de/files/data/test.wav.mp3
> 
> and a buffer underrun regarding aplay
> aplay -D hw:2,1 5_5_2006__07_00_59.wav
> Playing WAVE '5_5_2006__07_00_59.wav' : Signed 16 bit Little Endian,
> Rate 9600 Hz, Mono
> underrun!!! (at least 0,307 ms long)
> underrun!!! (at least 0,285 ms long)
> underrun!!! (at least 0,295 ms long)
> underrun!!! (at least 0,279 ms long)
> underrun!!! (at least 0,298 ms long)
> underrun!!! (at least 0,287 ms long)
> 
> the strange thing here is the DTMF tones in the background sound fine,
> so I don't really recognize an underrun when playing the file just
> that strange noise which is constant all the time..
> 
> following is what my debug prints in dmesg:
> I'm sure the PCM PLAYBACK TRIGGER STOP! are caused by the buffer
> underrun which is reported by aplay..
> The outgoing dataformat is 9600hz, S16_LE, mono ..

I'm having trouble with ALSA intermittently getting into a state
where the trigger is being repeatedly called for start then stop
and can only sometimes get out of it. I will post a seperate report
on this later.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
