From: Paulo Marcel Coelho Aragao <pmcaragao-ag@yahoo.com>
Subject: Re: Tips on debugging ALSA driver snd_es18xx
Date: Thu, 15 Dec 2005 10:40:31 -0200
Message-ID: <20051215124031.GC4263@cortazar>
References: <20051215013411.GK7983@cortazar> <1134635237.43a128e5e75fa@webmail.uni-halle.de> <20051215111213.GA3636@cortazar> <s5hd5jyvc3q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hd5jyvc3q.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Dec, 15:

[...]

> > > > I recently switched from OSS to ALSA and I'm baffled by this: aplay 
> > > > produces
> > > > sound when playing wav files, but gxine and xmms produce no sound when
> > > > playing streaming audio.

> > > What are the contents of /proc/asound/card0/pcm0p/sub0/hw_params and sw_params
> > > in either case?

[...]

> > This was curious: the wav files I tried with aplay ended too quickly, so I 
> > looked for longer ones. My surprise: no sound from the longer ones. It gave me 
> > the impression to be related to the sound source being coded for 16 or 
> > 8-bits, if I'm not speaking just plain nonsense.

[...]

> Might it be depending on the sample rate?
> Try speaker-test, for example, with different sample rates.

Tried all rates from the aplay/gxine/xmms runs, and also lower and higher 
rates but no sound at all, not even with 11127Hz, the rate of the aplay run 
that produced sound.

I did notice this line in all speaker-test runs:

Stream parameters are 11127Hz, S16_LE, 1 channels

of course with a differen rate at each run. S16_LE is the format for all 
aplay/gxine/xmms runs that didn't produce sound. I don't know precisely what 
`format' is, but the aplay run that produced sound had a different value: U8.

[...]

> > PS: Would have at hand a reference to some document that describes 
> > /proc/asound ?

> alsa-kernel/Documentation/Procfile.txt (in kernel tree
> linux/Documentation/sounds/alsa/Procfile.txt).

It just occurred to me now: should I record this problem in ALSA BTS for 
future reference ?

Thanks for this, and more so, thanks for taking your time with such 
speed-lightning reply.
Paulo


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
