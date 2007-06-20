From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 11:18:13 -0500
Message-ID: <61c0054e0706200918pbc56676h60640cb08de633b8@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<61c0054e0706200727s1648cde3y578ae0c230ad1616@mail.gmail.com>
	<8d6898730706200732u60eed3b3l52a141d7e7a151c4@mail.gmail.com>
	<61c0054e0706200739k2b934a9avbffb133937adba4c@mail.gmail.com>
	<61c0054e0706200824v444d6c8dr6b6023b16043fa7@mail.gmail.com>
	<61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>
	<61c0054e0706200840k2b0f13c9q57581c380d39d2fc@mail.gmail.com>
	<s5hwsxyaa5r.wl%tiwai@suse.de>
	<61c0054e0706200912m1779bef8gfab9da178bd888b4@mail.gmail.com>
	<75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 0357224340
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 18:18:14 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so213620mue
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 09:18:14 -0700 (PDT)
In-Reply-To: <75b66ecd0706200916i2105cb49xf40313e0440bc821@mail.gmail.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/20/07, Lee Revell <rlrevell@joe-job.com> wrote:
>
> FWIW, alsamixer is the only thing that needs curses, when I did an
> embedded linux + ALSA project I just passed --disable-alsamixer to
> work around it, and used amixer.
>
> Lee


 Lee:

Thanks. I do not think I need a mixer at all...doing mono voice on a dumb
single channel codec.

Thanks again.

Paul
