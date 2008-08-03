From: "Bankim Bhavsar" <bankim.bhavsar@gmail.com>
Subject: Re: dmix in a forked process
Date: Sun, 3 Aug 2008 13:47:34 -0700
Message-ID: <4eccebac0808031347v26c5c430h2e66f0439e64fbdf@mail.gmail.com>
References: <4eccebac0808012003j49ea4351pc34f3f1ed7690f15@mail.gmail.com>
	<4eccebac0808021945s66b362e3u51ecedea830a04e4@mail.gmail.com>
	<Pine.LNX.4.61.0808032036330.31850@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 2157B24757
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Aug 2008 22:47:35 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so2380163wfg.23
	for <alsa-devel@alsa-project.org>; Sun, 03 Aug 2008 13:47:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0808032036330.31850@tm8103-a.perex-int.cz>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 3, 2008 at 11:38 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Sat, 2 Aug 2008, Bankim Bhavsar wrote:
>
>> I'm currently porting the sound code of our app from OSS to ALSA but
>> this problem is preventing me from doing so.
>> Is there any way to get around this problem?
>
> What's your problem with fork()?

If our app is the first to start dmix then a copy of the process (app)
will remain till
the last application closes the share device.

So our problem is not fork but fork without *exec*.

Thanks,
Bankim.
