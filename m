From: "Assaf Hoffman" <hoffman@marvell.com>
Subject: Re: PCM format 20 bit
Date: Mon, 23 Oct 2006 10:12:55 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41EC8431@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
The 20 bits are located in the low 20-bits of the 32-bit word (like
SNDRV_PCM_FORMAT_x24_xE where the 24-bit sample is located in the low
24-bits in 32-bit word.
Thanks.

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz] 
Sent: Monday, October 23, 2006 8:43 AM
To: Assaf Hoffman
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] PCM format 20 bit

On Mon, 23 Oct 2006, Assaf Hoffman wrote:

> Thank you, for your answer.
> I do not understand how does it work? Obviously, the ALSA stack does
not
> have such format, and by trying to extract the buffer (capture
example)
> the stack will assume 32-bit sample width, getting trash on the lower
12
> bits.

Could you describe exactly the location for 20-bit samples (use a 
byte table) in the DMA buffer, as your hw expects it? It's not obvious 
from your question.

						Jaroslav

> -----Original Message-----
> From: Giuliano Pochini [mailto:pochini@shiny.it] 
> Sent: Sunday, October 22, 2006 8:56 PM
> To: Assaf Hoffman
> Cc: alsa-devel@lists.sourceforge.net; Rita Shtern
> Subject: Re: [Alsa-devel] PCM format 20 bit
> Importance: Low
> 
> On Sun, 22 Oct 2006 18:11:55 +0200
> "Assaf Hoffman" <hoffman@marvell.com> wrote:
> 
> > My HW supports 20-bit sample using 32-bit phy frame. As I
understand,
> > the only way the ALSA supports the 20-bit sample is 24-bit frame
> > (SNDRV_PCM_FORMAT_x20_3xE).
> >
> > Please advice.
> 
> If it's 20 bits left-aligned in 32 bits, you can use S32_LE or similar
> formats. For example the old echoaudio cards based on the DSP 56301
use
> S32_LE but only the upper 20 bits contain data.
> 
> 
> --
> Giuliano.
> 
>
------------------------------------------------------------------------
-
> Using Tomcat but need to do more? Need to support web services,
security?
> Get stuff done quickly with pre-integrated technology to make your job
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
>
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
