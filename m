From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: [Alsa-user] [ANN] ALSA 1.0.0pre1 is released
Date: Wed, 26 Nov 2003 19:45:38 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0311261942400.856-100000@ecabase.localdomain>
References: <s5h4qwrxc7v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qwrxc7v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Nov 2003, Takashi Iwai wrote:

>> Some of my apps have stopped working after 1.0.0pre1 on a T23 Thinkpad 
>> (intel8x0, 82801).
[...]
>> On the same machine, alsa-driver-0.9.8 works fine, but not with 1.0.0pre1 
>> and 1.0.0pre3.
> what do you mean exactly "don't work" in the above?
> the operation is blocked, or returns an error?
> if it's blocked, check /proc/asound/card0/pcm0*/sub0/* files.

I didn't have time to fully analyze the problem, so I'm a little short of 
details, but few observations:
    
   - playback direction never wakes up as ready
   - capture direction wakes up but snd_pcm_delay() returns
     odd values

> does this laptop have multiple codecs?  you can find them in
> /proc/asound/card0/codec97#* directories.

I'm pretty sure it doesn't. Anyways, I'll check this tomorrow.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
