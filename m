From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: snd_pcm_ops - .copy
Date: Tue, 22 Apr 2008 08:08:06 +0530
Message-ID: <827ad74d0804211938p6f78b6b5j5cd3ed3cc5f819bb@mail.gmail.com>
References: <827ad74d0804210657p1c275b05jf16fd8daf3bf55e4@mail.gmail.com>
	<s5hprsjb3l0.wl%tiwai@suse.de>
	<827ad74d0804211937y4bcecf84n89da066b8e73ef2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 65B1E2441A
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 04:38:08 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so2135620wxc.23
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 19:38:06 -0700 (PDT)
In-Reply-To: <827ad74d0804211937y4bcecf84n89da066b8e73ef2@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 22, 2008 at 8:07 AM, Harsha priya gupta <harshapriya@gmail.com>
wrote:

> I am not using the mmap method. How can i make sure that everytime a user
> buffer is passed to driver, my copy function would be called?
>
>
> On Mon, Apr 21, 2008 at 9:30 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
> > At Mon, 21 Apr 2008 19:27:45 +0530,
> > Harsha priya gupta wrote:
> > >
> > > Hi,
> > > I am trying to implement the .copy function of playack_ops in my
> > driver. But
> > > when I try playing an mp3 file, my .copy's function code path was
> > executing.
> > > Suddenly I do not see that function being called. Can anyone help me
> > > understand when the following code path will be executed
> > >
> > > snd_pcm_lib_write_transfer
> > >    substream->ops->copy
> >
> > Do you use a mmap method?  If so, the copy callback won't be called.
> > The copy callback is only for copying the data from the user-space
> > buffer to the driver buffer, which is skipped via mmap.
> >
> >
> > Takashi
> >
>
>
>
> --
> -Harsha




-- 
-Harsha
