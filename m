From: Vince Busam <vince@sixpak.org>
Subject: Re: Fix for slow snd-ali5451 initialization
Date: Sun, 13 Nov 2005 22:45:43 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0511132245010.7967@sixpak.sixpak.org>
References: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org>
 <s5hy840pw24.wl%tiwai@suse.de> <20051107154626.GA14736@tecr>
 <s5h64r4pifp.wl%tiwai@suse.de> <43703436.7070206@sixpak.org>
 <s5hoe4vo2tt.wl%tiwai@suse.de> <Pine.LNX.4.61.0511092113230.24677@sixpak.sixpak.org>
 <s5hmzkbz2ys.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzkbz2ys.wl%tiwai@suse.de>
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

That works well, I see it's got a better version of the patch I posted in 
the beginning of this thread in it.

Thanks,
Vince

On Fri, 11 Nov 2005, Takashi Iwai wrote:

> At Wed, 9 Nov 2005 21:17:32 -0800 (PST),
> Vince Busam wrote:
>>
>> On Tue, 8 Nov 2005, Takashi Iwai wrote:
>>
>>> OK, then the problem is not that easy...
>>> We'll need to track down which call fails.
>>>
>>
>> What can I try?  I've noticed it happens when calling snd_ali_codec_peek()
>> with secondary=0 and reg=0x7e.  The first couple calls with those
>> paramaters succeed, then 4 fail.  Is there any good way to print a stack
>> trace when the call fails?
>
> Could you try the patch below, to sync our code base, before further
> looking?  It's for the latest ALSA CVS version (or 1.0.10rc3).
>
>
> Takashi
>

-- 
Vince Busam
vince@sixpak.org
http://sixpak.org/vince/


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
