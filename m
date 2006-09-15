From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: ALSA compatibility to WM8750 codec and MPlayer!
Date: Fri, 15 Sep 2006 11:46:21 +0100
Message-ID: <1158317181.22950.36.camel@localhost.localdomain>
References: <20060915104019.63026.qmail@web8512.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060915104019.63026.qmail@web8512.mail.in.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "D. Krishna Mohan" <krishna_danim@yahoo.co.in>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Seems I missed my previous reply to the list.

On Fri, 2006-09-15 at 11:40 +0100, D. Krishna Mohan wrote:
> Hi,
>    Ok my understanding from what u said is that MPlayer will be
> interacting with alsa-lib part of ALSA and alsa-kernel will inturn
> interact with Device Drivers (i2c that will operate on WM8750) .
> Considering ALSA is divided into 2 parts alsa-lib and alsa-kernel.
>  

Yes.

> Also suggest me a tutorial that can give me best understanding of
> MPlayer's interfaces to alsa-lib and ALSA interfaces to both MPlayer
> and DD.
>  

Alsa documentation and tutorials can be found here:-

http://alsa-project.org/documentation.php


Btw, what is DD ?

Liam

> -KM
> 
> Liam Girdwood <liam.girdwood@wolfsonmicro.com> wrote:
>         On Fri, 2006-09-15 at 11:24 +0100, D. Krishna Mohan wrote:
>         > Hi,
>         > That was very much of the information,Thanx.
>         > Do we really need ALSA to bring audio out from WM8750 Audio
>         codec. My
>         > requirement is i have to use MPlayer to play audio and get
>         the audio
>         > and its control from WM8750 Audio Codec. Is it possible
>         without ALSA??
>         > 
>         
>         ALSA _is_ required to get audio playback, capture and control
>         of the
>         WM8750 mixers. Mplayer cannot do this directly to the
>         hardware.
>         
>         Liam
>         
> 
> 
> 
> 
> ______________________________________________________________________
> Find out what India is talking about on - Yahoo! Answers India 
> Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8.
> Get it NOW 
> ________________________________________________________________________
> This email has been scanned for all viruses by the MessageLabs Email
> Security System. 
> ________________________________________________________________________


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
