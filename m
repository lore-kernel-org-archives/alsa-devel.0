From: Martin Langer <martin-langer@gmx.de>
Subject: writing-an-alsa-driver: snd_info_set_text_ops()
Date: Sat, 27 Dec 2003 22:06:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031227210640.GA12711@tuba.home>
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


Hi,

in the docs of writing-an-alsa-driver
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1396.htm
is snd_info_set_text_ops() used as
snd_info_set_text_ops(entry, chip, my_proc_read);

But the reality of alsa-driver/alsa-kernel/include/info.h says:

static inline void snd_info_set_text_ops(snd_info_entry_t *entry, 
                                         void *private_data,
   					 long read_size,
                                         void (*read)(snd_info_entry_t *, snd_info_buffer_t *))

That looks like read_size is missing in the docs?


martin


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
