From: "John Utz" <john.utz@dmx.com>
Subject: Re: aplay: can't resolve symbol 'snd_dlsym_start
Date: Tue, 11 Mar 2008 10:32:28 -0700
Message-ID: <20080311103228.1897ad98@jutz-gnto64>
References: <61445c750803101341m30db6b1oa518c32cdd7fc437@mail.gmail.com>
	<20080310135843.57b0777e@jutz-gnto64>
	<61445c750803101503h68e69e22yff709a3cc45d6d08@mail.gmail.com>
	<61445c750803101641w6d70f210l2a02731e1eb16ccf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C7D7324550
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 18:32:58 +0100 (CET)
In-Reply-To: <61445c750803101641w6d70f210l2a02731e1eb16ccf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Mar 2008 16:41:03 -0700
"Pharaoh ." <pharaoh137@gmail.com> wrote:

> On Mon, Mar 10, 2008 at 3:03 PM, Pharaoh . <pharaoh137@gmail.com>
> wrote:
> >
> > On Mon, Mar 10, 2008 at 1:58 PM, John Utz <john.utz@dmx.com> wrote:
> >  > here's some places to start:
> >  >
> >  >  did you compile the lib as static but the app as shared or vice
> >  > versa?
> >  >
> >  >  also, do an ldd on our libasound.so and see if it wants libdl:
> >  >
> >  >  utz-gnto64 NewProD # ldd /usr/lib/libasound.so
> >  >         libm.so.6 => /lib/libm.so.6 (0x00002acc4444d000)
> >  >         libdl.so.2 => /lib/libdl.so.2 (0x00002acc446ce000)
> >  >         libpthread.so.0 => /lib/libpthread.so.0
> >  > (0x00002acc448d2000) libc.so.6 => /lib/libc.so.6
> >  > (0x00002acc44aee000) /lib64/ld-linux-x86-64.so.2
> >  > (0x0000555555554000) jutz-gnto64 NewProD #
> >  >
> >  >
> >  >
> >  >
> >  >  On Mon, 10 Mar 2008 13:41:10 -0700
> >  >  "Pharaoh ." <pharaoh137@gmail.com> wrote:
> >  >
> >  >  > Hi,
> >  >  >
> >  >  > I have written an user space plugin and the plugin shared
> >  >  > library is copied on board
> >  >  > appropriately, libasound.so is also copied.
> >  >  >
> >  >  >
> >  >  > When I try:
> >  >  >
> >  >  > #aplay -D omx    test.wav  //omx is my plugin
> >  >  >
> >  >  > I get following error:
> >  >  >
> >  >  > aplay: can't resolve symbol 'snd_dlsym_start
> >  >  >
> >  >  >
> >  >  > Any idea what is the problem?
> >  >  >
> >  >  > -pharaoh
> >  >  > _______________________________________________
> >  >  > Alsa-devel mailing list
> >  >  > Alsa-devel@alsa-project.org
> >  >  > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >  >  >
> >  >
> >  >
> >
> >  I have compiled both alsa-lib and alsa-utils as shared libraries.
> >  After doing ldd, I can see that it needs libdl.so and it is
> > present on the board. Let me try with a clean build again.
> >
> 
> Still no luck, I get the same error. Is there any way by which I can
> find out list of unresolved sumbols in a shared library?
> 

nm -D /usr/lib/libasound.so | grep U
