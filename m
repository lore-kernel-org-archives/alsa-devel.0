From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Mon, 29 Dec 2014 22:49:12 +0530
Message-ID: <CAK-LDb+bHn4QWowDHL=XWYSB+ETzspc49j+1Q9o7Tz0zETZM0A@mail.gmail.com>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
 <CAK-LDb+i8ATb5GrA6=dx5Y6EZSct+A6epXwNdEoVN4797Yzmqw@mail.gmail.com>
 <20141229155357.GL17800@sirena.org.uk>
 <CAK-LDb+KCWHz7A5im7cB=dQfCs8ioh2T+jsxk9PdAFHNSOuvzg@mail.gmail.com>
 <20141229165734.GA17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 21F362614E3
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 18:19:13 +0100 (CET)
Received: by mail-wg0-f51.google.com with SMTP id x12so19296723wgg.38
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 09:19:12 -0800 (PST)
In-Reply-To: <20141229165734.GA17800@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 29, 2014 10:27 PM, "Mark Brown" <broonie@kernel.org> wrote:
>
> On Mon, Dec 29, 2014 at 10:00:13PM +0530, Vaishali Thakkar wrote:
> > On Mon, Dec 29, 2014 at 9:23 PM, Mark Brown <broonie@kernel.org> wrote:
>
> > > You sent this on the 26th, two days later on the 28th you're
demanding a
> > > review and complaining that we've missed this with a top posted quote.
> > > Even during a normal working period this would not be a reasnoable
> > > demand (a couple of weeks is normally a good *lower* limit, people
have
> > > vacations and other things to do), and right now we're in the middle
of
> > > the time of year when people from western societies typically take
> > > vacation.
>
> > I am really very sorry for this. Actually I am a newbie. I mainly
> > worked during opw-application period and there we used to work with
> > staging directory only. This is my first time, I am working with other
> > parts of kernel. So, I had kind of feeling that I might have done
> > something wrong that's why I am not getting any comments. But I think
> > its my fault. I may need to understand workflow of community properly
> > and I apologizes for that.
>
> Basically you should be allowing something measured in weeks to get a
> response rather than days unless there's some ultra critical issue -
> people might be busy, on vacation or whatever.  Different parts of the
> kernel will have different working patterns and rules of thumb but in
> general be patient, try to leave it for a few weeks before doing
> anything unless you realise that there's some problem (eg, you forgot to
> CC someone or you spot a mistake yourself in which case do a new version
> fixing that mistake).  If it's just been a week or two people might just
> be busy.

Ok. I got your point. This makes sense. Ill keep these things in my mind
and will follow it.
Also, thanks for your reply.It makes me realize my mistake and got to learn
about common working pattern of kernel community. :-)
