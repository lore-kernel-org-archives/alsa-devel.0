From: "Brian J. Tarricone" <bjt23@ece.cornell.edu>
Subject: Re: [Alsa-user] sb live dma buffer alloc failure?
Date: Fri, 07 Feb 2003 14:46:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E440D06.8090803@ece.cornell.edu>
References: <3E40BA0F.9070600@ece.cornell.edu> <s5hadh8e23e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadh8e23e.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>which kernel version are you using?
>
2.4.20 - it's a heavily patched one, tho (out of gentoo's portage).  
should i try a vanilla kernel?

>the new code on rc7 simply tries allocation via vmalloc().
>if it fails, it means that the system resource is really exhausted.
>or, there might be memory leak or so...
>  
>
hmm...  well, rc7 has locked for me very shortly after system startup, 
top reports plenty (>200mb) free, so this shouldn't be a free resource 
issue.  it seems to only occur if i try to rapidly open and close the 
device (when i say 'rapidly' i mean about once per second for about 
10-25 seconds).

it's sub-ideal, but i'm using esd for now (with a really high timeout 
for releasing the pcm device) to avoid the excessive reopening behaviour.

thanks for your help - please let me know of any other ways i can try to 
gather information.

    -brian



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
