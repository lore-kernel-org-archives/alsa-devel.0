From: David Honeywell <davidh@pianodisc.com>
Subject: Re: LADSPA plugin segfault patch
Date: Wed, 25 Jun 2003 11:02:48 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF9E3C8.3010400@pianodisc.com>
References: <Pine.LNX.4.44.0306140931470.13576-100000@pnote.perex-int.cz>
Reply-To: davidh@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306140931470.13576-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Using snd_dl*() function in LADSPA is broken. They do own versioning for 
> internal functions which is not applicable to external code like LADSPA 
> plugins. It should be fixed in CVS. Thank you for notice.

I just tested the latest CVS snapshot (2003-06-25) with the LADSPA 
plugins that were previously causing trouble.  The segfault and version 
errors are fixed, but now there is no sound.  Is this a known issue? 
Using alsa-lib-0.9.0rc6 still works fine with everything else the same.

Here is my asound.conf:

pcm.pitch
{
     type ladspa
     slave.pcm "plughw:0,0"
     path "/usr/local/lib/ladspa"
     plugins
     [
        {
           label amPitchshift
           input
           {
              controls [ 1.059463 3 ]
           }
        }
     ]
}

In my player, I use device.pcm_device = "plug:pitch".  Any ideas?

-- 
David Honeywell
PianoDisc Design Engineer
(916) 567-9999 ext. 181
www.pianodisc.com
davidh@pianodisc.com
(PGP Public Key Available)



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
