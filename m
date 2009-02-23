From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Timer instability
Date: Mon, 23 Feb 2009 19:24:45 +0000
Message-ID: <gnut5u$7g2$1@ger.gmane.org>
References: <20090219024611.GA7930@tango.0pointer.de>	<s5hy6w2hqap.wl%tiwai@suse.de>	<20090220012220.GA11526@tango.0pointer.de>	<s5h1vtty3f8.wl%tiwai@suse.de>	<20090220203417.GA19093@tango.0pointer.de>	<s5hhc2nu4qy.wl%tiwai@suse.de>	<20090222031453.GA24365@tango.0pointer.de>	<20090223024233.GA1901@tango.0pointer.de>	<20090223025610.GA7062@tango.0pointer.de>
	<20090223192045.GA19543@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D3B01037EC
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 20:25:02 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LbgQH-0002Ll-K7
	for alsa-devel@alsa-project.org; Mon, 23 Feb 2009 19:25:01 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 19:25:01 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 19:25:01 +0000
In-Reply-To: <20090223192045.GA19543@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Lennart Poettering at 23/02/09 19:20 did gyre and gimble:
> On Mon, 23.02.09 03:56, Lennart Poettering (mznyfn@0pointer.de) wrote:
> 
>> Hmm, for now my little testing experiment I've now found es1969,
>> ens1371, intel8x0, snd-emu10k1 and some intel-hda to have unreliable
>> _avail() or _delay().
> 
> And here's the output for HDA STAC92xx:
> 
> http://pastebin.mandriva.com/7149

I realised that post will timeout after a month, so here is a longer 
term one :)

http://pastebin.mandriva.com/7238


> The first dump is the interesting one: when audio starts to play the
> buffer abruptly runs empty in just 20us after the device started. (The
> rightmost column is the state btw, 3 == playing).
> 
> A quick overview of cards where _delay() and/or _avail() are unreliable:
> 
>  es1969
>  ens1371
>  intel8x0
>  emu10k1
>  intel-hda on STAC92xx
>  intel-hda on AD1989B
> 
> Lennart
> 


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
