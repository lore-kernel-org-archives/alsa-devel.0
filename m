From: torbenh <torbenh@gmx.de>
Subject: Re: alsa jack plugin
Date: Fri, 19 Nov 2010 14:15:54 +0100
Message-ID: <20101119131553.GE4646@siel.b>
References: <20101108092647.GS4410@siel.b> <20101110101846.GD4238@siel.b>
	<1289513517.16615.10.camel@mattotaupa>
	<AANLkTimhZwngrTHdA5ZAwJWyd6-UHt-NpFqAvgZViFTX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id C3184103945
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 14:15:55 +0100 (CET)
Received: from torbenh by siel.b with local (Exim 4.72)
	(envelope-from <torbenh@gmx.de>) id 1PJQok-00067s-0X
	for alsa-devel@alsa-project.org; Fri, 19 Nov 2010 14:15:54 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTimhZwngrTHdA5ZAwJWyd6-UHt-NpFqAvgZViFTX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 17, 2010 at 03:16:32PM +0800, Raymond Yau wrote:
> 2010/11/12 Paul Menzel <paulepanter@users.sourceforge.net>
> 
> > Am Mittwoch, den 10.11.2010, 11:18 +0100 schrieb torbenh:
> > > On Mon, Nov 08, 2010 at 10:26:47AM +0100, torbenh wrote:
> > > >
> > > > the alsa jack plugin has quite some problems:
> > > > a) does not work correctly with mplayers alsa output. (and quite a few
> > > >    others)
> >
> 
> AFAIK, mplayer , aplay and the alsa-jack plugin 1.0.1still working with
> jack-0.118
> 
> So you have to tell the jack plugin fail to work from  from which version of
> jack if jack change the protocol

jack did not change the protocoll.

however, the write to the socket fd might block.
doing potentially blocking things in jacks process callback is not
legal. (this kind of problems only show under low-latency situations,
period_size of 128 and lower)

the result of the blocking write is jack kicking the client.
and just making the fd NONBLOCK, "fixed" the problem.
(it seems to cause some other problems down the road, since some
 bytes written to the fd get lost)

i would really like to exchange the socket for a signalfd.
increasing the signal count of the fd would never block.

(but i am not sure about the requirements, signalfd only exists since
 2.6.27, and i am not sure, if the old socket based code should be left
 in there as a fallback)



> 
> The current Documentation of jack plugin "doc/README-jack" has a mistake
> 
> 
>          pcm.jack {
>                  type jack
>                  playback_ports {
>                          0 alsa_pcm:playback_1
> -                         1 alsa_pcm:playback_1
> +                        1 alsa_pcm:playback_2
>                  }
>                  capture_ports {
>                          0 alsa_pcm:capture_1
> -                        1 alsa_pcm:pcapture_1
> +                        1 alsa_pcm:pcapture_2
>                   }
>          }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
torben Hohn
