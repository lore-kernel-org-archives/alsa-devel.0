From: Aner Gusic <aner@lysator.liu.se>
Subject: problems compiling alsa-lib
Date: Sat, 5 Feb 2005 00:34:19 +0100
Message-ID: <20050204233419.GB25143@sture.lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

I get following error when compiling (linking) alsa-lib that I checked
out from the CVS.

----
gcc -shared  .libs/conf.o .libs/confmisc.o .libs/input.o
.libs/output.o .libs/async.o .libs/error.o .libs/dlmisc.o
.libs/socket.o .libs/shmarea.o .libs/userfile.o -Wl,--whole-archive
control/.libs/libcontrol.a mixer/.libs/libmixer.a
ordinary_mixer/.libs/libordinarymixer.a pcm/.libs/libpcm.a
ordinary_pcm/.libs/libordinarypcm.a rawmidi/.libs/librawmidi.a
timer/.libs/libtimer.a hwdep/.libs/libhwdep.a seq/.libs/libseq.a
instr/.libs/libinstr.a compat/.libs/libcompat.a alisp/.libs/libalisp.a
-Wl,--no-whole-archive  -lm -ldl -lpthread  -Wl,-soname
-Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name
snd_pcm_hw_params_get_buffer_size_max@ALSA_0.9
/usr/bin/ld: failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/usr/debian/cvs/alsa/alsa-lib/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/debian/cvs/alsa/alsa-lib/src'
make: *** [all-recursive] Error 1
----

I do as the INSTALL-file says, except that I give --prefix=/usr/local
to the "configure".

What could be wrong?

-- 
Aner Gusic

"A day for firm decisions!  Or is it?"
   -- fortune


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
