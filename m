From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Removal of /proc/asound ?
Date: Mon, 19 May 2003 20:03:01 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030519200301.1c3276f7.erikd-alsa@mega-nerd.com>
References: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com>
	<Pine.LNX.4.44.0305171343140.21997-100000@pnote.perex-int.cz>
	<20030518081331.7b9eca31.erikd-alsa@mega-nerd.com>
	<s5h4r3re0a8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r3re0a8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 19 May 2003 11:46:55 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > If it was a request from the 2.5 kernel people, why is this change impacting
> > people running 2.4 kernels.
> 
> i also thought of this.  in theory, it's not difficult to implement
> the compatible layer.
> 
> meanwhile, it's not too hard to create device files, too.  once if you
> made them, then the system works like before.
> 
> frankly saying, i'm not sure which is the really better way.
> if there are MANY demands on the old way, we'll consider to implement
> it back again (but not appearing in the 2.5 kernel tree :)

There are times when backward compatibility is important and other times
when it is not.

Personally, I quite look forward to using DEVFS and the other 2.5/2.6 
features when I do finally make the switch. Until then, i would like as 
little change as possible.

I therefore strongly urge you to keep 2.4 functionality as it was and feel
free to do whatever is needed for the 2.5/2.6 kernel.

Regards,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
Peter F. Curran : Microsoft. Still delivering a text editor with 
    Win95/98 that can only open a max 64K file, despite being on 
    a machine with an 8Gig HD and 64M of ram....
G Cook: Perhaps, but Notepad is still the most functional program 
    in the whole suite!


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
