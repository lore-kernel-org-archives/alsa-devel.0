From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: re.Fix hang in mpu401_uart.c patch
Date: Sat, 13 May 2006 13:04:49 +0100
Message-ID: <200605131304.49711.gineera@aspect135.co.uk>
References: <200605101556.50928.gineera@aspect135.co.uk> <s5hejz03baa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hejz03baa.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 11 May 2006 15:07, you wrote:
> At Wed, 10 May 2006 16:10:41 +0100,
>
> Alan Horstmann wrote:
> > This patch since 1.0.11 throws up an underlying problem with au88x0
> > (separate posting refers), but I also noticed that the 4th hunk applys
> > changes to snd_mpu401_uart_input_close and snd_mpu401_uart_output_close.
> >
> > However, as the 3rd augument is '0' ie don't check ACK, OK is always true
> > in snd_mpu401_uart_cmd and there is surely no point to the extra check
> > lines?
> >
> > (As my separate posting 'au88x0_mpu401 init / fail first open' mentions,
> > ACK is not returned from the RESET during the close, either with ice1712
> > or au8820, so can't be checked for.)
>
> Which patch are you referring to??

The one titled  'Fix hang in mpu401_uart.c',  on repo about 2 weeks ago, by 
Jon Masters.

Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
