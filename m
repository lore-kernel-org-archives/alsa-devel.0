From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: Detecting runtime ALSA library version
Date: Tue, 6 Apr 2004 18:38:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040406223818.GJ19477@zewt.org>
References: <20040406203629.GH19477@zewt.org> <200404062104.i36L4Y4c010563@dhin.linuxaudiosystems.com> <20040406211024.GI19477@zewt.org> <40732C31.8020700@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <40732C31.8020700@superbug.demon.co.uk>
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

On Tue, Apr 06, 2004 at 11:16:17PM +0100, James Courtier-Dutton wrote:
> cat /usr/include/alsa/version.h  tells you the currently installed version.

Nope.  That only works if the development files are installed; on user
systems, they usually aren't.  I can't simply #include it; that'll tell
me what version of ALSA was installed by the person that built the binary
(which is usually not the same person), and won't follow dynamic library
upgrades.

Also, even if ALSA development files are installed, there's always a
chance there's a mismatch; for example, there may be one version of ALSA
in /usr/lib and another in /usr/local/lib.

I want to know what real version of libasound.so the application is
linked against, without having to worry about user error or unusual
configurations resulting in incorrect output.

This is why many libraries export a function to return the version in
use: png_access_version_number, png_get_libpng_ver, zlibVersion(),
SDL_Linked_Version(), confstr(_CS_GNU_LIBC_VERSION), and so on.

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
