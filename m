From: Szekeres =?iso-8859-2?Q?Istv=E1n?= <szekeres@iii.hu>
Subject: Re: USB headset problem
Date: Tue, 18 Oct 2005 21:46:08 +0200
Message-ID: <20051018194608.GA23908@pulsussoft.hu>
References: <20051014091716.GA30524@pulsussoft.hu> <Pine.HPX.4.33n.0510141250040.23443-100000@studcom.urz.uni-halle.de> <20051014202153.GA1428@pulsussoft.hu> <20051014220539.GA1818@pulsussoft.hu> <s5hll0szbdp.wl%tiwai@suse.de> <20051017124011.GA16144@pulsussoft.hu> <s5hhdbgz6m2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hhdbgz6m2.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> > I already tried aoss, the result is a big fat SIGSEGV.
> 
> That's more interesting.
> Can you get a stack trace via gdb?

I have a stack trace but I think a patch for the solution is more useful ;-)

I don't know if it is necessary or useful, but:
Signed-off-by: Szekeres Istvan <szekeres@iii.hu>

--- alsa-oss.c~ 2005-10-18 21:04:21.000000000 +0200
+++ alsa-oss.c  2005-10-18 21:04:21.000000000 +0200
@@ -344,10 +344,13 @@
 int fcntl(int fd, int cmd, ...)
 {
        va_list args;
        void *arg;

+       if (!initialized)
+               initialize();
+
        va_start(args, cmd);
        arg = va_arg(args, void *);
        va_end(args);
        if (fd < 0 || fd >= open_max || fds[fd] == NULL)
                return _fcntl(fd, cmd, arg);


Next thing is to compare the kernel oss emulation with aoss on a non-working
kernel.

Best regards,
Szekeres Istvan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
