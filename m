From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Software mixing according to priority of streams
Date: Sat, 16 Jun 2007 00:03:09 +0530
Message-ID: <8d6898730706151133x1115d4afyc8522b24b94c07b3@mail.gmail.com>
References: <8d6898730706150110m35fdfb59m6961aa25d0fcc3b3@mail.gmail.com>
	<8d6898730706150400h6126ec15sae1694b80b47ad53@mail.gmail.com>
	<75b66ecd0706151112h663009ub99740d026c168a6@mail.gmail.com>
	<8d6898730706151116s631893e1ja083f861c80d07cb@mail.gmail.com>
	<d35cec70706151127y42671bc6ydae440bce554523b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 992A924835
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 20:33:11 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so941190nzf
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 11:33:10 -0700 (PDT)
In-Reply-To: <d35cec70706151127y42671bc6ydae440bce554523b@mail.gmail.com>
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
To: Seth Forshee <seth.forshee@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

yes this is what i need

On 6/15/07, Seth Forshee <seth.forshee@gmail.com> wrote:
> Hi Nobin,
>
> On 6/15/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > A sound server can do this
> >
> > Maintain a buffer per application ,
> > and each buffer will have priority. when data comes on higher priority
> > buffer stop taking data from low priority buffer, and configure the
> > audio and start pumping data from high priority buffer.
> >
>
> Not to stray too far OT here, but take a look at the message in the
> link below from the PulseAudio mailing list.  Sounds like the type of
> thing you're looking for (although I don't think any patches have been
> submitted yet).
>
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2007-May/000389.html
>
> Cheers,
> Seth
>
