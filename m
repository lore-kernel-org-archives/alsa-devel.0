From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: MMAP and pcm copy op.
Date: Sun, 18 May 2003 16:11:06 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030518161107.14355.h005.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

I got the impression that should either have copy and silence operations, OR
allow MMAP:

>>>>
"Some chips have their own hardware buffers and the DMA transfer from the h=
ost
memory is not available. In such a case, you need to either 1) copy/set the
audio data directly to the external hardware buffer, or 2) make an intermed=
iate
buffer and copy/set the data from it to the external hardware buffer in
interrupts (or in tasklets, preferably).

The first case works fine if the external hardware buffer is enough large. =
This
method doesn=92t need any extra buffers and thus is more effective. You nee=
d to
define the copy and silence callbacks for the data transfer. However, there=
 is a
drawback: it cannot be mmapped. The examples are GUS=92s GF1 PCM or emu8000=
=92s
wavetable PCM.

The second case allows the mmap of the buffer, although you have to handle =
an
interrupt or a tasklet for transferring the data from the intermediate buff=
er to
the hardware buffer. You can find an example in vxpocket driver."
<<<<

But this is clearly not the case eg rme drivers.
So, what does it mean to have both MMAP and .copy,.silence callbacks define=
d?

thanks
=0D
Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
