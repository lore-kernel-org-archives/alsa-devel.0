From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: Re: Envy24HT mixer restore problem with M-Audio
  Revolution 7.1 + Alsa 1.0.4
Date: Thu, 15 Apr 2004 09:25:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20040415092239.03560918@pop3.infotecna.lcl>
References: <407B5D5E.4020603@hassard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <407B5D5E.4020603@hassard.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Hassard <steve@hassard.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Stephen,

At 20.24 12/04/2004 -0700, Stephen Hassard wrote:
>When I set my 'DAC' and 'DAC1' channels to sane values (they correspond to 
>L+R audio) and save my mixer settings via 'alsactl store', reboot and 
>restore the settings via 'alsactl restore', my mixer settings appear to be 
>normal in alsamixer, but I find that my left channel ('DAC') is mutted 
>until I change the volume of 'DAC'. As soon as I touch the mixer for the 
>'DAC' channel, audio output is restored.

I have the exact same problem with a TerraTec EWX 24/96 (ice1712 AKA not HT 
Envy24), though on the right channel. In my case this is a long lasting 
quirk (easy to solve with a simple amixer call), cause it's there since at 
least 0.9.0. I also checked the driver code sometimes sgo but haven't been 
able to find any problem in the code.

Bye,
--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
