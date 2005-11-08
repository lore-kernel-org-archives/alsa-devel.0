From: Vince Busam <vince@sixpak.org>
Subject: Re: Fix for slow snd-ali5451 initialization
Date: Mon, 07 Nov 2005 21:14:30 -0800
Message-ID: <43703436.7070206@sixpak.org>
References: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org>	<s5hy840pw24.wl%tiwai@suse.de>	<20051107154626.GA14736@tecr> <s5h64r4pifp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64r4pifp.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sasha Khapyorsky <sashakh@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is with 2.6.12-9-k7 from Ubuntu and 2.6.13-1.1526_FC4 from Fedora 
Core 4.  I'll try pulling the latest code from CVS and see if that helps.

I don't think it's a problem with attempting the second mixer (which it 
does, and fails).  It happens while creating the first mixer, in the 
snd_ac97_mixer() call in this loop when i==0.

for ( i = 0 ; i < codec->num_of_codecs ; i++) {
   ac97.num = i;
   if ((err = snd_ac97_mixer(codec->ac97_bus, &ac97, &codec->ac97[i])) < 
0) {
     snd_printk("ali mixer %d creating error.\n", i);
     if(i == 0)
       return err;
    }
}

Vince

Takashi Iwai wrote:
> At Mon, 7 Nov 2005 17:46:26 +0200,
> Sasha Khapyorsky wrote:
> 
>>On 11:54 Mon 07 Nov     , Takashi Iwai wrote:
>>
>>>At Sat, 5 Nov 2005 11:38:03 -0800 (PST),
>>>Vince Busam wrote:
>>>
>>>>The snd-ali5451 driver takes 10 seconds to load, which is quite annoying 
>>>>on a laptop that boots every day.  This patch lowers that to a much more 
>>>>managable time, and still works fine on my laptop.
>>>>
>>>>Vince
>>>>
>>>>     Summary: Speed up ali5451 initialization
>>>>
>>>>     The patch speeds up loading the ali5451 driver by lowering the
>>>>     wait time in snd_ali_codec_ready()
>>>>
>>>>     Author: Vince Busam <vince@sixpak.org
>>>>     Signed-off-by: Vince Busam <vince@sixpak.org>
>>>
>>>Well, it's not a good solution.  It's already strange that so many
>>>timeouts occur.  And, the driver works correctly after that?  That is,
>>>you don't get any timeouts once after the driver is initialized?
>>
>>This could be initialization attempt of non-existed secondary codec. At
>>least such attempt was reported in the past.
> 
> 
> Yes, that's also my suspect.
> 
> Vince, are you using the latest ALSA code?  At least, the probe code
> is a bit improved on 2.6.14 kernel, like ALSA CVS version.
> 
> 
> Takashi


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
