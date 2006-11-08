From: Sampo Savolainen <v2@iki.fi>
Subject: Re: Using driver service from another driver
Date: Thu, 09 Nov 2006 00:16:46 +0200
Message-ID: <1163024206.7355.4.camel@mustis>
References: <4550BFBA.6050400@gmail.com> <s5hwt65vs3i.wl%tiwai@suse.de>
	<45520538.2090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45520538.2090001@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Himanshu Chauhan <hs.chauhan@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-11-08 at 21:56 +0530, Himanshu Chauhan wrote:
> Okay. I am writing a dummy driver from which the application play and
> record.
> Suppose, mplayer is playing some movie and the audio is going to this dummy
> driver and Audacity is running which is recording from this dummy driver
>  (the stream coming from mplayer). But as no actual device is there, user
> can't listen to what is being played or recorded. I want a playthru like
> thing
> so that whatever data audacity is getting for recording can also be
> directed to an actual sound card driver from within the kernel.
> So that user can listen to whatever is being played by mplayer and
> is being recorded by audacity.

For inter-application audio plumbing, jackd (http://www.jackaudio.org)
is the way to go.

And for exporting audio out of mplayer:

 mplayer -ao pcm:file=out.wav -vo null [inputfile]


I'd say writing a device driver to do this task is like trying to squash
a fly with an expensive vase.


  Sampo



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
