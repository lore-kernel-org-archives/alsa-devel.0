From: pdq808@t-online.de (Reiner Klenk)
Subject: Re: Support for powermac G5?
Date: Sun, 27 Jun 2004 10:08:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40DE8079.4070208@t-online.de>
References: <Pine.LNX.4.56L0.0406201812430.22212@linux.local> <40D70D3E.60203@t-online.de> <Pine.LNX.4.56L0.0406211910270.12620@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.56L0.0406211910270.12620@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jaspal.kallar.xfree86@spray.se
Cc: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



jaspal.kallar.xfree86@spray.se wrote:

> Reiner: I presume your commnets are for the function (pmac.c): 
> "static int __init snd_pmac_detect(pmac_t *chip)" 
> 
> where you commented out the if-statement (line 927 for me) :
> 
> if (device_is_compatible(sound, "snapper")) {
>                 chip->model = PMAC_SNAPPER;
>                 // chip->can_byte_swap = 0; /* FIXME: check this */
>                 chip->num_freqs = 2;
>                 chip->freq_table = tumbler_freqs;
>                 chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
> }
>  
> so that it was snapper.
Yes, that's what I did.
  A question though. How did you know that you had
> to set the chipset to snapper ? Was this information available somewhere 
> in /proc ? For example, (wild guess) is the information in  
> /proc/device-tree/ht@0,f2000000/pci@3/mac-io@7/i2s@10000/i2s-a@0/sound/compatible
> important ? In my case it gives AOAK2.
It says here: AOAKeylargo
I don't really know much about these things. I read about this 
work-around on the debian-ppc mailing list (This list has been very 
helpful in resolving a couple of issues with the new powerbooks).

Yesterday I updated my kernel to 2.6.7-bk9 and I didn't have to modify 
pmac.c any more. So for powerbooks this seems to be fixed.

> 
> Also did you get the same error as me i.e 
> "ALSA sound/ppc/pmac.c:1095: pmac: can't request resource 0!"
> in /var/log/messages?

No, I haven't seen that.

Reagrds,
Reiner



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
