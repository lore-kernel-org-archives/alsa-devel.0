From: "Marc Brooker" <marcbrooker@gmail.com>
Subject: Re: Sample Rate Conversion Quality in ALSA
Date: Mon, 21 Aug 2006 15:02:07 +0200
Message-ID: <b5ee41f40608210602q4c4ae45eo5be8392be7e96099@mail.gmail.com>
References: <b5ee41f40608210316t562c803eye73701c75904627@mail.gmail.com>
	<44E9AAFA.2060400@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44E9AAFA.2060400@superbug.co.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 8/21/06, James Courtier-Dutton <James@superbug.co.uk> wrote:
> Marc Brooker wrote:
> > Hello,
> >
> > I am new to the ALSA development, and would be interested in
> > contributing in future.
> >
> > After installing the latest Ubuntu on my home machine, I noticed that
> > dmix is enabled by default. This is a very good move in my opinion, as
> > it makes Linux sound much more transparent to the end user. However, I
> > was concerned with the quality of the mixing algorithm and sample rate
> > conversion used by dmix.
> >
> >
> > Cheers
> >
> > Marc Brooker
> >
> The problem is actually far more complicated than you described. A fair
> amount of ALSA core will have to be modified to really fix the problem.
> The main problem is the buffer and period sized as they pass through dmix.
> For example, if the sound card hardware is running with 1024 samples per
> period at 48000, and an application wished to use a sample rate of
> 44100, the application should really get 940.8 samples per period. That
> is nor possible, so the application gets 940. dmix then tries to convert
> 940 samples to 1024 samples ready for the hardware. So, even if the dmix
> algorithm used the super high quality sample rate conversion function,
> the actual rate change applied would still be slightly off.
>
> James
>
>

James

Let me see if I understand you correctly. In the scenario that you
presented the application is told that there are 940 samples per
period. ALSA, internally, converts these to 1024 samples per period at
48kHz sample rate. So the material (sampled at 44100Hz) is played back
at a rate of 44062Hz? I don't know enough about the field to know if
this error (0.08%) will be audible.

There doesn't seem (at first glance, my knowledge of the ALSA source
is limited) to be an easy solution to this problem. It might be naive,
but wouldn't it be better to report 941 as the buffer size to the
application - this way the error is smaller (but still not gone).

It seems to me that using a higher quality SRC function would lead to
some improvement in playback quality.

Cheers

Marc

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
