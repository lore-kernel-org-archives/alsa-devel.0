From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: Aureal Vortex issues
Date: Mon, 07 Feb 2005 14:55:19 -0300
Message-ID: <1107798919.3259.16.camel@localhost>
References: <W6056410510107771107660839@asteria.telenet-ops.be>
	 <1107714766.3298.10.camel@localhost>
	 <200502062319.29026.alien999999999@users.sourceforge.net>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502062319.29026.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alien <alien999999999@users.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Maarten,

On Sun, 2005-02-06 at 23:19 +0100, Alien wrote:
> well, i finally got it working...
> 
> it seems that since you changed the mmio address to a pointer to unsigned int, 
> made the hwwrite wrong since it did a >>2 (on my 64bit platform that should 
> be a >>3 ofcourse... i disabled some other code and it works

AFAIK shifting byte offsets to make them dword offsets should just work
on any platform. Its just plain PCI memory mapped I/O after all. By the
way, the addresses defined in the header files are byte addresses.

Have you tried a newer kernel ? Try a vanilla kernel with minimal patch
contaminants if possible. 
I read that post regarding your emu10k1 oopsing too. AFAIK the emu10k1
uses port i/o instead of mmio. That makes me think that if this oopses
are linked somehow, the problem is either a widespread common mistake or
somewhere deeper in the PCI i/o layer of the kernel. 

> i'll give you the changed files, you do with it what you want:
> 
> not that it's better to define the mmio as a void* so that additions involving 
> that do not have to be >>2 or >>3 or whatever.
> 
> i disabled the a3d routines and the vortex3D (since vortex3D was already 
> disabled with an #if 0 ...

What "#if 0" do you mean ? In the current Alsa version in kernel 2.6.9
the 3D sources are accesible and working for au8830's through the "a3d"
PCM device.
The 3D support code is very well tested. It is not considered unstable.
The problem is that there is no library taking advantage of it (and
coordinate mapping functions are missing).

Anyway, it makes me glad to know that you got working. I'll take at a
look at your code changes ASAP and commit possible patches to the ALSA
list, with credits to you of course.

Best Regards, thanks.
-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
