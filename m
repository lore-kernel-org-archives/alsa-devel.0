From: Glenn Maynard <g_sf@zewt.org>
Subject: Detecting runtime ALSA library version
Date: Tue, 6 Apr 2004 16:36:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040406203629.GH19477@zewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I can't find any way to detect the running ALSA version, for diagnostic
purposes.  It can't be derived from the library name, which doesn't seem
to change (it's always "libasound.so.2.0.0" here, which has no relation
to the actual version).

It's frustrating to receive bug reports like

  https://sourceforge.net/tracker/?func=detail&atid=421366&aid=930335&group_id=37892
  https://sourceforge.net/tracker/download.php?group_id=37892&atid=421366&file_id=82701&aid=930335

and not being able to tell what version of alsa-lib is in use.

I'd recommend an entry point eg. "const char *snd_lib_version()" to get
this information.

As an aside: is it safe to assume that if /proc/asound/ doesn't exist,
ALSA is not in use?  It'd be useful to short circuit ALSA initialization
for OSS people, since they often have old, broken versions of alsa-lib
installed.

(I know that the converse isn't true--it's possible to load the basic
"snd" module, not load anything else, and then load OSS modules,
resulting in a working OSS environment but /proc/asound/ existing.)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
