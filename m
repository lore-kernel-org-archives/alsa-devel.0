From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Re: Digital sound card conventions
Date: Fri, 3 Jan 2003 23:03:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301032303.50790.torger@ludd.luth.se>
References: <200301032139.WAA08066@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA08432
	for <alsa-devel@alsa-project.org>; Fri, 3 Jan 2003 23:04:23 +0100
In-Reply-To: <200301032139.WAA08066@alsa.alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 03 January 2003 22.47, Paul Davis wrote:
> >This part of PCM API has not been discussed. I think that we should
> > follow the most easy way: It is - allow only sample rate given by
> > application, if the master clock is using another sample rate - in
> > trigger() callback - driver will fail.
>
> this seems wrong to me. what should fail is an attempt to set the
> sample rate unless the hardware is its own clock Master. if no
> attempt is made to set it, then the application gets whatever the
> hardware is running at, whether that is externally controlled or some
> h/w specific default.

An attempt to set it to the sample rate that happens be the correct one 
should be ok, at least I think so.

So, your suggestion is, that for capture, always state the full hardware 
capability (in hwparams), but fail if incorrect the settings are made? 
I think that is ok too, but currently I'm narrowing down the hwparams 
to fit what is available at the input when the sound card is opened (of 
course, that could have changed until the sound card is started, but it 
is quite unlikely).

I think both approaches are ok, but narrowing down the alternatives I 
think is more nice to the applications. My guess is that the common use 
of a digital sound card is that the input signal is not changed too 
often, and then it is nice if the software gets the correct 
capabilities, so those applications that think that all sound cards are 
analog will work in the expected way anyway.

> >		   Also it will fail, when sample rate is changed during
> >operation.
>
> the hammerfall driver used to contain stubs for doing this. every
> read/write operation would check that the (possibly externally
> controlled) SR was the same as "last time". i never did any more on
> this.

Uhmm... I don't think I will include changed sample rate / format 
callback stuff for now, because I don't know how to implement it. 
However, if there is a good example which I could imitate, let me know.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
