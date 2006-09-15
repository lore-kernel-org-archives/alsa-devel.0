From: Junji Umeno <umeno@elwsc.co.jp>
Subject: Re: Does it need full-duplex to use snd_pcm_link ?
Date: Fri, 15 Sep 2006 16:33:08 +0900
Message-ID: <20060915163308.40523955@localhost.localdomain>
References: <20060915145400.57815d0c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060915145400.57815d0c@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Fri, 15 Sep 2006 14:54:00 +0900
Junji Umeno <umeno@elwsc.co.jp> wrote:

> I failed to record with the example code 'latency.c' written in the doxygen manual.
> When it plays back and records at the same time, using snd_pcm_link,
> should the hardware be implemented as full-duplex of i/o?
> As previous comments pointed in this lists,
> some buffer length data are written into a playback handler,
> and then reading starts.
> They said, it should be needed to have 4096 bytes written in the write buffer.
> But in my case, 
> 'writei' continues to return EAGAIN if more than 64byte are to be written.
> 
> Any comment is welcom.
> -- 
> UMENO, Junji
> ElmicWescom, Inc.
> 

Does it depend on the device's read/write buffer size, wchich is set by 'snd_pcm_hw_params_set_rate' ?

-- 
UMENO, Junji
ElmicWescom, Inc.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
