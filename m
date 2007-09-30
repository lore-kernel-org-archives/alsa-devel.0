From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: nforce ac97 plays too fast
Date: Sat, 29 Sep 2007 21:51:54 -0400
Message-ID: <75b66ecd0709291851g47007518n48035588b5ffecef@mail.gmail.com>
References: <46FE0428.1070501@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 527F22452A
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Sep 2007 03:51:56 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so2162933nzf
	for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2007 18:51:55 -0700 (PDT)
In-Reply-To: <46FE0428.1070501@aknet.ru>
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
To: Stas Sergeev <stsp@aknet.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/29/07, Stas Sergeev <stsp@aknet.ru> wrote:
> Hello.
>
> Trying to get a software amplification to
> work with NForce CK804 AC'97, I've found
> out that whatever the asound.conf I write,
> the sound starts playing much faster than
> it should.
> After some debugging, I've found out the
> following:
> - The card (or the driver) only supports
> 48000KHz.
> - The program (any, because libao and artsd
> suffer from that) is trying to set some
> rate with snd_pcm_hw_params_set_rate_near(),
> and that succeeds, but the returned rate
> is 48000, while the requested is, say, 22050.
> No wonder it then plays with the wrong speed.
> Of course the program can check the returned
> rate, but it sets the "direction" parameter
> to 0, which should mean "take exactly that
> value".
> I've looked into an alsa-tutorial, and the
> examples there do not check the returned
> rate too - dir==0 should be enough.

What ALSA tutorial are you looking at?  All the ones I am familiar
with state that you must check the returned rate.  Direction is just a
hint.

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html#ga3602c3c8912acf66c4db29f96608021

For example:

http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html#a18
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2latency_8c-example.html#a12
http://www.suse.de/~mana/alsa090_howto.html

Lee
