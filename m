From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Removal of /proc/asound ?
Date: Sun, 18 May 2003 08:13:31 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030518081331.7b9eca31.erikd-alsa@mega-nerd.com>
References: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com>
	<Pine.LNX.4.44.0305171343140.21997-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305171343140.21997-100000@pnote.perex-int.cz>
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

On Sat, 17 May 2003 13:55:19 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> I try to explain these things to avoid more confusion.
> 
> The dynamic devices created in proc filesystem does things similar as 
> DEVFS. 

Thats fine, but now many people runnning 2.4 series kernels are using
DEVFS?

> We used it, because in design time, we changed minor and major 
> numbers for our devices heavily. Once we stabilized our devices, and DEVFS 
> obsoleted our code (DEVFS is more generic), there is no reason to maintain 
> this code anymore. Also, we are only one project doing this and we had 
> requests from the kernel people to remove this code.

Was that request from the 2.4 kernel maintainers or the 2.5 people?

If it was a request from the 2.5 kernel people, why is this change impacting
people running 2.4 kernels.

> The current situation is that used /dev/snd symlink should be replaced
> with directory containing static device entries (created by mknod). If you
> use DEVFS, there is no difference and no extra steps are required.
>
> If the driver is installed via standard command 'make install' in the 
> alsa-driver directory, the snddevices script is run automatically when 
> /dev/snd is a symlink. 

How will this work if the user does not have a DEVFS enabled kernel?

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
UNIX *is* user-friendly, just picky about who it 
chooses for friends!


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
