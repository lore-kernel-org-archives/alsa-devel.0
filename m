From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Sun, 30 Mar 2003 21:35:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E874714.5020302@cucumelo.org>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net, werner@suse.de
List-Id: alsa-devel@alsa-project.org

>
>
>Well, I think there are two problem, the first one is the limited set of
>period-size configurations which the bitstream plugin should take care
>of, but the real reason I repost what Dr. Werner Fink wrote in the
>vdr@linuxtv.org mailing list was because he spoke exactly about a
>problem we are a lots to have with the cs46xx driver :-(
>Also found relative to DVB (AC3overDVB from Stefan Huelswitt,
>http://www.muempf.de/down/vdr-1.1.26-AC3overDVB-0.1.4.diff.gz ) which
>contains in the README.AC3overDVB:
>  
>
About the period sizes there'e nothing we can do in the driver, as this is a
HW limitation.
(However it's possible to implement Scatter/Gather DMA support for the
cs46xx driver, then maybe there's more posibilies to variate the period
size, but that's not going to happen in a near future ...)

>If your receiver doesn't detect the encapsulated stream (at the
>beginning of replay in general) you will hear the digital data played as
>PCM data. It's a spiky noise. Don't turn up the volume too much, or the
>speakers may be damaged. You have been warned!
>
>  
>
I think that the problem with the current cs46xx driver could be the 
status bits
in the IEC958 stream that is not set correctly.  Some receivers seems to 
ignore
the status bits and detects the format looking into the stream instead, 
other receivers
may look into the status bits to detect if it's PCM audio, or digital data.
So it's posible that AC3 DTS, etc work's OK with thoose receivers that 
just ignores
the content of the status bits, which I think is the case of my Harmon 
Kardoon
receiver.

/Benny



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
