From: Oliver Gerlich <olig9@gmx.de>
Subject: Re: CMI9780 and ALSA volume control
Date: Mon, 12 Apr 2004 13:46:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407A8179.9010907@gmx.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D42E@cm-msg-02.cmedia.com.tw> <20040412104718.5ba75774@rambo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040412104718.5ba75774@rambo>
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

André Heßling schrieb:
> On Mon, 12 Apr 2004 11:04:55 +0800
> C.L. Tien - _____ <cltien@cmedia.com.tw> wrote:
> 
> 
>>9780 has no PCM volume control, master volume control doesn't control the PCM, either. This feature is the same as other C-Media AC97 Codecs.
>>
>>I once posted a patch that tune PCM volume in SW way (change PCM data in DMA buffer), but it was not accepted.
>>
>>Sincerely,
>>ChenLi Tien
> 
> 
> Ok, thanks so far!
> Can you tell me where I can find this patch? I would give it a try then.
> 
> And is only the PCM control affected or may even LineIn and Mic have no control?
> As I see you have something to do with cmedia:
> On the homepage it is written that there should exist a driver for Linux.
> But I can't find it or any drivers for 9780.

There exists CMedia's cmaudio driver for CMI9739/A; maybe it works for 
your chip as well. It does volume scaling in software, but unfortunately 
it only supports OSS and seems to be buggy.

At the moment I'm using the snd-intel8x0 driver, so I'm interested in 
the PCM patch as well; does someone know where I can find it? I've 
already asked about software volume scaling at the Linux audio user 
list, but I'm not that experienced enough with ALSA to write a plugin 
which does the job.

If the new Aldi PC has such a chip, maybe there'll be more people who 
need a solution for this problem :)


Oliver Gerlich



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
